gcc -Wl,--stack,33554432,-subsystem,windows -o out\ved_updater.exe windows_updater.c log.c read_list.c strings.c UTF816.c -DUNICODE -D_UNICODE -DRestoreLastError=SetLastError
