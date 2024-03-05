-- The job of these functions is to ensure necessary libraries are ready for use, and to load them.

function load_library(ffi, dll_filename)
	-- Loads a library with ffi.load. In case of error, returns `nil, errmsg`.

	local success, maybe_lib = pcall(ffi.load,
		love.filesystem.getSaveDirectory() .. "/available_libs/" .. dll_filename
	)

	if success then
		return maybe_lib
	end
	return nil, maybe_lib
end

function prepare_library(dll_filename, source_filename)
	-- Make sure a dynamic library is placed into the available_libs folder,
	-- whether by copying the provided binary or self-compiling.
	-- Tests if the library can be loaded.
	-- Returns `true` if successful, `false, errmsg` if unsuccessful,
	-- where errmsg is the error loading the provided binary.

	if not love.filesystem.exists("available_libs") then
		love.filesystem.createDirectory("available_libs")
	end

	-- Too bad there's no love.filesystem.copy()
	if not love.filesystem.exists("available_libs/" .. dll_filename) then
		local data = love.filesystem.read("libs/" .. dll_filename)
		if data ~= nil then
			love.filesystem.write("available_libs/" .. dll_filename, data)
		end
	end

	local ffi = require("ffi")

	local lib, errmsg = load_library(ffi, dll_filename)
	if lib ~= nil then
		return true
	end

	cons("Library " .. dll_filename .. " failed to load: " .. errmsg)

	-- Try to compile it ourselves then?
	if source_filename == nil then
		return false, errmsg
	end

	local source = love.filesystem.read("libs/" .. source_filename)
	if source == nil then
		cons("Additionally, could not read " .. source_filename .. " for compiling")
		return false, errmsg
	end
	love.filesystem.write("available_libs/" .. source_filename, source)

	local compile_status = os.execute("gcc -shared -fPIC -o '"
		.. love.filesystem.getSaveDirectory() .. "/available_libs/" .. dll_filename .. "' '"
		.. love.filesystem.getSaveDirectory() .. "/available_libs/" .. source_filename .. "'"
	)
	if compile_status ~= 0 then
		cons("Additionally, compiling failed with status " .. tostring(compile_status))
		return false, errmsg
	end

	if load_library(ffi, dll_filename) ~= nil then
		cons("Compiled " .. source_filename .. " successfully")
		return true
	end

	cons("Additionally, compiled library also failed to load")
	return false, errmsg
end

function copy_library_license(txt_filename)
	if not love.filesystem.exists("available_libs/licenses") then
		love.filesystem.createDirectory("available_libs/licenses")
	end

	if not love.filesystem.exists("available_libs/licenses/" .. txt_filename) then
		local data = love.filesystem.read("libs/licenses/" .. txt_filename)
		if data ~= nil then
			love.filesystem.write("available_libs/licenses/" .. txt_filename, data)
		end
	end
end
