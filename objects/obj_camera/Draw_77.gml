shader_set(shd_deferred_combine);

var sampler_depth = shader_get_sampler_index(shd_deferred_combine, "samp_depth");
var sampler_normal = shader_get_sampler_index(shd_deferred_combine, "samp_normal");
texture_set_stage(sampler_depth, surface_get_texture_depth(self.gbuff_diffuse));
texture_set_stage(sampler_normal, surface_get_texture(self.gbuff_normal));

var u_znear = shader_get_uniform(shd_deferred_combine, "u_znear");
var u_zfar = shader_get_uniform(shd_deferred_combine, "u_zfar");
shader_set_uniform_f(u_znear, 1);
shader_set_uniform_f(u_zfar, 8_000);
var u_fov_scale = shader_get_uniform(shd_deferred_combine, "u_fov_scale");
var fov = 60;
var aspect = 16 / 9;
shader_set_uniform_f(u_fov_scale, dtan(fov / 2) * aspect, dtan(-fov / 2));

draw_surface_stretched(self.gbuff_diffuse, 0, 0, window_get_width(), window_get_height());


shader_reset();

draw_surface_ext(self.gbuff_diffuse, 0, 0, 0.25, 0.25, 0, c_white, 1);
draw_surface_ext(self.gbuff_normal, 0, 180, 0.25, 0.25, 0, c_white, 1);
draw_surface_ext(self.gbuff_vs_position, 0, 360, 0.25, 0.25, 0, c_white, 1);