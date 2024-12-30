#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;
uniform vec4 u_mouse;

//old palette
vec3 palette( float t) {
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(0.0, 1.0, 1.0);
    vec3 d = vec3(0.4, 0.4, 0.1);
    
    return a+b*cos( 6.28318*(c*t*d) );
}

//white
// vec3 palette( float t) {
//     vec3 a = vec3(1.0, 1.0, 1.0);
//     vec3 b = vec3(1.0, 1.0, 1.0);
//     vec3 c = vec3(1.0, 1.0, 1.0);
//     // vec3 d = vec3(0.0, 0.0, 0.0);

//     vec3 d = vec3(u_mouse.x / u_resolution.x, u_mouse.y / u_resolution.y, 0.0); 
    
//     // return a+b*sin(c*t*d);
//     return a+b*cos( 6.28318*(c*t*d) );
//     // return d;
// }

void main()
{
    vec2 uv = (gl_FragCoord.xy * 1.5 - 0.75*u_resolution.xy) / u_resolution.y;

    // vec2 uv = (gl_FragCoord.xy + u_resolution.xy) / u_resolution.y;
    vec2 uv0 = uv;
    vec3 finalColor = vec3(0.0);
    
    // for (float i = 0.0; i < 2.0; i++) {
    for (float i = 0.0; i < 1.0; i++) {
    
        // uv = fract(uv0 / uv) - 0.5;
        // uv = fract(uv0 - uv) - 1.5;
        uv = fract(uv0 - uv) - 1.5;

        float d = length(uv) * exp(-length(uv0));
        // float d = length(uv-2.0*uv0) * exp(-length(2.0*uv0));

        // vec3 col = palette(length(uv0) + i*.3 +u_time*.7);
        vec3 col = palette(length(uv0) + i +u_time*0.5);

        // d = sin(d*7.0 + u_time*.9)/8.0;
        // d = abs(d);

        d = sin(d*10.0 + u_time*3.0)/20.0;
        d = abs(d);

        // d = pow(0.006 / d, 1.2);
        d = pow(0.006 / d, 1.0);

        finalColor += col *= d;

        gl_FragColor = vec4(finalColor, 0.3);
    }
    
}