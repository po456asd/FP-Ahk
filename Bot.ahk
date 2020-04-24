#MaxThreadsPerHotkey 2
#Persistent
#Include .\setting.ini

toggle = 0
toggle1 = 0
Countup = 0

ToolTip, F10 for help, 0, 0
SetTimer, RemoveToolTip, -2000


return

F1::
auto:
loop {
	ToolTip, Starting..., 0, 0
	SetTimer, RemoveToolTip, -1000
	SetTimer, timertocheckerror, -300000
	
	Countup=0
	Countup1=0
	releasefish = 0
	
	send, {Space up}
	send, {Enter up}
	send, {Shift Up}
	loop 4
	{
		send, {k}
		sleep, 250
	}
	send, {l}
	
	gosub, CheckFishingNet
	gosub, checkforgear	
	gosub, starting
	
	If (Method = 1) 
	{
		Loop %loopnumber1% 
		{
			send, {Space down}
			Sleep, %Sleep3%
			send, {Space up}
			Sleep, %Sleep4%
			send, {Enter Down}
			Sleep, %Sleep5%
			send, {Enter Up}
			Sleep, 100
			send, {Enter}
			gosub, Searchforfishbite
			
		}
	}
	If (Method = 2) {
		Loop %loopnumber1% {
			send, {Space down}
			Sleep, %Sleep3%
			send, {Enter Down}
			Sleep, %Sleep5%
			send, {Enter Up}
			gosub, Searchforfishbite
		}
		send, {Space up}
	}
	
	gosub resetreel
	
	gosub, fishstrike
	
	gosub, clickkeep
	
	Sleep 4000
	Tooltip, Resetting, 0, 0
}
return

F4::
loop
{
	sleep 500
	ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 %imagefolder%\release.png	
	if errorlevel = 0 
	{
		ToolTip, Image Found, 0, 0
	}
	if errorlevel = 1 
	{
		ToolTip, Finding Image..., 0, 0
	}
	if errorlevel = 2 
	{
		ToolTip, Failed to open Image File Error 2, 0, 0
	}
}
return

F9::
MouseGetPos , getposx, getposy
ToolTip, X = %getposx%`nY = %getposy%, %getposx%, %getposy%
SetTimer, RemoveToolTip, -2000
return

F10::
MsgBox, 0, Fishing Planet Bot, F1	to automate fishing`nF2	to hold Space Down for reeling`nF3	to press Keep and autofish`nF10	for view mouse coord`nF11	For Help`nF12	to reload the script (Stop every running Script)
return

F11::
sleep, 1
send, {Shift Up}
send, {Space Up}
send, {Ctrl up}
send, {Enter up}
Reload
return














































starting:
ToolTip, Throwing Lure..., 0, 0
send, {Space}
Sleep, 250
send, {Space down}
Sleep, %Sleep1%
send, {Space up}
ToolTip, Running Sleep2..., 0, 0
Sleep, %Sleep2%
ToolTip, Running Method Reel for %loopnumber1% times..., 0, 0
return


CheckFishingNet:
Loop
{
	ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 *Trans0xff00ff %imagefolder%\fullfishnet.png
	if errorlevel = 0 
	{
		Countup++
		If (Countup = 3)
		{
			;กดไปวันต่อไป
			Countup=0
			loop 
			{
				Send {t}
				ImageSearch, coordx, coordy, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 %imagefolder%\skipwait.png
				if errorlevel = 0 
				{
					MouseClick, Left, coordx, coordy
				}
				ImageSearch, coordx, coordy, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 %imagefolder%\skipyes.png
				if errorlevel = 0 
				{
					MouseClick, Left, coordx, coordy
				}
				ImageSearch, coordx, coordy, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 %imagefolder%\nextmorning.png
				if errorlevel = 0 
				{
					MouseClick, Left, coordx, coordy
				}
				ImageSearch, coordx, coordy, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 %imagefolder%\extend.png
				if errorlevel = 0 
				{
					MouseClick, Left, coordx, coordy
				}
				ImageSearch, coordx, coordy, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 %imagefolder%\close.png
				if errorlevel = 0 
				{
					MouseClick, Left, coordx, coordy
					goto, starting
				}
			}			
		}
	}
	if errorlevel = 1
	{
		Countup1++
		If (Countup1 = 3)
		{
			Countup1=0
			break
		}
	}
}
return

Searchforfishbite:
ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *50 *Trans0xff00ff %imagefolder%\FishStrike.png
if errorlevel = 0 
{
	Tooltip, ImageFound FishStrike.png, 0, 0
	fishstrike = 1
	goto fishstrike
}
if errorlevel = 1
{
	Tooltip, Finding Image... FishStrike.png, 0, 0
	ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 %imagefolder%\release.png		
	if errorlevel = 0 
	{
		goto clickkeep
	}
	ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *10 *Trans0xff00ff %imagefolder%\0.png
	if errorlevel = 0 
	{
		Tooltip, %Countup% Found Image... 0.png , 0, 0
		Countup++
		if (Countup = 3)
		{
			Countup = 0
			loop
			{
				send, {esc}
				sleep, 2000
				ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 %imagefolder%\gofishing.png
				if errorlevel = 0 
				{
					send, {esc}
					goto auto
					break
				}
				else
				{
					checkerror++
					if (checkerror = 3)
					{
						Keepflag = 1
						checkerror = 0
						goto clickkeep
					}
				}
				
			}
		}
	}
}
return

