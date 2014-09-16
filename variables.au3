#include <MsgBoxConstants.au3>
; INI files
$dataFile = @ScriptDir & "\data\data.ini"
$mainmenuFile = @ScriptDir & "\data\mainmenu.ini"
$gameFile = @ScriptDir & "\data\game.ini"
$charselectionFile = @ScriptDir & "\data\charselection.ini"

$charselectionFile = @ScriptDir & "\data\charselection.ini"
AutoItSetOption("MouseClickDelay", IniRead($dataFile, "AutoItSetOption", "MouseClickDelay", "0"))
AutoItSetOption("MouseClickDownDelay", IniRead($dataFile, "AutoItSetOption", "MouseClickDownDelay", "0"))
AutoItSetOption("MouseClickDragDelay", IniRead($dataFile, "AutoItSetOption", "MouseClickDragDelay", "0"))
Opt("SendKeyDelay", IniRead($dataFile, "Opt", "SendKeyDelay", "0"))
Opt("SendKeyDownDelay", IniRead($dataFile, "Opt", "SendKeyDownDelay", "0"))
$title = IniRead($dataFile, "data", "title", "Path of Exile")
Local Const $180_div_pi = 180 / ACos(-1)
Local $player[2]
$runing = False
$player[0] = 0
$player[1] = 0
$timer = 0
$wait = 10
;game data
HotKeySet(IniRead($dataFile, "HotKeySet", "stop", "{ESC}"), "stop")
HotKeySet(IniRead($dataFile, "HotKeySet", "go", "{F1}"), "go")
HotKeySet(IniRead($dataFile, "HotKeySet", "follow", "{F2}"), "follow")
$followMode = IniRead($dataFile, "data", "followMode ", false)
$runMode  = IniRead($dataFile, "data", "runMode  ", false)

; Window Variables
$Wx = IniRead($dataFile, "data", "x", "0")
$Wy = IniRead($dataFile, "data", "y", "0")
$Wwidth = IniRead($dataFile, "data", "width", "800")
$Wheight = IniRead($dataFile, "data", "height", "600")
$hWnd = Null
$hControl = Null
$handle = Null

;mini map
$MMleft = IniRead($gameFile, "minimap", "left", "0")
$MMtop = IniRead($gameFile, "minimap", "top", "0")
$MMright = IniRead($gameFile, "minimap", "right", "0")
$MMbottem = IniRead($gameFile, "minimap", "bottem", "0")
$MMcenterX = IniRead($gameFile, "minimap", "center_x", "0")
$MMcenterY = IniRead($gameFile, "minimap", "center_y", "0")

;Player Variables
$posX = IniRead($gameFile, "player", "x", "0")
$posY = IniRead($gameFile, "player", "y", "0")
$square = 300
$psquare = 50
$fAng=0
$left = 0
$top = 0
$right = 0
$bottem = 0

$log = "||||||||||||||||||||||||"

$MK_LBUTTON    =  0x0001
$WM_LBUTTONDOWN   =  0x0201
$WM_LBUTTONUP    =  0x0202
$MK_RBUTTON    =  0x0002
$WM_RBUTTONDOWN   =  0x0204
$WM_RBUTTONUP    =  0x0205
$WM_MOUSEMOVE    =  0x0200
$WM_SETCURSOR = 0x0020