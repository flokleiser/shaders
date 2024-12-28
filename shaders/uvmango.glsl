#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;

void main(void) {
    vec2 uv = gl_FragCoord.xy / u_resolution;
    vec3 color = vec3(uv.x, uv.y, uv.x * uv.y);
    gl_FragColor = vec4(color, 1.0);
}
