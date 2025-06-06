shader_type canvas_item;

uniform float borderWidthGlobal;
uniform float cornerRadiusGlobal;
uniform vec4[16] colorsGlobal;

float box(vec2 position, vec2 halfSize, float cornerRadius) {
   position = abs(position) - halfSize + cornerRadius;
   return length(max(position, 0.0)) + min(max(position.x, position.y), 0.0) - cornerRadius;
}

varying vec4 customData;
void vertex() {
	customData = INSTANCE_CUSTOM;
}

const float epsilon = 1. / 64.;
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
	if(d > 0.) {
		COLOR = vec4(0);
	} else if(d > -borderWidthGlobal) {
		COLOR = colorsGlobal[borderColorIndex];
	} else {
		COLOR = colorsGlobal[insideColorIndex];
	}
}