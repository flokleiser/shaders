#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

vec3 gradient(vec2 uv) {
    float t = uv.y;
    return mix(vec3(0.2, 0.1, 0.5), vec3(0.9, 0.4, 0.8), t);
}

float waveLayer(vec2 uv, float speed, float offset, float amplitude) {
    return sin(uv.x * 10.0 + u_time * speed + offset) * amplitude;
}

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution; 
    
    vec3 color = gradient(uv);
    
    float layer1 = waveLayer(uv, 0.3, 0.0, 0.05);
    float layer2 = waveLayer(uv, 0.6, 2.0, 0.03);
    float layer3 = waveLayer(uv, 0.9, 4.0, 0.02);
    
    color += vec3(layer1, layer2, layer3) * 0.1;

    gl_FragColor = vec4(color, 1.0);
}
