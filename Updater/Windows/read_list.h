#ifndef READ_LIST_H
#define READ_LIST_H

#include <windows.h>
#include <stdbool.h>

bool read_list(const WCHAR* filename, char** dst);
bool next_line(char** ptr);


#endif // READ_LIST_H
