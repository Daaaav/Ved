local ffi = require("ffi")

ffi.cdef([[
void SDL_EnableScreenSaver();
]])

ffi.C.SDL_EnableScreenSaver()
