/* Commonplace C library functions (Linux+macOS+Windows) on an as-needed basis. For use with LuaJIT FFI's cdef */

void* malloc(size_t size);
void free(void* ptr);
void* realloc(void* ptr, size_t size);