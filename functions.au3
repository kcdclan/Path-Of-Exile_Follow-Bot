Func stop()
	Exit
EndFunc   ;==>stop

Func go()
	If $runing == False Then
		$runing = True
	Else
		$runing = False
	EndIf
	status("runing" & $runing)
	While $runing
		main()
	WEnd
EndFunc   ;==>go

Func _GetAngleDegree($X1, $Y1, $X2, $Y2)
	Local Const $nPI = 4 * ATan(1)
	Local $XDIFF, $YDIFF, $TempAngle
	$YDIFF = Abs($Y2 - $Y1)
	If $X1 = $X2 And $Y1 = $Y2 Then Return 0
	If $YDIFF = 0 And $X1 < $X2 Then
		Return 0
	ElseIf $YDIFF = 0 And $X1 > $X2 Then
		Return $nPI
	EndIf
	$XDIFF = Abs($X2 - $X1)
	$TempAngle = ATan($XDIFF / $YDIFF)
	If $Y2 > $Y1 Then $TempAngle = $nPI - $TempAngle
	If $X2 < $X1 Then $TempAngle = -$TempAngle
	$TempAngle = ($nPI / 2) - $TempAngle
	If $TempAngle < 0 Then $TempAngle = ($nPI * 2) + $TempAngle
	Return $TempAngle * 180 / $nPI
EndFunc   ;==>_GetAngleDegree

Func _Angle($tX, $tY, $cX, $cY)
	$mx = $tX - $cX
	$my = $cY - $tY
	$angle = ATan($my / $mx) * $180_div_pi
	If $mx < 0 Then
		$angle = 180 + $angle
	ElseIf $mx >= 0 And $my < 0 Then
		$angle = 360 + $angle
	EndIf
	Return Int($angle)
EndFunc   ;==>_Angle

Func Angle($X1, $Y1, $Ang, $Length)
	Local $Return[3]
	$Return[1] = $X1 + ($Length * Cos($Ang / 180 * 3.14159265358979))
	$Return[2] = $Y1 - ($Length * Sin($Ang / 180 * 3.14159265358979))
	Return $Return
EndFunc   ;==>Angle

Func items()
	$aCoord = PixelSearch($posX - $psquare, $posY - $psquare, $posX + $psquare, $posY + $psquare, 0x9C9178,1); unique
	If Not @error Then
		$aCoord = PixelSearch( $aCoord[0]-25, $aCoord[1], $aCoord[0]+85, $aCoord[1]+25, 0x9B9076,1);
		If Not @error Then
		status("UNI:" & $aCoord[0] & ":" & $aCoord[1])
		Send("{ALTDOWN}")
		Sleep(50)
		MouseClick("left", $aCoord[0], $aCoord[1], 1, 1)
		Sleep(50)
		Send("{ALTUP}")
		Return True
		Else
		Return False
		EndIf
	EndIf
	$aCoord = PixelSearch($posX - $psquare, $posY - $psquare, $posX + $psquare, $posY + $psquare, 0x1D8076); gem
	If Not @error Then
		$aCoord = PixelSearch( $aCoord[0]-25, $aCoord[1], $aCoord[0]+85, $aCoord[1]+25, 0x208379,1);
		If Not @error Then
		status("GEM:" & $aCoord[0] & ":" & $aCoord[1])
		Send("{ALTDOWN}")
		Sleep(50)
		MouseClick("left", $aCoord[0], $aCoord[1], 1, 1)
		Sleep(50)
		Send("{ALTUP}")
		Return True
		Else
		Return False
		EndIf
	EndIf
EndFunc

Func pickit()
	status("Pick it Scan")
	$aCoord = PixelSearch($posX - $psquare, $posY - $psquare, $posX + $psquare, $posY + $psquare, 0x9C9178, 1); unique
	If Not @error Then
		status("UNI:" & $aCoord[0] & ":" & $aCoord[1])
		Send("{ALTDOWN}")
		Sleep(50)
		MouseClick("left", $aCoord[0], $aCoord[1], 1, 1)
		Sleep(50)
		Send("{ALTUP}")
	EndIf
	$aCoord = PixelSearch($posX - $psquare, $posY - $psquare, $posX + $psquare, $posY + $psquare, 0x9C9178, 1); gem
	If Not @error Then
		status("GEM:" & $aCoord[0] & ":" & $aCoord[1])
		Send("{ALTDOWN}")
		Sleep(50)
		MouseClick("left", $aCoord[0], $aCoord[1], 1, 1)
		Sleep(50)
		Send("{ALTUP}")
	EndIf
EndFunc   ;==>pickit

