:: Programmed by hXR16F
:: hXR16F.ar@gmail.com

@echo off
setlocal EnableDelayedExpansion
color 07

:: Syntax
	if "%1" EQU "/?" (goto :syntax) else (if "%1" EQU "-h" (goto :syntax) else (if "%1" EQU "--help" (goto :syntax) else (if "%1" EQU "/help" (goto :syntax) else (if "%1" EQU "?" (goto :syntax) else (if "%1" EQU "/h" (goto :syntax))))))

:: Multithreading
	if not "%1" EQU "" (if not "%1" EQU "-in" goto :thread %1) else (title Batch IP Scanner & cls)

:: Variables
	for %%n in (
		"closeAfterScan=0"
	) do set "%%~n"
	
	if exist "BatchIPScanner.chr" (
		set line=1
		for /F "tokens=*" %%n in ('type BatchIPScanner.chr') do (
			if !line! EQU 1 set "chr=%%n"
			if !line! EQU 2 set "chr_1=%%n"
			if !line! EQU 3 set "chr_2=%%n"
			set /A line+=1
		)
	) else (
		set "chr=[+]"
		set "chr_1=[+]"
		set "chr_2=|"
	)
	
	for %%n in ("prefix=!chr!"	"prefix_1=!chr_1!"	"prefix_2=!chr_2!"	"threads=25"	"timeout=300"	"found=0") do set "%%~n"
	if not "%4" EQU "" set "threads=%4"
	if not "%5" EQU "" set "timeout=%5"

:: Checking for parameters
	if "%1" EQU "-in" (
		set "ip=%2" || (echo | set /P "%random%=!prefix! IP Address: " & set /P "ip=")
		set "range=%3" || (echo | set /P "%random%=!prefix! Range: " & set /P "range=")
		set "threads=%4" || (echo | set /P "%random%=!prefix! Threads (Default: 25): " & set /P "threads=")
		set "threads=%5" || (echo | set /P "%random%=!prefix! Timeout (Default: 300): " & set /P "timeout=")
	) else (
		if exist "BatchIPScanner.cfg" (
			set line=1
			for /F "tokens=*" %%n in ('type BatchIPScanner.cfg') do (
				if !line! EQU 1 set "ip=%%n"
				if !line! EQU 2 set "range=%%n"
				if !line! EQU 3 set "threads=%%n"
				if !line! EQU 4 set "timeout=%%n"
				set /A line+=1
			)
			del /F /Q "BatchIPScanner.cfg" > nul
		) else (
			echo | set /P "%random%=!prefix! IP Address: " & set /P "ip="
			echo | set /P "%random%=!prefix! Range: " & set /P "range="
			echo | set /P "%random%=!prefix! Threads (Default: 25): " & set /P "threads="
			echo | set /P "%random%=!prefix! Timeout (Default: 300): " & set /P "timeout="
		)
	)
	if "%ip%" EQU "" exit
	if "%range%" EQU "" exit
	if "%threads%" EQU "" set "threads=25"
	if "%timeout%" EQU "" set "timeout=300"

:: UI
	cls & call :logo
	(echo.&echo;  %prefix% Found hosts:&echo.)

:: Reading IP address
	echo;%ip% > "%temp%/bip_ip.temp"
	for /F "tokens=1,2,3,4* delims=." %%i in (%temp%\bip_ip.temp) do (set "ip1=%%i" & set "ip2=%%j" & set "ip3=%%k" & set "ip4=%%l") && pushD "%temp%" && del /F /Q "bip_ip.temp" 2>&1 && popD
	set /A ip4_1=%ip4%+1

:: Reading range
	echo;%range% > "%temp%/bip_range.temp"
	for /F "tokens=1,2,3,4* delims=." %%i in (%temp%\bip_range.temp) do (set "range1=%%i" & set "range2=%%j" & set "range3=%%k" & set "range4=%%l") && pushD "%temp%" && del /F /Q "bip_range.temp" 2>&1 && popD

:: Getting PC local IP
	ipconfig | find "IPv4 Address. . . . . . . . . . . :" > "%temp%/bip_this_pc_ip_0.temp"
	for /F "tokens=*" %%n in (%temp%\bip_this_pc_ip_0.temp) do set "this_pc_ip_0=%%n"
	pushD "%temp%" && del /F /Q "bip_this_pc_ip_0.temp" 2>&1 && popD & set "this_pc_ip=%this_pc_ip_0:~36,15%
	
:: Getting Gateway IP
	ipconfig | find "Default Gateway . . . . . . . . . :" > "%temp%/bip_default_gateway_0.temp"
	for /F "tokens=*" %%n in (%temp%\bip_default_gateway_0.temp) do set "default_gateway_0=%%n"
	pushD "%temp%" && del /F /Q "bip_default_gateway_0.temp" 2>&1 && popD & set "default_gateway=%default_gateway_0:~36,15%

:: Multithreading | The filename of THIS file shouldn't contain any spaces
	set /A threads_1=%threads%+%ip4%
	for /L %%n in (!ip4_1!,1,!threads_1!) do start /B %~nx0 %%n

