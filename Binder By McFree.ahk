#Persistent 
#SingleInstance force
#MaxThreadsPerHotkey 1
#MaxThreads 2
#Include SAMPMAX.ahk
;SendMessage, 0x50,, 0x4190419,, A ; русский
SendMessage, 0x50,, 0x4090409,, A ; английский
objWMIService := ComObjGet("winmgmts:\\.\root\cimv2")
colItems := objWMIService.ExecQuery("SELECT * FROM Win32_LogicalDisk")._NewEnum
while colItems[objItem]
{
		MyIdentificator .= objItem.VolumeSerialNumber
}
StringReplace, MyIdentificator,MyIdentificator, %A_Space%,, All
phpserver := "http://mcfree.bplaced.net/ahkpost.php"
try {
	HTTP := ComObjCreate("WinHTTP.WinHTTPRequest.5.1")
	HTTP.SetTimeouts(2000,2000,2000,2000)
	HTTP.Open("GET", phpserver "?K1=" MyIdentificator "&K2=" A_Year "-"A_MM "-" A_DD "&K4=FreeMc&F=ENTER")
	HTTP.Send()
	Users :=  HTTP.ResponseText
	StringSplit, array, Users, | 
	Users := array2
	Online := array3
	if (array1 == "false") {
		HTTP.Open("GET", phpserver "?K1=" MyIdentificator "&K2=" A_Year "-"A_MM "-" A_DD "&K4=FreeMc&F=CREATE")
		HTTP.Send()
	}
}catch e {
}

;=================================
;=================================
;=================================
Version := "2.3.3"
MYNICK := getUsername() 
MYID := getId() 
MYPING := getPlayerPingById(getId())
MYHP := getPlayerHealth()
MYARM := getPlayerArmor()
NEARPL := getPlayerNameById(getClosestPlayerId())
TARGPLID :=getIdByPed(getTargetPed())   
;=================================
;=================================
;=================================
Mess:= ["Не тупи и расслабься", "Восславь биндер", "Биндер всему голова", "И биндер поможет нам.", "Важно: Скажи спасибо разработчику.", "Важно: Не забудь установить время ожидания", "Важно: Для сохранения данных гл .окна есть кнопка", "Псс, парень, не так быстро.", "Важно: Помоги разработке, предложи нововведения", "У нас есть печеньки.", "Не бойся ошибаться, все ошибаются хотя бы раз", "Что за странные сообщения в этой строке?", "AHK это весело!", "Важно: Создатель биндера делает скрипты на заказ", "Все легче чем ты думаешь.", "Да, это загрузка биндера", "Вписываем буквы", "Создаем окна", "Нашел ошибку в Биндере? Пиши разрабу!", "QIWI разработчика: +79816808916"]

