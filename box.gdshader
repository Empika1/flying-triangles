shader_type canvas_item;

uniform vec4[32] colorsGlobal;
uniform float[7] cornerRadiiGlobal;
uniform float[16] borderThicknessesGlobal;
instance uniform float scale;

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

varying vec4 customData;
void vertex() {
    customData = INSTANCE_CUSTOM;
}

void fragment() {
    vec4 customColor = COLOR;
    uint customData0 = uint(int(customData[0]) + 2048);
    uint customData1 = uint(int(customData[1]) + 2048);
    uint customData2 = uint(int(customData[2]) + 2048);
    uint customData3 = uint(int(customData[3]) + 2048);

    vec2 size = vec2(customColor[0], customColor[1]);
    vec2 center = vec2(customColor[2], customColor[3]);
    uint cornerRadiusIndex = customData0;
    uint borderThicknessIndex = customData1;
    uint insideColorIndex = customData2;
    uint borderColorIndex = customData3;

    vec4 outsideColor = vec4(0);
    vec4 borderColor = colorsGlobal[borderColorIndex];
    vec4 insideColor = colorsGlobal[insideColorIndex];
    float cornerRadius = cornerRadiiGlobal[cornerRadiusIndex] * scale;
    float borderThickness = borderThicknessesGlobal[borderThicknessIndex] * scale;

    vec2 pixelPos = size * UV;
    float d = box(pixelPos - center, size / 2., cornerRadius);

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

    // COLOR = vec4(float(cornerRadiusIndex) / 10000., 0., 0., 1.);
}