:: Main thread
	:1
		if exist "BatchIPScanner.txt" del /F /Q "BatchIPScanner.txt"
		for /L %%k in (!ip1!,1,!range1!) do (
			for /L %%l in (!ip2!,1,!range2!) do (
				for /L %%m in (!ip3!,1,!range3!) do (
					for /L %%n in (!ip4!,!threads!,!range4!) do (
						title Scanning... [%%k.%%l.%%m.%%n / !range1!.!range2!.!range3!.!range4!]
						ping %%k.%%l.%%m.%%n -n 1 -l 0 -w !timeout! 2>&1 | find "Reply from" > nul && (
							if not exist "%temp%/bip_found.temp" echo. > "%temp%/bip_found.temp" 2>&1
							for /F "tokens=2 delims= " %%o in ('2^>nul nslookup %%k.%%l.%%m.%%n ^| findstr /C:":    "') do if not "%%o" EQU "" set "host-name= !prefix_2! %%o"
							if "%%k.%%l.%%m.%%n" EQU "!this_pc_ip!" (
								echo;    !prefix_1! %%k.%%l.%%m.%%n!host-name! !prefix_2! This PC
							) else (
								if "%%k.%%l.%%m.%%n" EQU "!default_gateway!" (
									echo;    !prefix_1! %%k.%%l.%%m.%%n!host-name! !prefix_2! Gateway
								) else (
									echo;    !prefix_1! %%k.%%l.%%m.%%n!host-name!
								)
							)
						)
					)
				)
			)
		)
		@ping localhost -n 3 > nul
		title Batch IP Scanner
		if not exist "%temp%/bip_found.temp" (
			echo;     !prefix_1!  No hosts found.
		) else (
			pushD "%temp%" && del /F /Q "bip_found.temp" > nul && popD
		)
		(echo.&echo;  %prefix% Scanning completed.)
		if "%closeAfterScan%" EQU "1" exit /B
		for /L %%n in (0,0,1) do (
			timeout /t 2 /nobreak > nul && title Batch IP Scanner
		)
	
:: Threads
	:thread %1
		@ping localhost -n 1 > nul
		for /L %%k in (!ip1!,1,!range1!) do (
			for /L %%l in (!ip2!,1,!range2!) do (
				for /L %%m in (!ip3!,1,!range3!) do (
					for /L %%n in (%1,!threads!,!range4!) do (
						title Scanning... [%%k.%%l.%%m.%%n / !range1!.!range2!.!range3!.!range4!]
						ping %%k.%%l.%%m.%%n -n 1 -l 0 -w !timeout! 2>&1 | find "Reply from" > nul && (
							if not exist "%temp%/bip_found.temp" echo. > "%temp%/bip_found.temp" 2>&1
							for /F "tokens=2 delims= " %%o in ('2^>nul nslookup %%k.%%l.%%m.%%n ^| findstr /C:":    "') do if not "%%o" EQU "" set "host-name= !prefix_2! %%o"
							if "%%k.%%l.%%m.%%n" EQU "!this_pc_ip!" (
								echo;    !prefix_1! %%k.%%l.%%m.%%n!host-name! !prefix_2! This PC
							) else (
								if "%%k.%%l.%%m.%%n" EQU "!default_gateway!" (
									echo;    !prefix_1! %%k.%%l.%%m.%%n!host-name! !prefix_2! Gateway
								) else (
									echo;    !prefix_1! %%k.%%l.%%m.%%n!host-name!
								)
							)
						)
					)
				)
			)
		)
		exit
	
:: Logo
	:logo
		(
			echo.
			echo;  %prefix% Batch IP Scanner by hXR16F
			echo.
			echo;               ``                                       ``
			echo;               /h/                     :s:              yd`
			echo;               +d+-/++:`   `-/++:./: `/sds//.  .:++/-`  hd-:++/.
			echo;               +dho/:+hh: `ydo::+ydh  -sdo::` +ds::/y+  hds/:/hd-
			echo;               +do    -dh +do    -dh   +d/   -dh        hd.   +d/
			echo;               +ds`   /dy /ds`   /dh   +d+   .dh.   ..  hd.   +d/
			echo;               +dysssyhs.  +yyssssyd+` -hhos- :yysosy+  yd`   +d/
			echo;               `.``...`     `.... `..   `...`   ....`   ..    `.`
		)
		exit /B
	
:: Syntax
	:syntax
		(
			echo;IP scanning tool for Windows by hXR16F.
			echo.
			echo;Syntax:
			echo.
			echo;  %0 -in ^<IP^> ^<RANGE^> ^<THREADS^> ^<TIMEOUT^>
			echo.
			echo;Default variables:
			echo.
			echo;  THREADS = 25
			echo;  TIMEOUT = 300 ms ^(~300 for LAN ^| ~800 and more for global^)
			echo.
			echo;Examples:
			echo.
			echo;  %0 -in 192.168.0.1 192.168.1.255
			echo;  %0 -in 216.58.208.46 216.58.208.146 30 800
		)
		exit /B
	