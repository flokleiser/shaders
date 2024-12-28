precision mediump float;

uniform vec2 uResolution;
uniform float u_time;

void main(void) {
    //uv mango
    vec2 uv = gl_FragCoord.xy / uResolution;
    vec3 color = vec3(uv.x, uv.y, uv.x * uv.y);
    gl_FragColor = vec4(color, 1.0);

    // float time = abs(sin(u_time));
    // gl_FragColor = vec4(0.0,time,0.0, 1.0);
}

