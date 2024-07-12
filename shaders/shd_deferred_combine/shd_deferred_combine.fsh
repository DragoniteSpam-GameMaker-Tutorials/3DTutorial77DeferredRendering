varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D samp_depth;
uniform sampler2D samp_normal;

uniform float u_znear;
uniform float u_zfar;

float LinearizeDepth(float depth, float znear, float zfar) {
    depth = depth * 2.0 - 1.0;
	return (2.0 * znear) / (zfar + znear - depth * (zfar - znear));
}

void main()
{
    vec4 color_diffuse = texture2D(gm_BaseTexture, v_vTexcoord);
    float color_depth = texture2D(samp_depth, v_vTexcoord).r;
    vec3 color_normal = texture2D(samp_normal, v_vTexcoord).rgb;
    
    vec3 fragment_normal = (color_normal - 0.5) * 2.0;
    float linear_depth = LinearizeDepth(color_depth, u_znear, u_zfar);
    
    gl_FragColor = vec4(linear_depth, linear_depth, linear_depth, 1);
}
