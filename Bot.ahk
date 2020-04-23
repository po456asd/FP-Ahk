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
	
	send, {Space up}
	send, {Enter up}
	send, {Shift Up}
	
	loop 4
	{
		send, {k}
		sleep, 250
	}
	send, {l}
	
	Loop
	{
		;Check Fishing Net
		ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 *Trans0xFFFFFF %imagefolder%\fullfishnet.png
		if errorlevel = 0 
		{
			Countup++
			If (Countup = 3)
			{
				Loop
				{
					;กดไปวันต่อไป
					Countup=0
					Send {t}
					loop 
					{
						ImageSearch, coordx, coordy, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 *Trans0xFFFFFF %imagefolder%\nextmorning.png
						if errorlevel = 0 
						{
							MouseClick, Left, coordx, coordy
							Loop 
							{
								ImageSearch, coordx, coordy, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 *Trans0xFFFFFF %imagefolder%\extend.png
								if errorlevel = 0 
								{
									MouseClick, Left, coordx, coordy
									Loop 
									{
										ImageSearch, coordx, coordy, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 *Trans0xFFFFFF %imagefolder%\closeresult.png
										if errorlevel = 0 
										{
											MouseClick, Left, coordx, coordy
											goto, starting
										}
									}
								}
							}
						}
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
	
	;checkforgear
	ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *50 *Trans0xFFFFFF %imagefolder%\Check_00b004.png
	if errorlevel = 0
	{
		Keepflag = 1
		goto clickkeep
	}
	
	ImageSearch, coordx, coordy, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 *Trans0xFFFFFF %imagefolder%\KEEP.png	
	if errorlevel = 0 
	{
		Keepflag = 1
		goto clickkeep
	}
	
	Countup=0
	Countup1=0
	
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
			
			;Search for fish bite
			ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *50 *Trans0xFFFFFF %imagefolder%\FishStrike.png
			if errorlevel = 0 
			{
				Tooltip, ImageFound FishStrike.png, 0, 0
				fishstrike = 1
				goto fishstrike
			}
			if errorlevel = 1
			{
				Tooltip, Finding Image... FishStrike.png, 0, 0
				ImageSearch, coordx, coordy, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 *Trans0xFFFFFF %imagefolder%\KEEP.png	
				if errorlevel = 0 
				{
					goto clickkeep
				}
				ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *10 *Trans0x00b004 %imagefolder%\0_00b004.png
				if errorlevel = 0 
				{
					Tooltip, %Countup% Found Image... 0_00b004.png , 0, 0
					Countup++
					if (Countup = 3)
					{
						Countup = 0
						loop
						{
							send, {esc}
							sleep, 2000
							ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 *Trans0xFFFFFF %imagefolder%\gofishing.png
							if errorlevel = 0 
							{
								send, {esc}
								goto auto
								break
							}
						}
					}
				}
			}
			
		}
	}
	If (Method = 2) {
		Loop %loopnumber1% {
			send, {Space down}
			Sleep, %Sleep3%
			Sleep, %Sleep4%
			send, {Enter Down}
			Sleep, %Sleep5%
			send, {Enter Up}
			;Search for fish bite
			ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *50 *Trans0xFFFFFF %imagefolder%\FishStrike.png
			if errorlevel = 0 
			{
				Tooltip, ImageFound FishStrike.png, 0, 0
				fishstrike = 1
				goto fishstrike
			}
			if errorlevel = 1
			{
				Tooltip, Finding Image... FishStrike.png, 0, 0
				ImageSearch, coordx, coordy, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 *Trans0xFFFFFF %imagefolder%\KEEP.png	
				if errorlevel = 0 
				{
					goto clickkeep
				}
				ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *10 *Trans0x00b004 %imagefolder%\0_00b004.png
				if errorlevel = 0 
				{
					Tooltip, %Countup% Found Image... 0_00b004.png , 0, 0
					Countup++
					if (Countup = 3)
					{
						Countup = 0
						loop
						{
							send, {esc}
							sleep, 2000
							ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 *Trans0xFFFFFF %imagefolder%\gofishing.png
							if errorlevel = 0 
							{
								send, {esc}
								sleep, 2000
								goto auto
								break
							}
						}
					}
				}
			}
		}
		send, {Space up}
	}
	
	resetreel:
	Countup = 0
	Tooltip, ,0 ,0
	Loop
	{
		send, {Shift Down}
		send, {Enter Down}
		send, {Space down}
		Sleep, 1000
		ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *10 *Trans0x00b004 %imagefolder%\0_00b004.png
		if errorlevel = 0 
		{
			Tooltip, %Countup% Found Image... 0_00b004.png , 0, 0
			Countup++
			if (Countup = 3)
			{
				Countup = 0
				break
			}
		}
		if errorlevel = 1
		{
			Tooltip, Finding Image... 0_00b004.png , 0, 0
		}
	}
	
	send, {Space up}
	send, {Enter up}
	send, {Shift Up}
	
	fishstrike:
	if (Fishstrike = 1)
	{
		Countup = 0
		sleep, 500
		loop 
		{
			send, {Shift Down}
			send, {Enter Down}
			Sleep, 500
			ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 *Trans0xFFFFFF %imagefolder%\KEEP.png	
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
				ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *50 *Trans0xFFFFFF %imagefolder%\FishStrike.png
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
	
	clickkeep:
	if (Keepflag = 1)
	{
		ImageSearch, coordx, coordy, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 *Trans0xFFFFFF %imagefolder%\KEEP.png	
		if errorlevel = 0 
		{
			tooltip, KEEP.png
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
			tooltip, Not found KEEP.png
		}
		ImageSearch, coordx, coordy, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 *Trans0xFFFFFF %imagefolder%\lvlupOK.png
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
			tooltip, lvlupOK.png
		}
		
		Keepflag = 0
	}
	Sleep 4000
	Tooltip, Resetting, 0, 0
}
return

F4::
loop
{
	sleep 500
	ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 *Trans0xFFFFFF %imagefolder%\fullfishnet.png
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

RemoveToolTip:
ToolTip
return