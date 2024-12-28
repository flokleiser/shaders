#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

void main(void) {
    vec2 uv = gl_FragCoord.xy / u_resolution;
    float time = abs(sin(u_time));
    gl_FragColor = vec4(0.0,time,0.0, 1.0);
}
