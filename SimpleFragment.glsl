precision mediump float;

varying lowp vec4 DestinationColor;
  
varying lowp vec2 TexCoordOut;
uniform sampler2D Texture;
uniform sampler2D lightMap;

void main(void) {
    vec4 baseColor;
    vec4 lightColor;
    baseColor = texture2D(Texture, TexCoordOut);
    lightColor = texture2D(lightMap, TexCoordOut);
    gl_FragColor = baseColor * (lightColor + 0.25);
}
