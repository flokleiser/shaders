#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;
uniform vec4 u_mouse;

const mat2 mtx = mat2( 0.80,  0.60, -0.60,  0.80 );

vec2 hash( vec2 p )
{
	p = vec2( dot(p,vec2(127.1,311.7)),
			  dot(p,vec2(269.5,183.3)));

	return -1.0 + 2.0*fract(sin(p)*43758.5453123);
}

float noise( in vec2 p )
{
    vec2 i = floor( p );
    vec2 f = fract( p );

    vec2 u = f*f*f*(f*(f*6.0-15.0)+10.0);
    vec2 du = 30.0*f*f*(f*(f-2.0)+1.0);
    
    vec2 ga = hash( i + vec2(0.0,0.0) );
    vec2 gb = hash( i + vec2(1.0,0.0) );
    vec2 gc = hash( i + vec2(0.0,1.0) );
    vec2 gd = hash( i + vec2(1.0,1.0) );
    
    float va = dot( ga, f - vec2(0.0,0.0) );
    float vb = dot( gb, f - vec2(1.0,0.0) );
    float vc = dot( gc, f - vec2(0.0,1.0) );
    float vd = dot( gd, f - vec2(1.0,1.0) );

    return va + u.x*(vb-va) + u.y*(vc-va) + u.x*u.y*(va-vb-vc+vd);
}

float fbm0( vec2 p )
{
    float f = 0.0;
    f += 0.5000*(-1.0+2.0*noise( p )); p = mtx*p*2.02;
    f += 0.2500*(-1.0+2.0*noise( p )); p = mtx*p*2.03;
    f += 0.1250*(-1.0+2.0*noise( p )); p = mtx*p*2.01;
    f += 0.0625*(-1.0+2.0*noise( p ));
    return f/0.9375;
}

float fbm1( vec2 p )
{
    float f = 0.0;
    f += 0.500000*noise( p ); p = mtx*p*2.02;
    f += 0.250000*noise( p ); p = mtx*p*2.03;
    f += 0.125000*noise( p ); p = mtx*p*2.01;
    f += 0.062500*noise( p ); p = mtx*p*2.04;
    f += 0.031250*noise( p ); p = mtx*p*2.01;
    f += 0.015625*noise( p );
    return f/0.96875;
}

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

vec3 pattern(vec2 p)
{
    float t = u_time * 0.02;
    const float h = 0.6;
    const float sat = 1.0;
    
    if(fract(length(p)) < 0.5)
    {
        vec2 temp = p;
        p.x = -temp.y;
        p.y = temp.x;
        t = -u_time * 0.02;
    }
    mat2 rotation = mat2(cos(t), -sin(t), sin(t), cos(t));
    p = rotation * p;
    vec2 q;
    vec2 r;
    q.x = fbm1(p);
    q.y = fbm0( p + vec2(-5.2,1.3*(u_time * 0.02)) );
    r.x = fbm0( p + 2.0*q);
    r.y = fbm1( p + 3.0*q + vec2(-2.3,2.8) );
    
    vec2 index;
    index.x = fbm1( p + 6.0*r )+150.0;
    index.y = fbm0( p + 4.0*r )+200.0;
    
    float n = noise(1.7*(p+index));
    
    float sig = 1.0 / (1.0 + exp(-9.0*n));
    vec3 c = hsv2rgb(vec3(h, (1.0-(sig * 0.7 + 0.3))*sat, sig));
    float w = 1.0-0.8*(exp(-4.0*(1.0-fract(length(p)*2.0))));
    return c * w;
}

// void mainImage( out vec4 fragColor, in vec2 fragCoord )
void main()
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = (2.0*gl_FragCoord.xy- u_resolution.xy)/u_resolution.y;
    
    vec3 col = pattern(1.7*uv);

    float aspect = u_resolution.x / u_resolution.y;
    
    // Border
    if(abs(uv.x) > (aspect - 0.1) || abs(uv.y) > 0.9)
        col = vec3(0.93, 0.91, 0.86);

    // Add some texture
    col += 0.25*noise(uv * 180.0);
    gl_FragColor = vec4(col,1.0);
}