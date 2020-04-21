#MaxThreadsPerHotkey 2
#Persistent
#Include .\setting.ini

toggle = 0
toggle1 = 0

ToolTip, F11 for help, 0, 0
SetTimer, RemoveToolTip, -2000
return

F1::
auto:
loop {
	Sleep, 1000
	Send, {Space down}
	Sleep, %Sleep1%
	Send, {Space up}
	Send, {Space}
	Sleep, %Sleep2%
	If (Method = 1) {
		Loop %loopnumber1% {
			Send, {Space down}
			Sleep, %Sleep3%
			Send, {Space up}
			Sleep, %Sleep4%
			Send, {Enter Down}
			Sleep, %Sleep5%
			Send, {Enter Up}
			Sleep, 100
			Send, {Enter}
		}
	}
	If (Method = 2) {
		Loop %loopnumber1% {
			Send, {Space down}
			Sleep, %Sleep3%
			Sleep, %Sleep4%
			Send, {Enter Down}
			Sleep, %Sleep5%
			Send, {Enter Up}
			Sleep, 100
			Send, {Enter}
		}
		Send, {Space up}
	}
	Send, {Shift Down}
	Send, {Enter Down}
	Send, {Space down}
	Sleep, %Sleep6%
	Send, {Space up}
	Send, {Enter up}
	Send, {Shift Up}
	clickkeep:
	If (flag1 = 1) {
		Send, {Ctrl down}
		Sleep, 100
		MouseMove, %x1%, %y1%
		Click
		Sleep, 100
		Send, {Ctrl up}
		Sleep, 100
	}
	If (flag2 = 1) {
		Send, {Ctrl down}
		Sleep, 100
		MouseMove, %x2%, %y2%
		Click
		Sleep, 100
		Send, {Ctrl up}
		Sleep, 100
	}
	If (flag3 = 1) {
		Send, {Ctrl down}
		Sleep, 100
		MouseMove, %x3%, %y3%
		Click
		Sleep, 100
		Send, {Ctrl up}
	}
	Sleep 4000
}
return

F2::
loop {
	Loop {
	Send, {Space down}
	sleep, 100
	Send, {Space Up}
	}
}
return

F3::
If (flag1 = 1) {
	Send, {Ctrl down}
	Sleep, 100
	MouseMove, %x1%, %y1%
	Click
	Sleep, 100
	Send, {Ctrl up}
}
If (flag2 = 1) {
	Send, {Ctrl down}
	Sleep, 100
	MouseMove, %x2%, %y2%
	Click
	Sleep, 100
	Send, {Ctrl up}
}
If (flag3 = 1) {
	Send, {Ctrl down}
	Sleep, 100
	MouseMove, %x3%, %y3%
	Click
	Sleep, 100
	Send, {Ctrl up}
}
sleep 4000
goto auto
return

F10::
MouseGetPos , getposx, getposy
ToolTip, X = %getposx%`nY = %getposy%, %getposx%, %getposy%
SetTimer, RemoveToolTip, -2000
return

F11::
MsgBox, 0, Fishing Planet Bot, F1	to automate fishing`nF2	to hold Space Down for reeling`nF3	to press Keep and autofish`nF10	for view mouse coord`nF11	For Help`nF12	to reload the script (Stop every running Script)
return

F12::
sleep, 1
Send, {Shift Up}
Send, {Space Up}
Send, {Ctrl up}
Send, {Enter up}
Reload
return

RemoveToolTip:
ToolTip
return
