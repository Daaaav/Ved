-- fonteditormain/load

return function()
	if not fonteditor_reffont_loaded
	and s.fonteditor_reffont_format == 1
	and s.fonteditor_reffont_ttf_filepath ~= "" then
		fonteditor_load_reference_font()
	end
end