Func status($msg)
	$log = $msg & '|' & $log
	$string = StringSplit($log, '|')
	ClipPut($string[0] & @CRLF & $string[1] & @CRLF & $string[2] & @CRLF & $string[3] & @CRLF & $string[4] & @CRLF & $string[5] & @CRLF & $string[6] & @CRLF & $string[7] & @CRLF & $string[8] & @CRLF & $string[9] & @CRLF & $string[10])
	ToolTip($string[0] & @CRLF & $string[1] & @CRLF & $string[2] & @CRLF & $string[3] & @CRLF & $string[4], 0, 0)
EndFunc   ;==>status

Func follow()
	If $followMode Then
		$followMode = False
	Else
		$followMode = True
	EndIf
EndFunc   ;==>follow

Func moving()
	$iCheckSum = PixelChecksum(0, 0, 50, 50)
	Sleep(50)
	$iCheckSum1 = PixelChecksum(0, 0, 50, 50)
	If $iCheckSum == $iCheckSum1 Then
		Return False
	Else
		Return True
	EndIf
EndFunc   ;==>moving

Func waitLoad()
	While location() == "loading"
	WEnd
EndFunc   ;==>waitLoad

Func targetscan()
	$aCoord = PixelSearch($posX - $square, $posY - $square, $posX + $square, $posY + $square, 0xA71D1C)
	If Not @error Then
		$Ang = _Angle($aCoord[0], $aCoord[1], $posX, $posY)
		status("ATK:" & $aCoord[0] & ":" & $aCoord[1] & "@" & $Ang & "%")
		$click = Angle($posX, $posY, $Ang, 100)
		MouseClick("right", $click[1], $click[2], 1)
		Return True
	Else
		Return False
		;pickit()
	EndIf
EndFunc   ;==>targetscan

Func friendly()
	$aCoord = PixelSearch($MMleft, $MMtop, $MMright, $MMbottem, 0x10B301, 20)
	If Not @error Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>friendly

Func nearfriendly()
	$offset = 60
	$aCoord = PixelSearch($MMleft + $offset, $MMtop + $offset, $MMright - $offset, $MMbottem - $offset, 0x10B301, 20)
	If Not @error Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>nearfriendly

Func lost()
	$click = Angle($posX, $posY, Random($fAng-10,$fAng+10,1), Random(200,250,1))
	MouseClick("left", $click[1], $click[2], 1)
EndFunc   ;==>lost

Func findFriend($far)
	$aCoord = PixelSearch($MMleft, $MMtop, $MMright, $MMbottem, 0x10B301, 20)
	If Not @error Then
		If $player[0] <> $aCoord[0] And $player[1] <> $aCoord[1] Then
			$player[0] = $aCoord[0]
			$player[1] = $aCoord[1]
			status("MOV:" & $player[0] & ":" & $player[1])
			$Ang = _Angle($player[0], $player[1], $MMcenterX, $MMcenterY)
			$fAng = $Ang
			$click = Angle($posX, $posY, $Ang, $far)
			MouseClick("left", $click[1], $click[2], 1)
			Return True
		Else
			Return False
		EndIf
	Else
		status("MOV:" & "fail")
		Return False
	EndIf
EndFunc   ;==>findFriend

Func findinstance()
	;Updated 9/14/14 1:19PM
	$aCoord = PixelSearch($MMleft, $MMtop, $MMright, $MMbottem, 0xFA5700, 10)
	If Not @error Then
		status("far")
		$Ang = _Angle($aCoord[0], $aCoord[1], $MMcenterX, $MMcenterY)
		$click = Angle($posX, $posY, $Ang, 100)
		MouseClick("left", $click[1], $click[2], 1)
		Return True
	Else
	$aCoord = PixelSearch($MMcenterX - 15, $MMcenterY - 15, $MMcenterX + 15, $MMcenterY + 15, 0xFA5700, 10)
	If Not @error Then
		status("near")
		scaninstance($aCoord[0], $aCoord[1])
		Return True
	Else
		Return False
	EndIf
	EndIf
EndFunc   ;==>findinstance

Func MMscan()
EndFunc   ;==>MMscan

Func scaninstance($x, $y)
	$var = 0
	$span = 10
	$mpos = MouseGetPos()
	$Ang = _Angle($x, $y, $MMcenterX, $MMcenterY) + $span
	$Sang = $Ang - $span
	While location() <> "loading"
		status("ANG:" & $Ang)
		$mpos = MouseGetPos()
		$var = $var + 33
		$click = Angle($posX, $posY, $Ang, $var)
		MouseMove($click[1], $click[2], 0)
		$aCoord = PixelSearch($click[1] - $psquare, $click[2] - $psquare, $click[1] + $psquare, $click[2] + $psquare, 0xC8C8DC, 10)
		If Not @error Then
			MouseClick("left", $aCoord[0], $aCoord[1], 1, 0)
			ExitLoop
		EndIf
		If $mpos[0] < 100 Or $mpos[0] > $Wwidth - 100 Or $mpos[1] < 100 Or $mpos[1] > $Wheight - 100 Then
			$Ang = $Ang - 1
			$var = 0
			MouseMove($posX, $posY, 0)
		EndIf
		If $Sang == $Ang Then
			ExitLoop
		EndIf
	WEnd
	Sleep(1000)
	MouseClick("left")