resetreel:
send, {Space up}
send, {Enter up}
send, {Shift Up}
Countup = 0
Tooltip, ,0 ,0
SetTimer, timertocheckerror, 30000
Loop
{
	send, {Shift Down}
	send, {Enter Down}
	send, {Space down}
	Sleep, 500
	ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *10 *Trans0xff00ff %imagefolder%\0.png
	if errorlevel = 0 
	{
		Tooltip, %Countup% Found Image... 0_00b004.png , 0, 0
		Countup++
		if (Countup = 3)
		{
			SetTimer, timertocheckerror, off
			Countup = 0
			break
		}
	}
	if errorlevel = 1
	{
		gosub, checkforgear
		Tooltip, Finding Image... 0.png , 0, 0
	}
}
return

checkforgear:
ToolTip, checkforgear..., 0, 0
ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *50 *Trans0xff00ff %imagefolder%\Check_00b004.png
if errorlevel = 0
{
	Keepflag = 1
	goto clickkeep
}

ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 %imagefolder%\release.png		
if errorlevel = 0 
{
	Keepflag = 1
	goto clickkeep
}
ImageSearch, coordx, coordy, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 %imagefolder%\close.png
if errorlevel = 0 
{
	Keepflag = 1
	goto clickkeep
}
ImageSearch, coordx, coordy, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 %imagefolder%\extend.png
if errorlevel = 0 
{
	Keepflag = 1
	goto clickkeep
}
ImageSearch, coordx, coordy, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 %imagefolder%\lvlupOK.png
if errorlevel = 0 
{
	Keepflag = 1
	goto clickkeep
}

return

clickkeep:
if (Keepflag = 1)
{
	Loop 3
	{
		ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 %imagefolder%\release.png	
		if errorlevel = 0
		{
			ImageSearch, coordx, coordy, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 %imagefolder%\KEEP.png
			if errorlevel = 0 
			{
				tooltip, KEEP.png
				send, {Ctrl down}
				Sleep, 100
				MouseMove, %coordx%, %coordy%
				Click
				Sleep, 100
				send, {Ctrl up}
				Sleep, 1000
				releasefish = 0
				goto auto
			}
			else
			{
				tooltip, Not found KEEP.png,0,0
				releasefish++
				if (releasefish = 3)
				{
					ImageSearch, coordx, coordy, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 %imagefolder%\release.png	
					if errorlevel = 0
					{
						send, {Ctrl down}
						Sleep, 100
						MouseMove, %coordx%, %coordy%
						Click
						Sleep, 100
						send, {Ctrl up}
						Sleep, 100
					}
					else
					{
						tooltip, Not found closechallange.png,0,0
					}
				}
			}
		}
	}
	
	ImageSearch, coordx, coordy, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 %imagefolder%\lvlupOK.png
	if errorlevel = 0
	{
		send, {Ctrl down}
		Sleep, 100
		MouseMove, %coordx%, %coordy%
		Click
		Sleep, 100
		send, {Ctrl up}
		Sleep, 100
	}
	else
	{
		tooltip, Not found lvlupOK.png,0,0
	}
	
	ImageSearch, coordx, coordy, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 %imagefolder%\close.png
	if errorlevel = 0
	{
		send, {Ctrl down}
		Sleep, 100
		MouseMove, %coordx%, %coordy%
		Click
		Sleep, 100
		send, {Ctrl up}
		Sleep, 100
	}
	else
	{
		tooltip, Not found closechallange.png,0,0
	}
	Keepflag = 0
	sleep 2000
}
return

fishstrike:
if (Fishstrike = 1)
{
	SetTimer, timertocheckerror, off
	Countup = 0
	sleep, 500
	loop 
	{
		send, {Shift Down}
		send, {Enter Down}
		Sleep, 500
		ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 %imagefolder%\release.png
		if errorlevel = 0 
		{
			send, {Shift Down}
			send, {Enter Down}
			Tooltip, ImageFound KEEP.png, 0, 0
			Keepflag = 1
			gone = 0
			break
		}
		if errorlevel = 1
		{
			send, {Shift Down}
			send, {Enter Down}
			ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *50 *Trans0xff00ff %imagefolder%\FishStrike.png
			if errorlevel = 0
			{
				Tooltip, Checking FishStrike... Fish still here., 0, 0
			}
			if errorlevel = 1
			{
				Tooltip, Checking FishStrike... Fish Gone, 0, 0
				gone++
				if (gone = 30)
				{
					gone = 0
					Fishstrike = 0
					goto resetreel
				}
			}
		}
	}
	send, {Shift up}
	send, {Enter up}
	Fishstrike = 0
}
return

RemoveToolTip:
ToolTip
return

cantkeep:
ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *50 *Trans0xff00ff %imagefolder%\FishStrike.png
if errorlevel = 0
{
	Tooltip, Checking FishStrike... Fish still here., 0, 0
}
return

timertocheckerror:
Keepflag = 1
checkerror = 0
goto clickkeep
return
