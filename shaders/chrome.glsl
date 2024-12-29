#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;
uniform vec4 u_mouse;

// rotation
mat2 rot (float a) { float c=cos(a),s=sin(a); return mat2(c,-s,s,c); }

// smooth minimum
float smin( float d1, float d2, float k )
{
    float h = clamp( 0.5 + 0.5*(d2-d1)/k, 0.0, 1.0 );
    return mix( d2, d1, h ) - k*h*(1.0-h);
}

// gyroid
float gyroid (vec3 p) { return dot(sin(p),cos(p.yzx)); }

// noise
float fbm (vec3 p)
{
    float r = .0;
    float a = 1.;
    for (float i = .0; i < 3.; ++i)
    {
        p += r * .5;
        r += abs(gyroid(p/a)*a);
        a /= 1.8;
    }
    return r;
}

// distance field
float dist(vec2 p)
{
    float d = 100.;
    vec2 q = p;
    
    // kaleidoscopic circles
    float a = 1.;
    float t = 196.+u_time/20.;
    for (float i = 0.; i < 3.; ++i) {
        p.x = abs(p.x)-a;
        p *= rot(t/a);
        d = smin(abs(length(p)-a), d, 1.5*a);
        a /= 2.;
    }
    
    // outline
    //d = min(d, abs(d-.04)-.05);
    
    // frame
    q = abs(q)-vec2(u_resolution.x/u_resolution.y, 1.);
    float box = abs(max(q.x, q.y));
    d = smin(d, box-.1, .2);
    
    // noise
    float z = length(p)+u_time/5.+d*20.;
    d += (fbm(vec3(p*10.,z))-.5)*.001/max(-d, .01);
    
    return d-.1;
}

// void mainImage( out vec4 fragColor, in vec2 fragCoord )
void main()
{
    // coordinates
    // vec2 uv = fragCoord / u_resolution.xy;
    // gl_FragCoord.xy;
    // vec2 fragCoord = gl_FragCoord.xy;
    vec2 uv = gl_FragCoord.xy/ u_resolution.xy;
    vec2 p = (2.*gl_FragCoord.xy-u_resolution.xy)/u_resolution.y;
    
    // distance
    float shape = dist(p);
    
    // normal
    vec2 e = vec2(8./u_resolution.y,0);
    #define P(u) vec3(p+u,dist(p+u))
    #define N(v) normalize(v)
    vec3 n = -cross(N(P(e.xy)-P(-e.xy)), N(P(e.yx)-P(-e.yx)));

    // lighting
    vec3 color = vec3(.0);
    color += pow(dot(n, N(vec3(0,1,-1)))*.5+.5, 40.);
    color += pow(dot(n, N(vec3(0,0,1)))*.5+.5, .9);
    color += pow(dot(n, N(vec3(0,-1,-1)))*.5+.5, 20.);
    color *= .333+.66*smoothstep(.05,.0,shape+.05);
    
    // background
    vec3 back = vec3((1.-uv.y)*.8+.2);
    back *= smoothstep(0.,.07,shape)*.33+.66;
    color = mix(back, color, smoothstep(.01,.0,shape));
    
    gl_FragColor = vec4(color, 1);
}