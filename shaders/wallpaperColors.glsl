#ifdef GL_ES
precision mediump float;
#endif

uniform vec2      u_resolution;           
uniform float     u_time;                 

vec3 palette(float t) {
    // vec3 a = vec3(0.5, 0.5, 0.5);
    // vec3 b = vec3(0.5, 0.5, 0.5);
    // vec3 c = vec3(1.0, 1.0, 1.0);
    // vec3 d = vec3(0.263, 0.416, 0.557);
    vec3 a = vec3(1.0, 1.0, 1.0);
    vec3 b = vec3(1.0, 1.0, 1.0);
    vec3 c = vec3(1.0, 1.0, 1.0);
    vec3 d = vec3(0.0, 0.0, 0.0);
    return a + b * cos(6.28318 * (c * t + d));
}

vec3 sin_shape(in vec2 uv, in float offset_y) {
    float y = sin((uv.x + u_time * -0.06 + offset_y) * 5.5);

    float x = uv.x * 8.;
    float a = 1.0;
    for (int i = 0; i < 5; i++) {
        x *= 0.53562;
        x += 6.56248;
        y += sin(x) * a;		
        a *= 0.5;
    }

    float y0 = step(0.0, y * 0.08 - uv.y + offset_y);
    return vec3(y0, y0, y0);
}

vec2 rotate(vec2 coord, float alpha) {
    float cosA = cos(alpha);
    float sinA = sin(alpha);
    return vec2(coord.x * cosA - coord.y * sinA, coord.x * sinA + coord.y * cosA);
}

vec3 scene(in vec2 uv) {
    vec3 col = vec3(0.0, 0.0, 0.0);
    col += sin_shape(uv, 0.3) * 0.2;
    col += sin_shape(uv, 0.7) * 0.2;
    col += sin_shape(uv, 1.1) * 0.2;

    // float t = uv.x + uv.y + u_time * 0.2; // Generate a time-varying parameter
    // vec3 paletteColor = palette(t);

    // Blend the palette color with the scene color
    // return mix(col, paletteColor, 0.5);
}

void main() {
    vec2 fragCoord = gl_FragCoord.xy;

    vec3 finalColor = vec3(0.0)

    fragCoord = rotate(fragCoord + vec2(0.0, -300.0), 0.5);

    vec3 col0 = scene((fragCoord * 2.0) / u_resolution.xy);
    vec3 col1 = scene(((fragCoord * 2.0) + vec2(1.0, 0.0)) / u_resolution.xy);
    vec3 col2 = scene(((fragCoord * 2.0) + vec2(1.0, 1.0)) / u_resolution.xy);
    vec3 col3 = scene(((fragCoord * 2.0) + vec2(0.0, 1.0)) / u_resolution.xy);


    // gl_FragColor = vec4((col0 + col1 + col2 + col3) / 4.0, 1.0);
    gl_FragColor = vec4(finalColor,0.3)
}
