#version 300 es
precision mediump float;

uniform vec2 u_resolution;
uniform float u_time;
uniform float u_audio[64];

out vec4 fragColor;

bool DEBUG = true;

float getAmplitude(int band) {
    float amp = u_audio[band];
    return amp;
}

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution;
    uv = uv * 2.0 - 1.0;
    uv.x *= u_resolution.x / u_resolution.y;

    vec3 col = vec3(0.0);
    float barCount = 64.0;

    for (int i = 0; i < 64; i++) {
        float x = (float(i) / barCount) * 2.0 - 1.0;
        float amp = getAmplitude(i);
        float width = 0.025;
        float dist = abs(uv.x - x);

        float height = amp * 1.5 + 0.05;
        float yTop = -1.0 + height;

        // float mask = smoothstep(width, 0.0, dist) * smoothstep(yTop, yTop - 0.05, uv.y);

        float mask = step(dist, width) * step(uv.y, yTop);

        if (DEBUG) {
            float hue = float(i) / barCount;
            vec3 debugColor = vec3(amp);
            // vec3 debugColor = vec3(hue, amp, 1.0 - amp);

            col += mask * debugColor;
        } else {
            col += mask * vec3(0.2 + amp, 0.5 + amp * 0.5, 1.0);
        }
    }

    fragColor = vec4(col, 1.0);
}
