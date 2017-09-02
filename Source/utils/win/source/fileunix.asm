.386
.model flat, stdcall
option casemap :none

;==============================================================================
; Windows utility that returns the last edit date of a file as a UNIX timestamp
; Dav999
;==============================================================================
; I N C L U D E S
;==============================================================================

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\user32.inc
include \masm32\include\DateTime.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\datetime.lib

;==============================================================================
; C O N S T A N T S
;==============================================================================

.const

;==============================================================================
; S T R I N G S
;==============================================================================

	err_title db "Curious or lost?", 0
	err_wrongprogram db "This is not the way to launch Ved! "
		db "You need to download L", 0D6h, "VE from https://love2d.org/, "
		db "or download the standalone Windows version of Ved.", 13, 10, 13, 10
		db "If this message is unexpectedly popping up WITHIN Ved, "
		db "then that's really strange, please report this bug to Dav.", 0
	txt_none db "NONE", 13, 10, 0
	txt_crlf db 13, 10, 0
	sec db "s"

;==============================================================================
; U N I N I T I A L I Z E D   V A R S
;==============================================================================

.data?
	arg db 1024 DUP (?)

	fh HANDLE ?

	file_creation_time DATETIME ?
	file_access_time DATETIME ?
	file_modification_time DATETIME ?

	epoch_time DATETIME ?
	timediff SDWORD ?

	answer db 16 DUP (?)

;==============================================================================
; I N I T I A L I Z E D   V A R S
;==============================================================================

.data

;==============================================================================
; P R O G R A M
;==============================================================================

.code
StartProg:  ; Entry, jumped
	; What command line argument was given to us?
	invoke getcl_ex, 1, addr arg
	.IF (eax == 0 || eax == 2)
		; You shouldn't just double-click this!
		invoke MessageBox, \
			NULL, \
			addr err_wrongprogram, \
			addr err_title, \
			MB_OK or MB_ICONWARNING

		jmp SayNone
	.ELSEIF (eax >= 3)
		; Ok, invalid
		jmp SayNone
	.ENDIF

	; Does the file exist?
	invoke exist, addr arg
	cmp eax, 0
	jz SayNone

	; Make a file handle - this doesn't actually create a new file
	invoke CreateFile, \
		addr arg, \                             ; Filename
		FILE_READ_ATTRIBUTES, \                 ; Desired access
		FILE_SHARE_READ or FILE_SHARE_WRITE, \  ; Share mode
		NULL, \                                 ; Security attributes
		OPEN_EXISTING, \                        ; Creation disposition
		FILE_ATTRIBUTE_NORMAL, \                ; Flags and attributes
		NULL                                    ; Template file
	mov fh, eax

	; That did work, right
	cmp eax, INVALID_HANDLE_VALUE
	jz SayNone

	; What is the last edit date?
	invoke GetFileTime, \
		fh, \
		addr file_creation_time, \
		addr file_access_time, \
		addr file_modification_time

	; We no longer need the file handle
	invoke CloseHandle, fh

	; When was 1970?
	invoke YMDHMSToDateTime, 1970, 1, 1, 0, 0, 0, addr epoch_time

	; So how many seconds are there in between?
	invoke DateDiff, \
		addr sec, \
		addr epoch_time, \
		addr file_modification_time, \
		addr timediff

	; Let's convert that to actual digits and output it
	invoke dwtoa, timediff, addr answer
	invoke StdOut, addr answer
	invoke StdOut, addr txt_crlf

	jmp EndProg

SayNone: ; Jumped
	invoke StdOut, addr txt_none

EndProg:  ; Entry, jumped
	invoke ExitProcess, 0

;==============================================================================
; E N D
;==============================================================================

end StartProg