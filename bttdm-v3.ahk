Fileinstall, Open-SAMP-API.dll, Open-SAMP-API.dll, 1

#SingleInstance, force
#EscapeChar
#NoEnv
#include SAMP_API.ahk
#Include *i Colors.ahk

; Set the API's parameters
SetParam("use_window", "1")
SetParam("window", "GTA:SA:MP")

InputBox, MinHP, Define minimum healthpoint for auto /ec, Please define minimum Health Point (HP) for auto /ec (20 - 99)`r`nDefault: 40, , 390, 150

AutoEC := false
keybind := "{FFFFFF}[{fd746d}K{f16e7d}E{d863a6}Y{d15fb1}B{c257c8}I{b551dc}N{a045fd}D{ffffff}] "
choosenGreetings := 1

if(MinHP == ""){
	MinHP := 40
}

if(MinHP > 90){
	MinHP := 90
}else if(MinHP < 20){
	MinHP := 20
}

AdjustedMinHP := 8000000 + MinHP

; GUI Scripts

Gui, Margin, 0, 0
Gui, Add, Pic, w480 h240 hwndHPIC
Colors := [0xfd746d,0xa045fd]
If !LinearGradient(HPIC, Colors)
   MsgBox, 0, BTTDM ZS Keybinder 3.0, Funtion failed:`n%ErrorLevel%
Gui, Font, s42, Tahoma
Gui, Add, Text, xp yp wp hp cNavy Center 0x200 vTX1 BackgroundTrans, KEYBINDER 3.0
Gui, Show, , BTTDM ZS Keybinder 3.0

MsgBox Use ALT + M In-game to see all hotkeys.
SetTimer, AutoECInterval, 100
return

HasVal(haystack, needle) {
	if !(IsObject(haystack)) || (haystack.Length() = 0)
		return 0
	for index, value in haystack
		if (value = needle)
			return index
	return 0
}

AutoECInterval:
	global AdjustedMinHP

	if(!AutoEC){
		return
	}

	if(GetPlayerHealth() != 100 && GetPlayerHealth() <= AdjustedMinHP){
		SendChat("/ec")
		Sleep, 10000
	}
return

AutoECMessage(state){
	global keybind, MinHP
	if(state){
		AddChatMessage(keybind "Auto EC enabled.")
		AddChatMessage(keybind "Minimum HP: " MinHP)
	}else{
		AddChatMessage(keybind "Auto EC disabled.")
	}
}

; Function for welcome back auto matcher
StrTail(k,str, regex)
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
    RegExMatch(L, regex, capturedString)
	; return strTail2(capturedString)
	return capturedString
}


<!E::
	AutoEC:=!AutoEC
	AutoECMessage(AutoEC)
return

; Scripts suspend (like on/off function)
<!F2::
	Suspend
	if(A_IsSuspended){
		AddChatMessage(keybind "Scripts disabled.")
	}else{
		AddChatMessage(keybind "Scripts enabled.")
	}
return

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

<!Numpad7::
	SendChat("/bombevent 2 5 1")
Return

<!Numpad8::
	SendChat("/ann /ec at event isn't allowed")
	SendChat("/join")
Return

<!Numpad5::
	SendChat("/join")
Return

<!XButton2::sendinput t/r ya{enter}
Return

<!XButton1::sendinput t/r ?{enter}
Return

<!F::sendinput t/shop {enter}
Return

<!G::
Send {Down}
Send {Down}
Send {Down}
Send {Down}
Send {Enter}
Return

>!1::
	GetPlayerPosition(X,Y,Z)
	Random, XPrediction, 1, 5500
	if(X > 950 && X < 1000){
		AddChatMessage(keybind "You're at LV Depot!")
		AddChatMessage(keybind "My prediction you'll got " XPrediction " XPs.")
		SendChat("/truckjoblv")
		AddChatMessage(keybind "Thanks me later :-)")
	}else if(X > 1400 && X < 1450){
		AddChatMessage(keybind "You're at MG Depot!")
		SendChat("/truckjobmg")
		AddChatMessage(keybind "Thanks me later :-)")
		AddChatMessage(keybind "My prediction you'll got " XPrediction " XPs.")
	}else if(X > 2725 && X < 2775){
		AddChatMessage(keybind "You're at LS Depot!")
		SendChat("/truckjob")
		AddChatMessage(keybind "Thanks me later :-)")
		AddChatMessage(keybind "My prediction you'll got " XPrediction " XPs.")
	}else{
		AddChatMessage(X)
		AddChatMessage(keybind "Woops, you aren't at the truckpoint.")
	}
return

<!4::
	SendChat("/cure " GetPlayerID())
	AddChatMessage(keybind "Succesfully cured yourself!")
Return

<!5::
	FileRead, Text, %A_MyDocuments%\GTA San Andreas User Files\SAMP\chatlog.txt
	playername := StrTail(6, Text, "(?<={DCDCDC} )[^\r\n]*?(?={FFFFFF} has been infected)")
	playerid := GetPlayerIDByName(playername)
	AddChatMessage(keybind "Details:")
	AddChatMessage(keybind playername)
	AddChatMessage(keybind playerid)
return

Greetings()
{
	global choosenGreetings
	choosenGreetings := choosenGreetings + 1
	if(choosenGreetings >= 14){
		choosenGreetings := 1
	}

	if(choosenGreetings = 1){
		return "Welcome back "
	}else if(choosenGreetings == 2){
		Return "WB "
	}else if(choosenGreetings == 3){
		Return "welcome "
	}else if(choosenGreetings == 4){
		Return "Welcome back brother "
	}else if(choosenGreetings == 5){
		Return "welcome back "
	}else if(choosenGreetings == 6){
		Return "wb man "
	}else if(choosenGreetings == 7){
		Return "Welcome brother "
	}else if(choosenGreetings == 8){
		Return "wb "
	}else if(choosenGreetings == 9){
		Return "wb brother "
	}else if(choosenGreetings == 10){
		Return "wb bro "
	}else if(choosenGreetings == 11){
		Return "yo wb "
	}else if(choosenGreetings == 12){
		Return "yow welcome back "
	}else if(choosenGreetings == 13){
		Return "Welcome back man "
	}
}

Salutations()
{
	Random, choosenSalutations, 1,4
	if(choosenSalutations == 1){
		Return "Thank you "
	}else if(choosenSalutations == 2){
		Return "thanksss "
	}else if(choosenSalutations == 3){
		Return "thanks "
	}else if(choosenSalutations == 4){
		Return "tyyy "
	}
}

TinySalutations()
{
	Random, choosenSalutations, 1,3
	if(choosenSalutations == 1){
		Return "thank you "
	}else if(choosenSalutations == 2){
		Return "ty "
	}else if(choosenSalutations == 3){
		Return "ty bro "
	}
}

sanitizeUsername(playername, state = false)
{
	playername := StrReplace(playername, "Server", "")
	playername := StrReplace(playername, "Head", "")
	playername := StrReplace(playername, "Director", "")
	playername := StrReplace(playername, "ZS Coordinator", "")
	playername := StrReplace(playername, "Manager", "")
	playername := StrReplace(playername, "Head", "")
	playername := StrReplace(playername, "Senior", "")
	playername := StrReplace(playername, "Admin", "")
	playername := StrReplace(playername, "Moderator", "")
	playername := StrReplace(playername, "Junior", "")
	playername := StrReplace(playername, A_SPACE, "")
	if(state){
		RegExMatch(playername, "(?<=\[)[^\r\n]*?(?=\])", bracket)
		playername := StrReplace(playername, bracket)
		playername := StrReplace(playername, "[")
		playername := StrReplace(playername, "]")
		StringLower, playername, playername
		playername := StrReplace(playername, 0)
		playername := StrReplace(playername, 1)
		playername := StrReplace(playername, 2)
		playername := StrReplace(playername, 3)
		playername := StrReplace(playername, 4)
		playername := StrReplace(playername, 5)
		playername := StrReplace(playername, 6)
		playername := StrReplace(playername, 7)
		playername := StrReplace(playername, 8)
		playername := StrReplace(playername, 9)
		RegExMatch(playername,"\..*", surname)
		playername := StrReplace(playername, surname)
	}
	return playername
}

<!Up::
	FileRead, Text, %A_MyDocuments%\GTA San Andreas User Files\SAMP\chatlog.txt
	greetings := Greetings()
	playername := StrTail(8, Text, "(?<={bfff00})[^\r\n]*?(?=has just logged into)")
	playername := sanitizeUsername(playername)
	SendChat("/a " greetings playername)
	AddChatMessage("/a " greetings playername)
Return

<!Down::
	FileRead, string, %A_MyDocuments%\GTA San Andreas User Files\SAMP\chatlog.txt
	salutation := Salutations()
	vOutput := ""
	playernames := []
	VarSetCapacity(vOutput, StrLen(string)*2)
	GetPlayerName(loggedPlayerName, 20)
	loggedPlayerName = sanitizeUsername(loggedPlayerName)
	Loop, Parse, string, `n, `r
	{
		RegExMatch(A_LoopField, "(?<={ccff99})[^\r\n]*?(?=:{66ffff} (WB|wb|Wb|Wel|wel|Ay w|ay W|Ay W| ay W))", match)
		match := sanitizeUsername(match)
		if(match){
			if(match != loggedPlayerName && hasVal(playernames,match) == 0){
				vOutput .= match ", "
				playernames[A_Index] := match
			}
		}
	}
	vOutput := SubStr(vOutput, 1, -2)
	SendChat("/a " salutation vOutput)
	AddChatMessage("/a " salutation vOutput)
Return

<!Left::
	FileRead, Text, %A_MyDocuments%\GTA San Andreas User Files\SAMP\chatlog.txt
	greetings := Greetings()
	playername := StrTail(8, Text, "(?<={bfff00})[^\r\n]*?(?=has just logged into)")
	playername := sanitizeUsername(playername, true)
	SendChat("/a " greetings playername)
	AddChatMessage("/a " greetings playername)
Return

<!Right::
	FileRead, string, %A_MyDocuments%\GTA San Andreas User Files\SAMP\chatlog.txt
	salutation := Salutations()
	vOutput := ""
	playernames := []
	VarSetCapacity(vOutput, StrLen(string)*2)
	GetPlayerName(loggedPlayerName, 20)
	loggedPlayerName = sanitizeUsername(loggedPlayerName, true)
	Loop, Parse, string, `n, `r
	{
		RegExMatch(A_LoopField, "(?<={ccff99})[^\r\n]*?(?=:{66ffff} (WB|wb|Wb|Wel|wel|Ay w|ay W|Ay W| ay W))", match)
		match := sanitizeUsername(match, true)
		if(match){
			if(match != loggedPlayerName && hasVal(playernames,match) == 0){
				vOutput .= match ", "
				playernames[A_Index] := match
			}
		}
	}
	vOutput := SubStr(vOutput, 1, -2)
	SendChat("/a " salutation vOutput)
	AddChatMessage("/a " salutation vOutput)
Return

<!RCtrl::
	FileRead, Text, %A_MyDocuments%\GTA San Andreas User Files\SAMP\chatlog.txt
	salutation := TinySalutations()
	playername := StrTail(3, Text, "(?<={ccff99})[^\r\n]*?(?=:{66ffff} (WB|wb|Wb|Wel|wel|Ay w|ay W|Ay W| ay W))")
	playername := sanitizeUsername(playername, true)
	SendChat("/a " salutation playername)
	AddChatMessage("/a " salutation playername)
Return

<!Numpad3::
	GetPlayerPosition(X,Y,Z)
	GetPlayerName(loggedPlayername, 20)
	AddChatMessage(X " " Y " " Z)
	AddChatMessage(loggedPlayername)
return

<!M::
    text = 
    (
{FFFFFF}[{fd746d}K{f16e7d}E{d863a6}Y{d15fb1}B{c257c8}I{b551dc}N{a045fd}D{ffffff}] Version {ff0000}3{ffffff}.{ff0000}0

{1934ff}[{ff0000}*{1934ff}]{ffffff} General Keys
  LEFT ALT + E for Toggle auto /ec (on/off)
  LEFT ALT + Q for /ec
  LEFT AlT + 1 for /ck
  LEFT ALT + 2 for /mk
  LEFT ALT + 3 for /pk
  LEFT ALT + 4 for /cure [your id]
  LEFT ALT + 5 for Get latest infected player
  LEFT ALT + K for /kits
  RIGHT ALT + 1 for Truckjob (auto detect ls,mg or lv)

{1934ff}[{ff0000}*{1934ff}]{ffffff} Admin Keys
  LEFT ALT + UP for automated welcome back
  LEFT ALT + DOWN for automated saying thanks after login
  LEFT ALT + LEFT for automated welcome back with sanitized username
  LEFT ALT + RIGHT for automated saying thanks after login with sanitized username
  LEFT ALT + Numpad 7 for auto bomb event (Reward: 5 cookies)
  LEFT ALT + Numpad 8 for announce event rules & auto /join event

{1934ff}[{ff0000}*{1934ff}]{ffffff} Support Keys
  LEFT ALT + F1 Restart the autohotkey (becareful, you might be crashed)
  LEFT ALT + F2 Toggle autohotkey script (on/off)
  LEFT ALT + Numpad 3 to show your player stats (debug purposes)

{1934ff}[{ff0000}*{1934ff}]{ffffff} Known Bugs
  - Sometime the game crashes if you restart the script while the game is on.
    Current Solution: Don't restart the script, try close & open the autohotkey script manually.

Coded by {fd746d}C{f16e7d}o{d863a6}o{d15fb1}l{c257c8}i{b551dc}o{ffffff} with {ff1994}<3 
    )
    ShowDialog(5000, 0, "BTTDM ZS Keybinder 3.0", text, "Close","")
return

<!0::
	AddChatMessage(keybind "Looping")
	loop 75 {
		SendChat("/get " A_Index)
		Sleep, 100
	}
	AddChatMessage(keybind "All done")
return


; Scripts reload function
<!F1::
	reload
return

GuiClose:
	ExitApp
return