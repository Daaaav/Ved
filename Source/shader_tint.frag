const vec3 tint_filter = vec3(0.299, 0.587, 0.114);

vec4 effect(vec4 current_color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
	vec4 texture_color = Texel(texture, texture_coords);

	vec3 filt = texture_color.rgb * tint_filter * 255.0;
	float gray = floor(filt.r + filt.g + filt.b + 0.5) / 255.0;

	vec4 result;
	result.rgb = vec3(gray) * current_color.rgb;
	result.a = texture_color.a * current_color.a;

	return result;
}
