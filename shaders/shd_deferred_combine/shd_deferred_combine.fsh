varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D samp_depth;
uniform sampler2D samp_normal;

uniform float u_znear;
uniform float u_zfar;
uniform vec2 u_fov_scale;

float LinearizeDepth(float depth, float znear, float zfar) {
    depth = depth * 2.0 - 1.0;
	return (2.0 * znear) / (zfar + znear - depth * (zfar - znear));
}

vec3 GetVSPosition(float fragment_depth, vec2 screen_position, vec2 fov_scale) {
#if !(defined(_YY_HLSL11_) || defined(_YY_PSSL_))
    fov_scale.y *= -1.0;
#endif
    return vec3(fov_scale * (screen_position - 0.5) * 2.0 * fragment_depth, fragment_depth);
}

void main()
{
    vec4 color_diffuse = texture2D(gm_BaseTexture, v_vTexcoord);
    float color_depth = texture2D(samp_depth, v_vTexcoord).r;
    vec3 color_normal = texture2D(samp_normal, v_vTexcoord).rgb;
    
    vec3 fragment_normal = (color_normal - 0.5) * 2.0;
    float linear_depth = LinearizeDepth(color_depth, u_znear, u_zfar);
    float fragment_depth = linear_depth * (u_zfar - u_znear) + u_znear;
    
    vec3 view_position = GetVSPosition(fragment_depth, v_vTexcoord, u_fov_scale);
    
    //gl_FragColor = vec4(linear_depth, linear_depth, linear_depth, 1);
    gl_FragColor = vec4(view_position / 100.0, 1);
}
