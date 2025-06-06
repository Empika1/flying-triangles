shader_type canvas_item;

uniform float borderWidthGlobal;
uniform float cornerRadiusGlobal;
uniform vec4[16] colorsGlobal;

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
	vec2 meshSize = vec2(customColor[0], customColor[1]);
	vec2 rectSize = vec2(customColor[2], customColor[3]);
	vec2 rectCenter = vec2(customData[0], customData[1]);
	int insideColorIndex = int(customData[2]) / 256;
	int borderColorIndex = int(customData[2]) % 256;
	
	vec2 pixelPos = meshSize * UV;
	//COLOR = vec4(pixelPos.x / 128., pixelPos.y / 256., 1., 1.);
	float d = box(pixelPos - rectCenter, rectSize / 2., cornerRadiusGlobal);
	
	vec4 outsideColor = vec4(0);
	vec4 borderColor = colorsGlobal[borderColorIndex];
	vec4 insideColor = colorsGlobal[insideColorIndex];
	if(d > 0.) {
		COLOR = vec4(0);
	} else if(d > -1.) {
		COLOR = premult_mix(borderColor, outsideColor, d - -1.);
	} else if(d > -borderWidthGlobal) {
		COLOR = borderColor;
	} else if(d > -borderWidthGlobal - 1.) {
		COLOR = premult_mix(insideColor, borderColor, d - (-borderWidthGlobal - 1.));
	} else {
		COLOR = insideColor;
	}
}