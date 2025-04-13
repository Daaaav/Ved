-- scripteditor/keypressed

return function(key)
	if key == "up" or key == "down" or key == "pageup" or key == "pagedown" then
		if keyboard_eitherIsDown(ctrl) and keyboard_eitherIsDown("alt") then
			inplacescroll(key)
		end
	elseif key == "f1" then
		tostate(15)
	elseif key == "f3" then
		inscriptsearch(scriptsearchterm)
	elseif keyboard_eitherIsDown("alt") then
		if key == "left" and #scripthistorystack > 0 then
			editorjumpscript(scripthistorystack[#scripthistorystack][1], true, scripthistorystack[#scripthistorystack][2])
		elseif key == "right" and (context == "flagscript" or context == "crewmatescript") and carg2 ~= nil and carg2 ~= "" and not scriptinstack(carg2) then
			editorjumpscript(carg2)
		elseif key == "right" and context == "script" and not scriptinstack(carg1) then
			editorjumpscript(carg1)
		elseif key == "right" and context == "roomscript" and not scriptinstack(carg3) then
			editorjumpscript(carg3)
		end
	elseif keyboard_eitherIsDown(ctrl) then
		if key == "f" then
			startinscriptsearch()
		elseif key == "g" then
			startscriptgotoline()
		elseif key == "i" then
			if keyboard_eitherIsDown("shift") then
				if internalscript then
					internalscript = false
				elseif cutscenebarsinternalscript then
					internalscript = true
					cutscenebarsinternalscript = false
				else
					cutscenebarsinternalscript = true
				end
			else
				if internalscript then
					internalscript = false
					cutscenebarsinternalscript = true
				elseif cutscenebarsinternalscript then
					internalscript = false
					cutscenebarsinternalscript = false
				else
					internalscript = true
				end
			end
			dirty()
		end
	elseif key == "tab" then
		local line_x, editing_line = newinputsys.getpos("script_lines")
		local command_part = utf8.sub(inputs.script_lines[editing_line], 1, line_x)

		if command_part == "" then
			return
		end

		local commands = get_autocomplete_commands(command_part)
		if #commands == 0 then
			return
		end

		local oldstate = {newinputsys.getstate("script_lines")}
		newinputsys.insertchars("script_lines", commands[1]:sub(command_part:len()+1))
		newinputsys.unre("script_lines", UNRE.INSERT, unpack(oldstate))
	elseif key == "escape" then
		local success, raw_script = script_compile(inputs.script_lines)
		if success then
			scripts[scriptname] = raw_script
			newinputsys.close("script_lines")
			if scriptfromsearch then
				resume_search = true
				tostate(11)
			else
				tostate(10)
			end
			nodialog = false
		end
	end
end