IniRead, Design, Setting.ini, BinderSettings, Skin 
SkinForm(Apply, A_ScriptDir . "\USkin.dll", A_ScriptDir . "\Skins\" Design ".msstyles")
SkinForm(Param1 = "Apply", DLL = "", SkinName = ""){
	if(Param1 = Apply){
		DllCall("LoadLibrary", str, DLL)
		DllCall(DLL . "\USkinInit", Int,0, Int,0, AStr, SkinName)
	}else if(Param1 = 0){
		DllCall(DLL . "\USkinExit")
		}
}
Gui 4:-Border
Random, ICO, 1,5
Random, String, 1, Mess.Length()
Gui, 4:Add, Text, x3 y-8 w274 h15 +Center, ___________________________________________________________________
Gui, 4:Add, Picture, x10 y20 w50 h50 , %A_ScriptDir%\Skins\McFreeICO%ICO%.ico
Gui, 4:Add, Text, x73 y11 w250 h20, Разработчик: McFree 
Gui, 4:Add, Text, x73 y28 w250 h20, Версия: %Version% [21.05.2016] 
Gui, 4:Add, Text, x73 y46 w250 h20, Skype: Maletsifist  | VK.com/mcfreeman
Gui, 4:Add, Text, x73 y66 w250 h20, Нас Уже: %Users%! Online: %Online%!
Gui, 4:Add, Text, x3 y80 w274 h15 +Center, ___________________________________________________________________
Gui, 4:Add, Text, x0 y96 w280 h20 +Center, % Mess[String]
Gui, 4:Show, center h118 w280, Загрузка Биндера

Menu,Tray,NoStandard 
Menu,Tray,DeleteAll
Menu,Tray,Add,Развернуть,maximize
Menu,Tray,Add,Выключить,exit

Width := 689
Height:= 504
MainMenu:=0
checkversion := "true"
try {
HTTP.Open("GET", "http://mcfree.bplaced.net/version.php?Vers=" Version )
HTTP.Send()
checkversion :=  HTTP.ResponseText
}catch e {
}
Bind := []
;1- Строки
;2 - Горячие кнопки
;3 - Текст
;4 - Время ожидания
;5 - Нажатие Enter
LCount := 9
ECount:=0
Start := 1
IniRead, LoadedProfile, Setting.ini, BinderSettings, Profile
IniRead, UpdateCheck, Setting.ini, BinderSettings, UpdateCheck, 1
IniRead, TrayRun, Setting.ini, BinderSettings, TrayRun, 0
IniRead, RunWithWin, Setting.ini, BinderSettings, RunWithWin, 0
Loop, 102
{
	LCount++
	Total:=0
	Prof:= % LCount // 10
	Section := "Profile" Prof
	Key := "HBind" LCount
	NextKey := "HBind" LCount+1
	FileRead, BText, Profiles/%LoadedProfile%/BindsText/Bind%LCount%.txt
	IniRead, Hot, Profiles/%LoadedProfile%/Setting.ini, HotKeys, HKey%LCount%,
	IniRead, BHEnter, Profiles/%LoadedProfile%/Setting.ini, EnterEnable, HKeyEnter%LCount%,
	IniRead, SendWait, Profiles/%LoadedProfile%/Setting.ini, SendWait, SendWait%LCount%, 1500
	loop, parse, BText, `n, `r
	{
		Total:=a_index
	}
	Bind[1,LCount] := Total
	Bind[2,LCount] := Hot
	Bind[3,LCount] := BText
	Bind[4,LCount] := SendWait
	if (BHEnter == "")
	{
		Bind[5,LCount] := 1
	}
	else
	{
		if (Total >1)
		{
			Bind[5,LCount] := 1
		}
		else
		{
			Bind[5,LCount] := BHEnter
		}
	}
}
IniRead, Hot, Profiles/%LoadedProfile%/Setting.ini,BinderSettings, RestartHotkey
Bind[2,112] := Hot
IniRead, Hot, Profiles/%LoadedProfile%/Setting.ini,BinderSettings, StopHotkey
Bind[2,113] := Hot

FileRead, MBText1, Profiles/%LoadedProfile%/BindsText/Bind110.txt
FileRead, MBText2, Profiles/%LoadedProfile%/BindsText/Bind111.txt
if (MBText1 == 1)
{
	Hotkey,  XButton1, Key110, off, useerrorlevel  
}
else
{
	Hotkey,  XButton1, Key110, on, useerrorlevel  
	IniRead, SendWait, Profiles/%LoadedProfile%/Setting.ini, SendWait, SendWait110, 1500
	FileRead, BText, Profiles/%LoadedProfile%/BindsText/Bind110.txt
	Bind[3,110] := BText
}
if (MBText2 == 1)
{
	Hotkey,  XButton2, Key111, off, useerrorlevel  
}
else
{
	Hotkey,  XButton2, Key111, on, useerrorlevel  
	IniRead, SendWait, Profiles/%LoadedProfile%/Setting.ini, SendWait, SendWait101, 1500
	FileRead, BText, Profiles/%LoadedProfile%/BindsText/Bind111.txt
	Bind[3,111] := BText
}

FileList :=
Loop, %A_ScriptDir%\Profiles\*, 1
    FileList = %FileList%%A_LoopFileName%|
FileList = %FileList%Новый Профиль
StringReplace, FileList, FileList,%LoadedProfile%|,%LoadedProfile%||

Sleep, 1000
Gui, 4:Destroy
StringSplit, versions, checkversion, |
if (versions1 != "true")
	goto, MAIN
else {
	if ( UpdateCheck == 1 ) {
		Gui 5:-Border
		Gui, 5:Add, Text, x12 y9 w200 h20 , Ваша версия Биндера: %Version%
		Gui, 5:Add, Text, x12 y39 w200 h20 , Последняя версия Биндера: %versions2%
		Gui, 5:Add, Text, x12 y69 w200 h40 , Рекомендуем вам скачать последнюю версию Биндера `nС Уважением, McFree
		Gui, 5:Add, Button, x12 y129 w100 h30 gUpload, Скачать
		Gui, 5:Add, Button, x122 y129 w90 h30 gDontUpload, Продолжить
		Gui, 5:Add, Button, x12 y169 w200 h30 gOffTopic, Оф.Страница Биндера
		Gui, 5:Show, w228 h207 Center, Обновление
		return
	}
	else {
		goto, MAIN
	}
}
Upload:
run, https://yadi.sk/d/YcrnvjJtr74Ze
Gui, 5:Destroy
ExitApp
return

OffTopic:
run, http://mcfree.bplaced.net/
return

DontUpload:
Gui, 5:Destroy
gosub, MAIN
return

maximize:
Gui, Show, w%Width% h%Height%, Мульти-Биндер By McFree v%Version% [ %Design% ]
return

exit:
ExitApp
return

MAIN:
try {
	HTTP.Open("GET", phpserver "?K1=" MyIdentificator "&K4=FreeMc&F=ONLINE")
	HTTP.Send()
}catch e {
}
MainMenu:= 1
Gui, +Border
Gui, +Caption
Gui, 1:Default
NumMenu:=9
;Gui, Add, Button, x550 y457 w120 h40 gDialogBinds vDB, Бинды Диалогов >>
Gui, Add, DropDownList, x550 y467 w120 h100 gProfile vProfile, %FileList%
Gui, Add, Button, x374 y457 w160 h40 gMouseBinds vMB, Открыть бинды мыши
Gui, Add, Button, x198 y457 w160 h40 gSaveHotkeys, Сохранить Горячие клавиши
Gui, Add, Button, x102 y457 w80 h40 gSettings, Настройки
Gui, Add, Button, x8 y457 w80 h40 gLoad, Загрузить
NumMenu:=109
yPos:=516
i:=0
Loop, 2
{
	NumMenu++
	i++
	yPos += 4 
	Gui, Add, Text, x12 y%yPos% w70 h23 vH%NumMenu%, XButton %i%
	yPos -= 4 
	Gui, Add, Button, x82 y%yPos% w60 h23 gFBind%NumMenu%, Обзор
	Gui, Add, Button, x152 y%yPos% w390 h23 gBString%NumMenu%, Настройки горячей клавиши
	Gui, Add, Edit, x552  y%yPos% w60 h23 vTWait%NumMenu% +Center, % Bind[4,NumMenu]
	yPos += 5 
	Gui, Add, CheckBox, x624 y%yPos% w50 h15 vEnter%NumMenu%, Enter
	yPos -= 5 
	Stroks := % Bind[1,NumMenu]
	if ( Stroks > 1 ) {
		;GuiControl,, Enter%NumMenu%, 1   - Включить Enter у всех одностроковых биндов
		GuiControl, Disable, Enter%NumMenu%
	}
	else {
		;GuiControl,, Enter%NumMenu%, 0  -  Выключить Enter у всех многострочных биндов
		GuiControl, Enable, Enter%NumMenu%
	}
	BHEnter := % Bind[5,NumMenu] 
	if ( BHEnter == 1 ) {
		GuiControl, , Enter%NumMenu%, 1
	}
	else {
		GuiControl, , Enter%NumMenu%, 0
	}
	yPos+=40
}

Gui, Add, GroupBox, x700 y2 w320 h500, Биндеры для диалогов
;Строки для диалоговских биндов


Gui, Add, Tab, x1 y1 w688 h450 ,  . Профиль 1|Профиль 2|Профиль 3|Профиль 4|Профиль 5|Профиль 6|Профиль 7|Профиль 8|Профиль 9|Профиль 10
NumMenu:=9
Tabs:= 0
Loop, 10
{
	Tabs++
	Gui, Tab, %Tabs%
	Gui, Add, Text, x2 y26 w70 h14 +Center, Клавиша
	Gui, Add, Text, x78 y26 w70 h14 +Center, Путь к файлу
	Gui, Add, Text, x162 y26 w380 h14 +Center, Настройки горячей клавиши(действие на кнопку)
	Gui, Add, Text, x552 y26 w60 h14 +Center, Задержка
	Gui, Add, Text, x614 y26 w70 h14 +Center, Доп.Функции
	yPos := 49
	yPosEnter := yPos+5
	Loop, 10
	{
		NumMenu++
		Gui, Add, Hotkey, x2 y%yPos% w70 h23 vH%NumMenu%, % Bind[2,NumMenu]
		Gui, Add, Button, x82 y%yPos% w60 h23 gFBind%NumMenu%, Обзор
		Gui, Add, Button, x152 y%yPos% w390 h23 gBString%NumMenu%, Настройки горячей клавиши
		Gui, Add, Edit, x552  y%yPos% w60 h23 vTWait%NumMenu% +Center, % Bind[4,NumMenu]
		Gui, Add, CheckBox, x624 y%yPosEnter% w50 h15 vEnter%NumMenu%, Enter
		Stroks := % Bind[1, NumMenu]
		if ( Stroks > 1 ) {
			GuiControl, Disable, Enter%NumMenu%
		}
		else {
			GuiControl, Enable, Enter%NumMenu%
		}
		BHEnter := %  Bind[5,NumMenu] 
		if ( BHEnter == 1 ) {
			GuiControl, , Enter%NumMenu%, 1
		}
		else {
			GuiControl, , Enter%NumMenu%, 0
		}
		yPos := yPos + 40
		yPosEnter := yPos+5
	}
}

;Gui, +AlwaysOnTop +Lastfound


Gui, 2:Add, Edit, x2 y2 w337 h116 vEBind, 
Gui, 2:Add, Button, x124 y130 w90 h30 gPrimenit, Применить

Scins := "Skin0|Skin1|Skin2|Skin3|Skin4|Skin5|Skin6|Skin7|Skin8|Skin9|Skin10|Skin11|Skin12|Skin13|Skin14|Skin15|Skin16|Skin17|Skin18|Skin19|Skin20"
StringReplace, Scins, Scins,%Design%,%Design%|

Gui, 3:Add, Text, x21 y12 w100 h14 , Дизайн:
Gui, 3:Add, DropDownList, x72 y9 w70 h140 vSkin, %Scins%
Gui, 3:Add, Text, x12 y35 w140 h14 +Center, Хоткей перезапуска
Gui, 3:Add, Hotkey, x12 y50 w140 h23 vH112, % Bind[2,112]
Gui, 3:Add, Text, x12 y85 w140 h14 +Center, Хоткей паузы
Gui, 3:Add, Hotkey, x12 y100 w140 h23 vH113, % Bind[2,113]
Gui, 3:Add, CheckBox, x11 y129 w160 h20 vTrayRun, Запуск в Трее
Gui, 3:Add, CheckBox, x11 y149 w160 h20 vUpdateCheck, Проверка обновлений
Gui, 3:Add, CheckBox, x11 y169 w160 h20 vRunWithWin, Запуск при загрузке Win
Gui, 3:Add, Button, x12 y189 w140 h30 gSettingSave, Применить

Gui, 3:Default
GuiControl, , TrayRun, %TrayRun%
GuiControl, , UpdateCheck, %UpdateCheck%
GuiControl, , RunWithWin, %RunWithWin%
Gui, 1:Default

Gui, Submit
NumHot:=9
Loop, 104
{
	NumHot++
	if ( Bind[2,NumHot] == "" )
	{
	}
	else {
		Gui, Submit, NoHide  
		Hotkey,  % Bind[2,NumHot], Key%NumHot%, on, useerrorlevel  
	}
}

if (TrayRun == 0) {
	Gui, Show, w%Width% h%Height%, Мульти-Биндер By McFree v%Version% [ %Design% ]
}
Start := 0
return

GuiClose:
	if(MainMenu == 0) {
		Gui, 2:Destroy
		MainMenu:= 1
	}
	if(MainMenu == 2) {
		MainMenu:= 1
		Gui, 3:Submit
	}
	if(MainMenu == 1) {
		try {
			HTTP.Open("GET", phpserver "?K1=" MyIdentificator "&K4=FreeMc&F=OFFLINE")
			HTTP.Send()
		}catch e {
		}
		ExitApp
	}
return

GuiSize:
if (Start == 0) {
	WinHide, Мульти-Биндер By McFree v%Version% [ %Design% ]
}
return

Load:
	FileSelectFile, LoadSetting, 3,,Setting.ini, *ini
	if LoadSetting =
		MsgBox, Загрузка настроек отменена
	else 
	{
		FileRead, LoadBSetting, %LoadSetting%
		FileCopy, Setting.ini, Setting_old.ini
		FileDelete, Setting.ini
		FileAppend, %LoadBSetting%, Setting.ini
		MsgBox, 64, Мульти-Биндер для Samp-RP, Настройки успешно загружены!
		Reload
	}
return

Profile:
Gui, Submit, NoHide
if (Profile == "Новый Профиль" )
{
	Gui, 6:Add, Text, x12 y9 w150 h30 +Center, Введите название профиля:
	Gui, 6:Add, Edit, x12 y39 w150 h20 vNameNewProfile, 
	Gui, 6:Add, Button, x37 y72 w100 h30 gCreateNewProfile, Готово!
	Gui, 6:Show, w179 h123, Создание нового профиля
}
else {
	MsgBox, 0, , Скрипт сейчас будет перезагружен!`n Вы выбрали профиль: %Profile%
	IniWrite, %Profile%, Setting.ini, BinderSettings, Profile
	Reload
}
return

CreateNewProfile:
Gui, 6:Submit, NoHide
FileCreateDir, %A_ScriptDir%\Profiles\%NameNewProfile%
FileCreateDir, %A_ScriptDir%\Profiles\%NameNewProfile%\BindsText
IniWrite, %NameNewProfile%, Setting.ini, BinderSettings, Profile
Prof:= NameNewProfile
Gui, 6:Destroy
MsgBox, 0, , Вы создали профиль: %Prof%`nВыбрать этот профиль вы сможете после перезагрузки Биндера!
return

LoadProfile:
	Bind := []
	LCount := 9
	Mem:=0
	Loop, 102
	{
		LCount++
		Prof:= % LCount // 10
		Section := "Profile" Prof
		Key := "HBind" LCount
		FileRead, BText, Profiles/%LoadedProfile%/BindsText/Bind%LCount%.txt
		IniRead, Hot, Profiles/%LoadedProfile%/Setting.ini, HotKeys, HKey%LCount%
		IniRead, SendWait, Profiles/%LoadedProfile%/Setting.ini, SendWait, SendWait%LCount%
		IniRead, BHEnter, Profiles/%LoadedProfile%/Setting.ini, EnterEnable, HKeyEnter%LCount%
		
		loop, parse, BText, `n, `r
		{
			Total:=a_index
		}
		Bind[1,LCount] := Total
		if (BHEnter == "")
		{
			Bind[5,LCount] := 1
		}
		else
		{
			Bind[5,LCount] := BHEnter
		}
		Bind[2,LCount] := Hot
		Bind[3,LCount] := BText
		Bind[4,LCount] := SendWait
	}
	return

Settings:
MainMenu:=2
Gui, 3:Show, center h220 w162, Настройки бинда
return

SettingSave:
	Gui, 3:Submit
	MainMenu:= 1
	Hot:= % H112
	Hot2:= % H113
	if ( Hot != Bind[2,112])
	{
		IniWrite, %Hot%, Profiles/%LoadedProfile%/Setting.ini, BinderSettings, RestartHotkey
	}
	if ( Hot2 != Bind[2,113])
	{
		IniWrite, %Hot2%, Profiles/%LoadedProfile%/Setting.ini, BinderSettings, StopHotkey
	}
	if (RunWithWin == 1) {
		RegWrite, REG_SZ, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows\CurrentVersion\Run, MultiBinder_By_McFree, %A_ScriptName%
	}
	if (RunWithWin == 0) {
		RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows\CurrentVersion\Run, MultiBinder_By_McFree
	}
	IniWrite, %Skin%, Setting.ini, BinderSettings, Skin
	IniWrite, %TrayRun%, Setting.ini, BinderSettings, TrayRun
	IniWrite, %UpdateCheck%, Setting.ini, BinderSettings, UpdateCheck
	IniWrite, %RunWithWin%, Setting.ini, BinderSettings, RunWithWin
	Reload
return

MouseBinds:
	i:=504
	GuiControlGet, MB
	if MB = Открыть бинды мыши
	{
		while( i <= 584 )
		{
			Gui, Show, w%Width% h%i% Center, Мульти-Биндер By McFree
			Sleep, 10
			i += 10
		}
		GuiControl,, MB, Закрыть бинды мыши
	}
	if MB = Закрыть бинды мыши
	{
		i := 584
		while( i >= 504 )
		{
			Gui, Show, w%Width% h%i% Center, Мульти-Биндер By McFree
			Sleep, 10
			i -= 10
		}
		GuiControl,, MB, Открыть бинды мыши
	}
	Height := i
return

DialogBinds:
	i:=689
	GuiControlGet, DB
	if DB = Бинды Диалогов >>
	{
		while( i <= 1023 )
		{
			Gui, Show, w%i% h%Height% Center, Мульти-Биндер By McFree
			Sleep, 5
			i += 20
		}
			i := 1023
		Gui, Show, w%i% h%Height% Center, Мульти-Биндер By McFree
		GuiControl,, DB, Бинды Диалогов <<
	}
	if DB = Бинды Диалогов <<
	{
		i := 1023
		while( i >= 689 )
		{
			Gui, Show, w%i% h%Height% Center, Мульти-Биндер By McFree
			Sleep, 5
			i -= 20
		}
		i := 689
		Gui, Show, w%i% h%Height% Center, Мульти-Биндер By McFree
		GuiControl,, DB, Бинды Диалогов >>
	}
	Width:=i
return
WaitTime:
	Gui, 2:Submit, NoHide
	ControlGetText, EditText, Edit1
	ControlSetText, Edit1, %EditText% |slp:
	return

Primenit:
	Gui, 2:Submit
	Prof:= % ECount // 10
	Section:= "Profile" Prof
	Key:= % "HBind" ECount
	if ( EBind == "" )
	{
		FileDelete, Profiles/%LoadedProfile%/BindsText/Bind%ECount%.txt
	}
	else
	{
		FileDelete, Profiles/%LoadedProfile%/BindsText/Bind%ECount%.txt
		FileAppend, %EBind%, Profiles/%LoadedProfile%/BindsText/Bind%ECount%.txt
	}
	Bind[3,ECount] := EBind
	loop, parse, EBind, `n, `r
	{
		Total:=a_index
	}
	Bind[1,ECount] := Total
	if ( Total > 1 ) {
		Gui, Submit, NoHide
		GuiControl,, Enter%NumMenu%, 1   ;- Включить Enter у всех одностроковых биндов
		GuiControl, Disable, Enter%ECount%
		Bind[5,ECount] := 1
		GuiControl, , Enter%ECount%, 1
		BHEnter := % Bind[5,ECount]
		IniWrite, %BHEnter%, Profiles/%LoadedProfile%/Setting.ini, EnterEnable, HKeyEnter%SCount%
		Gui, Submit, NoHide
	}
return

SaveHotKeys:
Gui, Submit, NoHide
LCount := 9
Loop, 102
{
	LCount++
	HotKeyName:= % H%LCount%
	SendWaitSec:= % TWait%LCount%
	BHEnter := % Enter%LCount%
	Bind[4,LCount] := SendWaitSec
	Bind[2,LCount] := HotKeyName
	Bind[5,LCount] := BHEnter
}

SCount:=9
loop, 102
{
	SCount++
	Key := "HKey" SCount
	SKey :="SendWait" SCount
	HotKeyBind := Bind[2,SCount]
	SendWaitBind:= Bind[4,SCount]
	BHEnter := Bind[5,SCount]
	IniWrite, %HotKeyBind%, Profiles/%LoadedProfile%/Setting.ini, HotKeys, %Key%
	IniWrite, %SendWaitBind%, Profiles/%LoadedProfile%/Setting.ini, SendWait, %SKey%
	IniWrite, %SendWaitBind%, Profiles/%LoadedProfile%/Setting.ini, SendWait, %SKey%
	IniWrite, %BHEnter%, Profiles/%LoadedProfile%/Setting.ini, EnterEnable, HKeyEnter%SCount%
}
MsgBox, 64, Мульти-Биндер для Samp-RP, Настройки успешно сохранены!
Reload
return

CREATEEDIT:
{
Gui, 2:Destroy
Gui, 2:Add, Edit, x2 y2 w337 h116 vEBind, % Bind[3,ECount]
Gui, 2:Add, Button, x14 y130 w90 h30 gPrimenit, Применить
Gui, 2:Add, Button, x120 y130 w200 h30 gWaitTime, Добавить ожидание строки
Gui, 2:Show, center h168 w339, Настройки бинда
Gui, 2:Submit, NoHide
return
}

gofind:
{
	FileSelectFile, FBindFold, 3,,BindText, *txt
	if FBindFold =
	MsgBox, Загрузка текста отменена
	else 
	{
		FileRead, FBind, %FBindFold%
		FileDelete, Profiles/%LoadedProfile%/BindsText/Bind%Mem%.txt
		FileAppend, %FBind%, Profiles/%LoadedProfile%/BindsText/Bind%Mem%.txt
		Gui, Submit, NoHide
		return
	}
}

gosend:
{
	Text := % Bind[3,BindCount]
	if ( Bind[5,BindCount] == 0)
	{
		SendInput,{f6}%Text% 
	}
	else
	{
		Loop, Read, Profiles\%LoadedProfile%\BindsText\Bind%BindCount%.txt
		{
			RegExMatch(A_LoopReadLine, "\Q|slp:\E([^/]*)", time)
			StringReplace, time1, time1, %A_SPACE%,"", All
			Str := RegExReplace(A_LoopReadLine, "\|slp:(.*)")
			SendChat( Str )
			if (time1 <= 0) {
				Sleep, % Bind[4,BindCount]
			}
			else {
				Sleep, %time1%
			}
		}
	}
	return
}

;==================================
;==============GAME MENU============
;==================================
strok := 3
Gmenu :=0
Profmenu :=0
;==================================
a:= 0
~Esc::
if (Gmenu == 1)
{
	Gmenu := 0
}
if (Profmenu == 1)
{
	Profmenu := 0
}
BlockInput, MouseMoveOff
return
~F6::
if (Gmenu == 1)
{
	Gmenu := 0
}
if (Profmenu == 1)
{
	Profmenu := 0
}
BlockInput, MouseMoveOff
return
;=================================
AppsKey::
a:=1
Gmenu:=1
BlockInput, MouseMove
ShowDialog("2", "Multi-Binder Game Menu", "[1] Сменить профиль`n[2] Перезагрузить`n[3] Выключить","Отмена")
return


~UP::
KeyWait Up
if (Gmenu == 1 || Profmenu == 1) {
	if (a>1)
	{
		a:=a-1
	}
}
return
~Down::
KeyWait Down
if (Gmenu == 1 || Profmenu == 1) {
	if (a<strok)
	{
		a:=a+1
	}
}
return
~Enter::
KeyWait Enter
if (Gmenu == 1) {
BlockInput, MouseMoveOff
Gpunk:="Glabel"+a
Gmenu:=0
Gosub, %Gpunk%
}
if (Profmenu == 1) {
	BlockInput, MouseMoveOff
	Profpunk:="Proflabel"+a
	Profmenu:=0
	Gosub, %Profpunk%
}
return
;============= [General Menu] ===================
GLabel1:
if (a != 1)
{
	return
}
Sleep, 600
a:=1
Profmenu:=1
ShowDialog("2", "Multi-Binder Game Menu", "[1] Сменить профиль`n[2] Перезагрузить`n[3] Выключить","Отмена")
return

Glabel2:
return

Glabel3:
return

;============= [Profiles Menu] ===================

;==================================
;==================================
;==================================

FBind110:
Mem := 110
gosub, gofind
return
FBind111:
Mem := 110
gosub, gofind
return

BString110:
MainMenu := 0
ECount:=110
gosub, CREATEEDIT
return
BString111:
MainMenu := 0
ECount:=111
gosub, CREATEEDIT
return

Key110:
BindCount := 110
gosub, gosend
return

Key111:
BindCount := 111
gosub, gosend
return

Key112:
Reload
return

Key113: 
Pause
return

;==================================
;==================================
;==================================

FBind10:
Mem := 10
gosub, gofind
return
FBind11:
Mem := 11
gosub, gofind
return
FBind12:
Mem := 12
gosub, gofind
return
FBind13:
Mem := 13
gosub, gofind
return
FBind14:
Mem := 14
gosub, gofind
return
FBind15:
Mem := 15
gosub, gofind
return
FBind16:
Mem := 16
gosub, gofind
return
FBind17:
Mem := 17
gosub, gofind
return
FBind18:
Mem := 18
gosub, gofind
return
FBind19:
Mem := 19
gosub, gofind
return



BString10:
MainMenu := 0
ECount:=10
gosub, CREATEEDIT
return
BString11:
MainMenu := 0
ECount:=11
gosub, CREATEEDIT
return
BString12:
MainMenu := 0
ECount:=12
gosub, CREATEEDIT
return
BString13:
MainMenu := 0
ECount:=13
gosub, CREATEEDIT
return
BString14:
MainMenu := 0
ECount:=14
gosub, CREATEEDIT
return
BString15:
MainMenu := 0
ECount:=15
gosub, CREATEEDIT
return
BString16:
MainMenu := 0
ECount:=16
gosub, CREATEEDIT
return
BString17:
MainMenu := 0
ECount:=17
gosub, CREATEEDIT
return
BString18:
MainMenu := 0
ECount:=18
gosub, CREATEEDIT
return
BString19:
MainMenu := 0
ECount:=19
gosub, CREATEEDIT
return

;==================================
;==================================
;==================================
FBind20:
Mem := 20
gosub, gofind
return
FBind21:
Mem := 21
gosub, gofind
return
FBind22:
Mem := 22
gosub, gofind
return
FBind23:
Mem := 23
gosub, gofind
return
FBind24:
Mem := 24
gosub, gofind
return
FBind25:
Mem := 25
gosub, gofind
return
FBind26:
Mem := 26
gosub, gofind
return
FBind27:
Mem := 27
gosub, gofind
return
FBind28:
Mem := 28
gosub, gofind
return
FBind29:
Mem := 29
gosub, gofind
return


BString20:
MainMenu := 0
ECount:=20
gosub, CREATEEDIT
return
BString21:
MainMenu := 0
ECount:=21
gosub, CREATEEDIT
return
BString22:
MainMenu := 0
ECount:=22
gosub, CREATEEDIT
return
BString23:
MainMenu := 0
ECount:=23
gosub, CREATEEDIT
return
BString24:
MainMenu := 0
ECount:=24
gosub, CREATEEDIT
return
BString25:
MainMenu := 0
ECount:=25
gosub, CREATEEDIT
return
BString26:
MainMenu := 0
ECount:=26
gosub, CREATEEDIT
return
BString27:
MainMenu := 0
ECount:=27
gosub, CREATEEDIT
return
BString28:
MainMenu := 0
ECount:=28
gosub, CREATEEDIT
return
BString29:
MainMenu := 0
ECount:=29
gosub, CREATEEDIT
return

;==================================
;==================================
;==================================
FBind30:
Mem := 30
gosub, gofind
return
FBind31:
Mem := 31
gosub, gofind
return
FBind32:
Mem := 32
gosub, gofind
return
FBind33:
Mem := 33
gosub, gofind
return
FBind34:
Mem := 34
gosub, gofind
return
FBind35:
Mem := 35
gosub, gofind
return
FBind36:
Mem := 36
gosub, gofind
return
FBind37:
Mem := 37
gosub, gofind
return
FBind38:
Mem := 38
gosub, gofind
return
FBind39:
Mem := 39
gosub, gofind
return


BString30:
MainMenu := 0
ECount:=30
gosub, CREATEEDIT
return
BString31:
MainMenu := 0
ECount:=31
gosub, CREATEEDIT
return
BString32:
MainMenu := 0
ECount:=32
gosub, CREATEEDIT
return
BString33:
MainMenu := 0
ECount:=33
gosub, CREATEEDIT
return
BString34:
MainMenu := 0
ECount:=34
gosub, CREATEEDIT
return
BString35:
MainMenu := 0
ECount:=35
gosub, CREATEEDIT
return
BString36:
MainMenu := 0
ECount:=36
gosub, CREATEEDIT
return
BString37:
MainMenu := 0
ECount:=37
gosub, CREATEEDIT
return
BString38:
MainMenu := 0
ECount:=38
gosub, CREATEEDIT
return
BString39:
MainMenu := 0
ECount:=39
gosub, CREATEEDIT
return

;==================================
;==================================
;==================================
FBind40:
Mem := 40
gosub, gofind
return
FBind41:
Mem := 41
gosub, gofind
return
FBind42:
Mem := 42
gosub, gofind
return
FBind43:
Mem := 43
gosub, gofind
return
FBind44:
Mem := 44
gosub, gofind
return
FBind45:
Mem := 45
gosub, gofind
return
FBind46:
Mem := 46
gosub, gofind
return
FBind47:
Mem := 47
gosub, gofind
return
FBind48:
Mem := 48
gosub, gofind
return
FBind49:
Mem := 49
gosub, gofind
return


BString40:
MainMenu := 0
ECount:=40
gosub, CREATEEDIT
return
BString41:
MainMenu := 0
ECount:=41
gosub, CREATEEDIT
return
BString42:
MainMenu := 0
ECount:=42
gosub, CREATEEDIT
return
BString43:
MainMenu := 0
ECount:=43
gosub, CREATEEDIT
return
BString44:
MainMenu := 0
ECount:=44
gosub, CREATEEDIT
return
BString45:
MainMenu := 0
ECount:=45
gosub, CREATEEDIT
return
BString46:
MainMenu := 0
ECount:=46
gosub, CREATEEDIT
return
BString47:
MainMenu := 0
ECount:=47
gosub, CREATEEDIT
return
BString48:
MainMenu := 0
ECount:=48
gosub, CREATEEDIT
return
BString49:
MainMenu := 0
ECount:=49
gosub, CREATEEDIT
return

;==================================
;==================================
;==================================
FBind50:
Mem := 50
gosub, gofind
return
FBind51:
Mem := 51
gosub, gofind
return
FBind52:
Mem := 52
gosub, gofind
return
FBind53:
Mem := 53
gosub, gofind
return
FBind54:
Mem := 54
gosub, gofind
return
FBind55:
Mem := 55
gosub, gofind
return
FBind56:
Mem := 56
gosub, gofind
return
FBind57:
Mem := 57
gosub, gofind
return
FBind58:
Mem := 58
gosub, gofind
return
FBind59:
Mem := 59
gosub, gofind
return


BString50:
MainMenu := 0
ECount:=50
gosub, CREATEEDIT
return
BString51:
MainMenu := 0
ECount:=51
gosub, CREATEEDIT
return
BString52:
MainMenu := 0
ECount:=52
gosub, CREATEEDIT
return
BString53:
MainMenu := 0
ECount:=53
gosub, CREATEEDIT
return
BString54:
MainMenu := 0
ECount:=54
gosub, CREATEEDIT
return
BString55:
MainMenu := 0
ECount:=55
gosub, CREATEEDIT
return
BString56:
MainMenu := 0
ECount:=56
gosub, CREATEEDIT
return
BString57:
MainMenu := 0
ECount:=57
gosub, CREATEEDIT
return
BString58:
MainMenu := 0
ECount:=58
gosub, CREATEEDIT
return
BString59:
MainMenu := 0
ECount:=59
gosub, CREATEEDIT
return

;==================================
;==================================
;==================================
FBind60:
Mem := 60
gosub, gofind
return
FBind61:
Mem := 61
gosub, gofind
return
FBind62:
Mem := 62
gosub, gofind
return
FBind63:
Mem := 63
gosub, gofind
return
FBind64:
Mem := 64
gosub, gofind
return
FBind65:
Mem := 65
gosub, gofind
return
FBind66:
Mem := 66
gosub, gofind
return
FBind67:
Mem := 67
gosub, gofind
return
FBind68:
Mem := 68
gosub, gofind
return
FBind69:
Mem := 69
gosub, gofind
return


BString60:
MainMenu := 0
ECount:=60
gosub, CREATEEDIT
return
BString61:
MainMenu := 0
ECount:=61
gosub, CREATEEDIT
return
BString62:
MainMenu := 0
ECount:=62
gosub, CREATEEDIT
return
BString63:
MainMenu := 0
ECount:=63
gosub, CREATEEDIT
return
BString64:
MainMenu := 0
ECount:=64
gosub, CREATEEDIT
return
BString65:
MainMenu := 0
ECount:=65
gosub, CREATEEDIT
return
BString66:
MainMenu := 0
ECount:=66
gosub, CREATEEDIT
return
BString67:
MainMenu := 0
ECount:=67
gosub, CREATEEDIT
return
BString68:
MainMenu := 0
ECount:=68
gosub, CREATEEDIT
return
BString69:
MainMenu := 0
ECount:=69
gosub, CREATEEDIT
return

;==================================
;==================================
;==================================
FBind70:
Mem := 70
gosub, gofind
return
FBind71:
Mem := 71
gosub, gofind
return
FBind72:
Mem := 72
gosub, gofind
return
FBind73:
Mem := 73
gosub, gofind
return
FBind74:
Mem := 74
gosub, gofind
return
FBind75:
Mem := 75
gosub, gofind
return
FBind76:
Mem := 76
gosub, gofind
return
FBind77:
Mem := 77
gosub, gofind
return
FBind78:
Mem := 78
gosub, gofind
return
FBind79:
Mem := 79
gosub, gofind
return


BString70:
MainMenu := 0
ECount:=70
gosub, CREATEEDIT
return
BString71:
MainMenu := 0
ECount:=71
gosub, CREATEEDIT
return
BString72:
MainMenu := 0
ECount:=72
gosub, CREATEEDIT
return
BString73:
MainMenu := 0
ECount:=73
gosub, CREATEEDIT
return
BString74:
MainMenu := 0
ECount:=74
gosub, CREATEEDIT
return
BString75:
MainMenu := 0
ECount:=75
gosub, CREATEEDIT
return
BString76:
MainMenu := 0
ECount:=76
gosub, CREATEEDIT
return
BString77:
MainMenu := 0
ECount:=77
gosub, CREATEEDIT
return
BString78:
MainMenu := 0
ECount:=78
gosub, CREATEEDIT
return
BString79:
MainMenu := 0
ECount:=79
gosub, CREATEEDIT
return

;==================================
;==================================
;==================================
FBind80:
Mem := 80
gosub, gofind
return
FBind81:
Mem := 81
gosub, gofind
return
FBind82:
Mem := 82
gosub, gofind
return
FBind83:
Mem := 83
gosub, gofind
return
FBind84:
Mem := 84
gosub, gofind
return
FBind85:
Mem := 85
gosub, gofind
return
FBind86:
Mem := 86
gosub, gofind
return
FBind87:
Mem := 87
gosub, gofind
return
FBind88:
Mem := 88
gosub, gofind
return
FBind89:
Mem := 89
gosub, gofind
return


BString80:
MainMenu := 0
ECount:=80
gosub, CREATEEDIT
return
BString81:
MainMenu := 0
ECount:=81
gosub, CREATEEDIT
return
BString82:
MainMenu := 0
ECount:=82
gosub, CREATEEDIT
return
BString83:
MainMenu := 0
ECount:=83
gosub, CREATEEDIT
return
BString84:
MainMenu := 0
ECount:=84
gosub, CREATEEDIT
return
BString85:
MainMenu := 0
ECount:=85
gosub, CREATEEDIT
return
BString86:
MainMenu := 0
ECount:=86
gosub, CREATEEDIT
return
BString87:
MainMenu := 0
ECount:=87
gosub, CREATEEDIT
return
BString88:
MainMenu := 0
ECount:=88
gosub, CREATEEDIT
return
BString89:
MainMenu := 0
ECount:=89
gosub, CREATEEDIT
return

;==================================
;==================================
;==================================
FBind90:
Mem := 90
gosub, gofind
return
FBind91:
Mem := 91
gosub, gofind
return
FBind92:
Mem := 92
gosub, gofind
return
FBind93:
Mem := 93
gosub, gofind
return
FBind94:
Mem := 94
gosub, gofind
return
FBind95:
Mem := 95
gosub, gofind
return
FBind96:
Mem := 96
gosub, gofind
return
FBind97:
Mem := 97
gosub, gofind
return
FBind98:
Mem := 98
gosub, gofind
return
FBind99:
Mem := 99
gosub, gofind
return


BString90:
MainMenu := 0
ECount:=90
gosub, CREATEEDIT
return
BString91:
MainMenu := 0
ECount:=91
gosub, CREATEEDIT
return
BString92:
MainMenu := 0
ECount:=92
gosub, CREATEEDIT
return
BString93:
MainMenu := 0
ECount:=93
gosub, CREATEEDIT
return
BString94:
MainMenu := 0
ECount:=94
gosub, CREATEEDIT
return
BString95:
MainMenu := 0
ECount:=95
gosub, CREATEEDIT
return
BString96:
MainMenu := 0
ECount:=96
gosub, CREATEEDIT
return
BString97:
MainMenu := 0
ECount:=97
gosub, CREATEEDIT
return
BString98:
MainMenu := 0
ECount:=98
gosub, CREATEEDIT
return
BString99:
MainMenu := 0
ECount:=99
gosub, CREATEEDIT
return

;==================================
;==================================
;==================================
FBind100:
Mem := 100
gosub, gofind
return
FBind101:
Mem := 101
gosub, gofind
return
FBind102:
Mem := 102
gosub, gofind
return
FBind103:
Mem := 103
gosub, gofind
return
FBind104:
Mem := 104
gosub, gofind
return
FBind105:
Mem := 105
gosub, gofind
return
FBind106:
Mem := 106
gosub, gofind
return
FBind107:
Mem := 107
gosub, gofind
return
FBind108:
Mem := 108
gosub, gofind
return
FBind109:
Mem := 109
gosub, gofind
return


BString100:
MainMenu := 0
ECount:=100
gosub, CREATEEDIT
return
BString101:
MainMenu := 0
ECount:=101
gosub, CREATEEDIT
return
BString102:
MainMenu := 0
ECount:=102
gosub, CREATEEDIT
return
BString103:
MainMenu := 0
ECount:=103
gosub, CREATEEDIT
return
BString104:
MainMenu := 0
ECount:=104
gosub, CREATEEDIT
return
BString105:
MainMenu := 0
ECount:=105
gosub, CREATEEDIT
return
BString106:
MainMenu := 0
ECount:=106
gosub, CREATEEDIT
return
BString107:
MainMenu := 0
ECount:=107
gosub, CREATEEDIT
return
BString108:
MainMenu := 0
ECount:=108
gosub, CREATEEDIT
return
BString109:
MainMenu := 0
ECount:=109
gosub, CREATEEDIT
return

;=====================================================
;=====================================================
;=======================KEYS===========================
;=====================================================
;=====================================================

Key10:
BindCount := 10
gosub, gosend
return
Key11:
BindCount := 11
gosub, gosend
return
Key12:
BindCount := 12
gosub, gosend
return
Key13:
BindCount := 13
gosub, gosend
return
Key14:
BindCount := 14
gosub, gosend
return
Key15:
BindCount := 15
gosub, gosend
return
Key16:
BindCount := 16
gosub, gosend
return
Key17:
BindCount := 17
gosub, gosend
return
Key18:
BindCount := 18
gosub, gosend
return
Key19:
BindCount := 19
gosub, gosend
return
Key20:
BindCount := 20
gosub, gosend
return
Key21:
BindCount := 21
gosub, gosend
return
Key22:
BindCount := 22
gosub, gosend
return
Key23:
BindCount := 23
gosub, gosend
return
Key24:
BindCount := 24
gosub, gosend
return
Key25:
BindCount := 25
gosub, gosend
return
Key26:
BindCount := 26
gosub, gosend
return
Key27:
BindCount := 27
gosub, gosend
return
Key28:
BindCount := 28
gosub, gosend
return
Key29:
BindCount := 29
gosub, gosend
return
Key30:
BindCount := 30
gosub, gosend
return
Key31:
BindCount := 31
gosub, gosend
return
Key32:
BindCount := 32
gosub, gosend
return
Key33:
BindCount := 33
gosub, gosend
return
Key34:
BindCount := 34
gosub, gosend
return
Key35:
BindCount := 35
gosub, gosend
return
Key36:
BindCount := 36
gosub, gosend
return
Key37:
BindCount := 37
gosub, gosend
return
Key38:
BindCount := 38
gosub, gosend
return
Key39:
BindCount := 39
gosub, gosend
return
Key40:
BindCount := 40
gosub, gosend
return
Key41:
BindCount := 41
gosub, gosend
return
Key42:
BindCount := 42
gosub, gosend
return
Key43:
BindCount := 43
gosub, gosend
return
Key44:
BindCount := 44
gosub, gosend
return
Key45:
BindCount := 45
gosub, gosend
return
Key46:
BindCount := 46
gosub, gosend
return
Key47:
BindCount := 47
gosub, gosend
return
Key48:
BindCount := 48
gosub, gosend
return
Key49:
BindCount := 49
gosub, gosend
return
Key50:
BindCount := 50
gosub, gosend
return
Key51:
BindCount := 51
gosub, gosend
return
Key52:
BindCount := 52
gosub, gosend
return
Key53:
BindCount := 53
gosub, gosend
return
Key54:
BindCount := 54
gosub, gosend
return
Key55:
BindCount := 55
gosub, gosend
return
Key56:
BindCount := 56
gosub, gosend
return
Key57:
BindCount := 57
gosub, gosend
return
Key58:
BindCount := 58
gosub, gosend
return
Key59:
BindCount := 59
gosub, gosend
return
Key60:
BindCount := 60
gosub, gosend
return
Key61:
BindCount := 61
gosub, gosend
return
Key62:
BindCount := 62
gosub, gosend
return
Key63:
BindCount := 63
gosub, gosend
return
Key64:
BindCount := 64
gosub, gosend
return
Key65:
BindCount := 65
gosub, gosend
return
Key66:
BindCount := 66
gosub, gosend
return
Key67:
BindCount := 67
gosub, gosend
return
Key68:
BindCount := 68
gosub, gosend
return
Key69:
BindCount := 69
gosub, gosend
return
Key70:
BindCount := 70
gosub, gosend
return
Key71:
BindCount := 71
gosub, gosend
return
Key72:
BindCount := 72
gosub, gosend
return
Key73:
BindCount := 73
gosub, gosend
return
Key74:
BindCount := 74
gosub, gosend
return
Key75:
BindCount := 75
gosub, gosend
return
Key76:
BindCount := 76
gosub, gosend
return
Key77:
BindCount := 77
gosub, gosend
return
Key78:
BindCount := 78
gosub, gosend
return
Key79:
BindCount := 79
gosub, gosend
return
Key80:
BindCount := 80
gosub, gosend
return
Key81:
BindCount := 81
gosub, gosend
return
Key82:
BindCount := 82
gosub, gosend
return
Key83:
BindCount := 83
gosub, gosend
return
Key84:
BindCount := 84
gosub, gosend
return
Key85:
BindCount := 85
gosub, gosend
return
Key86:
BindCount := 86
gosub, gosend
return
Key87:
BindCount := 87
gosub, gosend
return
Key88:
BindCount := 88
gosub, gosend
return
Key89:
BindCount := 89
gosub, gosend
return
Key90:
BindCount := 90
gosub, gosend
return
Key91:
BindCount := 91
gosub, gosend
return
Key92:
BindCount := 92
gosub, gosend
return
Key93:
BindCount := 93
gosub, gosend
return
Key94:
BindCount := 94
gosub, gosend
return
Key95:
BindCount := 95
gosub, gosend
return
Key96:
BindCount := 96
gosub, gosend
return
Key97:
BindCount := 97
gosub, gosend
return
Key98:
BindCount := 98
gosub, gosend
return
Key99:
BindCount := 99
gosub, gosend
return
Key100:
BindCount := 100
gosub, gosend
return
Key101:
BindCount := 101
gosub, gosend
return
Key102:
BindCount := 102
gosub, gosend
return
Key103:
BindCount := 103
gosub, gosend
return
Key104:
BindCount := 104
gosub, gosend
return
Key105:
BindCount := 105
gosub, gosend
return
Key106:
BindCount := 106
gosub, gosend
return
Key107:
BindCount := 107
gosub, gosend
return
Key108:
BindCount := 108
gosub, gosend
return
Key109:
BindCount := 109
gosub, gosend
return
