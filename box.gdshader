shader_type canvas_item;

vec4 premult_mix(vec4 color1, vec4 color2, float t) {
    vec3 premul1 = color1.rgb * color1.a;
    vec3 premul2 = color2.rgb * color2.a;

    vec3 rgb = mix(premul1, premul2, t);
    float a = mix(color1.a, color2.a, t);

    rgb = (a > 0.0) ? rgb / a : vec3(0.0);

    return vec4(rgb, a);
}

float box(vec2 position, vec2 halfSize, float cornerRadius) {
    position = abs(position) - halfSize + cornerRadius;
    return length(max(position, 0.0)) + min(max(position.x, position.y), 0.0) - cornerRadius;
}

varying flat int id;
void vertex() {
    id = INSTANCE_ID;
}

const int TypeNames_STATIC_RECT_BORDER = 0, TypeNames_STATIC_RECT_INSIDE = 1;
const int TypeNames_STATIC_CIRC_BORDER = 2, TypeNames_STATIC_CIRC_INSIDE = 3;
const int TypeNames_DYNAMIC_RECT_BORDER = 4, TypeNames_DYNAMIC_RECT_INSIDE = 5;
const int TypeNames_DYNAMIC_CIRC_BORDER = 6, TypeNames_DYNAMIC_CIRC_INSIDE = 7;
const int TypeNames_GP_RECT_BORDER = 8, TypeNames_GP_RECT_INSIDE = 9;
const int TypeNames_GP_CIRC_BORDER = 10, TypeNames_GP_CIRC_INSIDE = 11;
const int TypeNames_WOOD_BORDER = 12, TypeNames_WOOD_INSIDE = 13;
const int TypeNames_WATER_BORDER = 14, TypeNames_WATER_INSIDE = 15;
const int TypeNames_CW_BORDER = 16, TypeNames_CW_INSIDE = 17, TypeNames_CW_DECAL = 18;
const int TypeNames_CCW_BORDER = 19, TypeNames_CCW_INSIDE = 20, TypeNames_CCW_DECAL = 21;
const int TypeNames_UPW_BORDER = 22, TypeNames_UPW_INSIDE = 23, TypeNames_UPW_DECAL = 24;
const int TypeNames_BUILD_BORDER = 25, TypeNames_BUILD_INSIDE = 26;
const int TypeNames_GOAL_BORDER = 27, TypeNames_GOAL_INSIDE = 28;
const int TypeNames_JOINT_NORMAL_BORDER = 29, TypeNames_JOINT_WHEEL_CENTER_BORDER = 30;
const int TypeNames_SIZE = 31;

uniform vec4[TypeNames_SIZE] colorsGlobal;
uniform float[TypeNames_SIZE] cornerRadiiGlobal;
uniform float[TypeNames_SIZE] borderThicknessesGlobal; //TODO: figure out if this is needed

instance uniform float scale;
const int layers = 3;
instance uniform int layerID;

uniform sampler2D[layers] data;

void fragment() {
    vec4 idDataF = texelFetch(data[layerID], ivec2(id % 128, id / 128), 0);
    uvec4 idDataU = uvec4(floatBitsToUint(idDataF[0]), floatBitsToUint(idDataF[1]), floatBitsToUint(idDataF[2]), floatBitsToUint(idDataF[3]));

    const uint mask = 0xFFFFFFu;
    uvec2 sizeU = uvec2(idDataU[0] >> 8u, (idDataU[0] << 16u | idDataU[1] >> 16u) & mask);
    uvec2 centerU = uvec2((idDataU[1] << 8u | idDataU[2] >> 24u) & mask, idDataU[2] & mask);
    vec2 size = vec2(float(sizeU.x) / 16., float(sizeU.y) / 16.);
    vec2 center = vec2(float(centerU.x) / 16., float(centerU.y) / 16.);
    int type = int(idDataU[3]);

    const vec4 outsideColor = vec4(0.);
    vec4 borderColor;
    vec4 insideColor;
    float cornerRadius;
    float borderThickness;

    switch(type) {
        case TypeNames_STATIC_RECT_BORDER: //rect borders
        case TypeNames_DYNAMIC_RECT_BORDER:
        case TypeNames_GP_RECT_BORDER:
        case TypeNames_WOOD_BORDER:
        case TypeNames_WATER_BORDER:
        case TypeNames_BUILD_BORDER:
        case TypeNames_GOAL_BORDER:
            borderColor = colorsGlobal[type];
            insideColor = borderColor;
            cornerRadius = cornerRadiiGlobal[type] * scale;
            borderThickness = 0. * scale;
            break;
        case TypeNames_STATIC_RECT_INSIDE: //rect insides
        case TypeNames_DYNAMIC_RECT_INSIDE:
        case TypeNames_GP_RECT_INSIDE:
        case TypeNames_WOOD_INSIDE:
        case TypeNames_WATER_INSIDE:
        case TypeNames_BUILD_INSIDE:
        case TypeNames_GOAL_INSIDE:
            borderColor = colorsGlobal[type];
            insideColor = borderColor;
            cornerRadius = 0. * scale;
            borderThickness = 0. * scale;
            break;
        case TypeNames_STATIC_CIRC_BORDER: //filled circles
        case TypeNames_STATIC_CIRC_INSIDE:
        case TypeNames_DYNAMIC_CIRC_BORDER:
        case TypeNames_DYNAMIC_CIRC_INSIDE:
        case TypeNames_GP_CIRC_BORDER:
        case TypeNames_GP_CIRC_INSIDE:
        case TypeNames_CW_BORDER:
        case TypeNames_CW_INSIDE:
        case TypeNames_CCW_BORDER:
        case TypeNames_CCW_INSIDE:
        case TypeNames_UPW_BORDER:
        case TypeNames_UPW_INSIDE:
            borderColor = colorsGlobal[type];
            insideColor = borderColor;
            cornerRadius = size.x / 2.; //should be equal to size.y because this is a circle
            borderThickness = 0.;
            break;
        case TypeNames_JOINT_NORMAL_BORDER: //hollow circles
        case TypeNames_JOINT_WHEEL_CENTER_BORDER:
            borderColor = colorsGlobal[type];
            insideColor = vec4(0.);
            cornerRadius = size.x / 2.; //should be equal to size.y because this is a circle
            borderThickness = borderThicknessesGlobal[type] * scale;
            break;
        default: //TODO: implement decals
            break;
    }

    vec2 pixelPos = size * UV;
    float d = box(pixelPos - center, size / 2., cornerRadius);

    //TODO: make this antialias half and half pixels (i will know what this means)
    if(d > 0.) {
        COLOR = vec4(0);
    } else if(d > -1.) {
        COLOR = premult_mix(borderColor, outsideColor, d - -1.);
    } else if(d > -borderThickness) {
        COLOR = borderColor;
    } else if(d > -borderThickness - 1.) {
        COLOR = premult_mix(insideColor, borderColor, d - (-borderThickness - 1.));
    } else {
        COLOR = insideColor;
    }
}