EndFunc   ;==>scaninstance

Func dead()
	If PixelChecksum(341, 178, 473, 192) == 290562049 Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>dead

Func location()
	$location = "unknown"
	If PixelChecksum(141, 619, 169, 630) == 3327638947 Then
		$location = "game"
		If PixelChecksum(224, 514, 299, 557) == 4042841030 Then
			$location = "wp"
		ElseIf dead() Then
			$location = "dead"
		EndIf
	ElseIf PixelChecksum(141, 619, 169, 630) == 3803669323 Then
		$location = "gamemenu"
	ElseIf PixelChecksum(800, 600, 807, 630) == 48758785 Then
		$location = "loading"
	ElseIf PixelChecksum(458, 609, 776, 609) == 1703834915 Then
		$location = "charselection"
	ElseIf PixelChecksum(208, 611, 525, 611) == 15692348 Then
		$location = "mainmenu"
	Else
		$location = PixelChecksum(800, 600, 807, 630)
		ClipPut(ClipGet() & @CRLF & $location)
	EndIf
	status($location)
	Return $location
EndFunc   ;==>location

Func button($button)
	Switch location()
		Case "mainmenu"
			Switch $button
				Case "login"
					$left = IniRead($mainmenuFile, $button, "left", "0")
					$top = IniRead($mainmenuFile, $button, "top", "0")
					$right = IniRead($mainmenuFile, $button, "right", "0")
					$bottem = IniRead($mainmenuFile, $button, "bottem", "0")
					MouseClick("left", Random($left, $right, 1), Random($top, $bottem, 1), 1, 0)
				Case Else
					Return Null
			EndSwitch
		Case "charselection"
			Switch $button
				Case "play"
					$left = IniRead($charselectionFile, $button, "left", "0")
					$top = IniRead($charselectionFile, $button, "top", "0")
					$right = IniRead($charselectionFile, $button, "right", "0")
					$bottem = IniRead($charselectionFile, $button, "bottem", "0")
					MouseClick("left", Random($left, $right, 1), Random($top, $bottem, 1), 1, 0)
				Case Else
					Return Null
			EndSwitch

		Case Else
			Return Null
	EndSwitch
EndFunc   ;==>button

Func InitializeComponent()
	ClipPut("")
	WinMove($title, "", $Wx, $Wy, $Wwidth, $Wheight)
	$aArray = WinGetPos($title)
	$Wx = $aArray[0]
	$Wy = $aArray[1]
	$Wwidth = $aArray[2]
	$Wheight = $aArray[3]
	WinActivate($title, "")
	$hWnd = WinWait($title, "", 10)
	$hControl = ControlGetHandle($hWnd, "", "")
	$handle = WinGetHandle($title, "")
	While 1
	WEnd
EndFunc   ;==>InitializeComponent

;DLL
Func SetCursorPos($x, $y)
	DllCall("user32.dll", "int", "SetCursorPos", "int", $x, "int", $y)
EndFunc   ;==>SetCursorPos

Func _MakeLong($LoWord, $HiWord)
	Return BitOR($HiWord * 0x10000, BitAND($LoWord, 0xFFFF))
EndFunc   ;==>_MakeLong

Func Click($Window, $button, $x, $y)
	;SetCursorPos($x, $y)
	Select
		Case $button = "left"
			$button = $MK_LBUTTON
			$ButtonDown = $WM_LBUTTONDOWN
			$ButtonUp = $WM_LBUTTONUP
		Case $button = "right"
			$button = $MK_RBUTTON
			$ButtonDown = $WM_RBUTTONDOWN
			$ButtonUp = $WM_RBUTTONUP
	EndSelect
	DllCall("user32.dll", "int", "SendMessage", "hwnd", WinGetHandle($Window), "int", $WM_SETCURSOR, "int", 0, "long", _MakeLong($x, $y))
	DllCall("user32.dll", "int", "SendMessage", "hwnd", WinGetHandle($Window), "int", $WM_MOUSEMOVE, "int", 0, "long", _MakeLong($x, $y))
	DllCall("user32.dll", "int", "SendMessage", "hwnd", WinGetHandle($Window), "int", $ButtonDown, "int", $button, "long", _MakeLong($x, $y))
	DllCall("user32.dll", "int", "SendMessage", "hwnd", WinGetHandle($Window), "int", $WM_MOUSEMOVE, "int", 0, "long", _MakeLong($x, $y))
	DllCall("user32.dll", "int", "SendMessage", "hwnd", WinGetHandle($Window), "int", $ButtonUp, "int", $button, "long", _MakeLong($x, $y))
EndFunc   ;==>Click
