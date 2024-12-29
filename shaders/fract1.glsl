#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;
uniform vec4 u_mouse;

vec3 palette( float t) {
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(0.0, 1.0, 1.0);
    vec3 d = vec3(0.4, 0.4, 0.1);
    
    return a+b*cos( 6.28318*(c*t*d) );
}

void main()
{
    vec2 uv = (gl_FragCoord.xy * 2.0 - u_resolution.xy) / u_resolution.y;
    vec2 uv0 = uv;
    vec3 finalColor = vec3(0.0);
    
    for (float i = 0.0; i < 2.0; i++) {
    
        uv = fract(uv0 / uv) - 0.5;

        float d = length(uv) * exp(-length(uv0));

        vec3 col = palette(length(uv0) + i*.3 +u_time*.7);
        d = sin(d*7.0 + u_time*.9)/8.0;
        d = abs(d);

        d = pow(0.006 / d, 1.2);

        finalColor += col *= d;

        gl_FragColor = vec4(finalColor, 0.3);
    }
    
}