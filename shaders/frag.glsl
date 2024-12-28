precision mediump float;

uniform vec2 uResolution;
uniform float u_time;

void main(void) {
    //uv mango
    vec2 uv = gl_FragCoord.xy / uResolution;
    // vec3 color = vec3(uv.x, uv.y, uv.x * uv.y);
    // gl_FragColor = vec4(color, 1.0);
    float time = abs(sin(u_time));
    // gl_FragColor = vec4(abs(sin(u_time)), 1.0, 1.0, 0.5);
    gl_FragColor = vec4(time, 0.0, 0.0, 1.0);
}

