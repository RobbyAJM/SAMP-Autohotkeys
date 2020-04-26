; BTTDM ZS Commands Helper 2019 by RobbyAJM

Gui, Show , w450 h390, BTTDM ZS Commands Helper
Gui, Add, Text, Left x160 y15, HOTKEY INFORMATION
Gui, Add, Text, Left x30 y40, LEFT ALT + Q = Eat Cookie
Gui, Add, Text, Left, LEFT ALT + 1 = Cure Kit
Gui, Add, Text, Left, LEFT ALT + 2 = Medic Kit
Gui, Add, Text, Left, LEFT ALT + 3 = Posion Kit
Gui, Add, Text, Right x220 y40, RIGHT ALT + 1 = /truckjob
Gui, Add, Text, Right, RIGHT ALT + 2 = /truckjobmg
Gui, Add, Text, Right, RIGHT ALT + 3 = /truckjoblv
Gui, Add, Text, Right, LEFT ALT + K = /kits

Gui, Add, Text, Left x150 y170, ADMINISTRATOR HOTKEY
Gui, Add, Text, Left x15 y190, LEFT ALT + UP Arrow = Auto welcome back (for /a chat only)
Gui, Add, Text, Left, LEFT ALT + L = Auto generate event for 130 seconds (for bombevent only & random price)

Gui, Add, Text, Left x173 y270, SUPPORT HOTKEY
Gui, Add, Text, Left x30 y290, LEFT ALT + F1 = Restart script
Gui, Add, Text, Left, LEFT ALT + F2 = Suspend/Toggle/Disable script (on/off)

Gui, Add, Text, Center x310 y360, Coded by Coolio
Gui, Add, Button, x400 y355,  EXIT
return

; Function for welcome back auto matcher
StrTail(k,str)
   {
   Loop,Parse,str,`n
      {
      i := Mod(A_Index,k)
      L%i% = %A_LoopField%
      }
   L := L%i%
   Loop,% k-1
      {
      If i < 1
         SetEnv,i,%k%
      i-- ;Mod does not work here
      L := L%i% "`n" L
      }
    RegExMatch(L, "{bfff00}(.*)has just logged into admin account.", CapturedPlayerName)
    playerName = %CapturedPlayerName1%
    sendinput t/a Welcome back %playerName% {enter}
    ; Return L
}

<!F2::Suspend
<!L::
toggle:=!toggle
loop {
	Random, reward_type, 1, 3

	if(reward_type = 1){
		Random, reward_amount, 5, 22
		reward_name = Coins
	}
	if(reward_type = 2){
		Random, reward_amount, 1,5
		reward_name = Cookies
	}
	if(reward_type = 3){
		Random, reward_amount, 750, 3500
		reward_name = XPs
	}

	FormatTime, TimeString,, [HH:mm:ss] [dd MMMM yyyy]
	FormatTime, TimeOutput,, [HH:mm:ss]
	Random, location, 1, 7
	log = Random event generated, reward type: %reward_type%, reward amount: %reward_amount% %reward_name%, location: %location% {enter}

	send, t/bombevent %reward_type% %reward_amount% %location% {enter}
	sleep, 1000
	send, t/announce [1] /ec on event is not allowed. [2] TK and animations on event are allowed. {enter}
	sleep, 1000
	send, t/join {enter}
	sleep, 1000
	; send, t/a %TimeOutput% %log%
    FileAppend,%TimeString% %log% `n, %A_MyDocuments%\GTA San Andreas User Files\SAMP\bot-chatlog.txt
	sleep, 200000
} until !toggle
return

<!Up::
FileRead, Text, %A_MyDocuments%\GTA San Andreas User Files\SAMP\chatlog.txt
StrTail(20,Text)
Return
<!Q::sendinput t/ec{enter}
Return

<!K::sendinput t/kits{enter}
Return

<!1::sendinput t/ck{enter}
Return

<!2::sendinput t/mk{enter}
Return

<!3::sendinput t/pk{enter}
Return

>!1::sendinput t/truckjob{enter}
Return

>!2::sendinput t/truckjobmg{enter}
Return

>!3::sendinput t/truckjoblv{enter}
Return

<!F1::
reload
return

ButtonEXIT:
ExitApp

GuiClose: 
ExitApp