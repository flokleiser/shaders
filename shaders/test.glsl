#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution; // Screen resolution
uniform float u_time;      // Animation time

// Function to create a smooth gradient
vec3 gradient(vec2 uv) {
    float t = uv.y; // Interpolating value
    return mix(vec3(0.2, 0.1, 0.5), vec3(0.9, 0.4, 0.8), t); // Purple-pink gradient
}

// Function to create wavy layers
float waveLayer(vec2 uv, float speed, float offset, float amplitude) {
    return sin(uv.x * 10.0 + u_time * speed + offset) * amplitude;
}

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution; // Normalize coordinates (0-1)
    
    // Create the gradient background
    vec3 color = gradient(uv);
    
    // Add wavy layers
    float layer1 = waveLayer(uv, 0.3, 0.0, 0.05);
    float layer2 = waveLayer(uv, 0.6, 2.0, 0.03);
    float layer3 = waveLayer(uv, 0.9, 4.0, 0.02);
    
    // Blend layers into the gradient
    color += vec3(layer1, layer2, layer3) * 0.1; // Subtle blending for layers

    gl_FragColor = vec4(color, 1.0);
}
