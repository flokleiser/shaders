#version 300 es
precision mediump float;

uniform vec2 u_resolution;
uniform float u_time;
uniform vec4 u_mouse;
uniform float u_audio[64];

out vec4 fragColor;

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution;
    int band = int(floor(uv.x * 64.0));
    float amp = u_audio[band];

    float height = amp;
    vec3 color = uv.y < height
        ? vec3(uv.x, amp, 1.0 - uv.x) : vec3(0.0);

    fragColor = vec4(color, 1.0);
}
