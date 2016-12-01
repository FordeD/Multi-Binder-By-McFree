#Persistent 
#SingleInstance force
#MaxThreadsPerHotkey 3
#MaxThreads 7
SendMessage, 0x50,, 0x4190419,, A
;
;		includes
;
#Include samp_udf.ahk
#include guiManager.ahk
#include msgManager.ahk
#include InitManager.ahk
#Include saveManager.ahk

;
;		Objects
;
gui := new guiManager()
msg := new Message()
init := new Initializator()
save := new saveManager()

;
;		globals
;
global ID := GetMyIP()
global Version := "3.0"
global Author := "McFree"
global NumTabs
global Profile
global Skin
global AutoUpdate
global UpdNotification
global TrayLaunch
global ThisBind

global THK1
global THK2
global THK1
global CHK
global WHK
global SHK
global AddTime
global AddText
global HKReload
global HKPause
global ColTabs
global Autoupdat
global Answer
global TrayLoad

global Sys := []
global Bind := Array[]


if (ID == "") 
	msg.Error("Не удалось определить ваш идентификатор пользователя!")

;
;		initializations
;
init.initSys()
gui.LoadLoadingWindow()
gui.ShowLoadingWindow()
init.initProfile()
init.initBinds()
gui.LoadMainWindow()
gui.LoadTrayMenu()
gui.LoadSettingsWindow()
gui.LoadEditWindow()
gui.LoadAboutWindow()
gui.LoadAddStringWindow()
gui.HideLoadingWindow()
gui.ShowMainWindow()

return

;
;		[Settings] Window
;
SaveSettings:
gui.HideSettingsWindow()
gui.Window := 1
msg.Info("Настройки были сохранены.`nДля полной работоспособности необходио перезагрузить программу!")
return

;
;		[CreateProfile] Window
;
AcceptCreate:
Gui, 6:Destroy
msg.Info("Вы создали новый профиль.`nСейчас произойдет перезапуск и первоначальная настройка профиля!")
gosub, ReloadBinder
return

CloseCreate:
Gui, 6:Destroy
msg.Info("Вы отменили создание нового профиля.")
return

;
;		[Tray Menu\MainMenu] Window
;
ChangeProfile:
GuiControlGet, Profile
if (Profile == "Новый профиль") {
	Gui 6:-Border
	Gui, 6:Add, Edit, x12 y42 w240 h20 vNewProfile, Edit
	Gui, 6:Add, Button, x42 y72 w80 h30 gAcceptCreate, Ок
	Gui, 6:Add, Button, x142 y72 w80 h30 gCloseCreate , Cancel
	Gui, 6:Add, Text, x12 y12 w240 h20 +Center, Введите название профитя в это поле
	Gui, 6:Show, w270 h118, Новый профиль
}else {
	msg.Info("Вы выбрали другой профиль.`nСейчас произойдет перезапуск и настройка под профиль!")
}
return

SaveBinds:
msg.Info("Настройки горячих клавиш были сохранены!`nУдачного использования программы!")
return

ShowSettings:
gui.ShowSettingsWindow()
return

ShowAbout:
gui.ShowAboutWindow()
return

Close:
ExitApp
return

maximize:
gui.ShowMainWindow()
return

ReloadBinder:
Reload
return
;
;		[About Author] Window
;
Donate:
return


;
;		[Edit] Window
;
HK:

return

HE:
RegExMatch(A_GuiControl, "Edit([0-9]{3})",Res)
ThisBind := Res1
gui.ShowEditWindow()
return

HL:
return

AddString:
gui.ShowAddStringWindow()
return

RemoveString:
LV_Delete(LV_GetNext(0, "Focused"))
Bind[4,ThisBind]--
saveListView()
save.saveStrings()
save.saveWaitings()
save.saveEnters()
save.saveStringsNumber()
save.saveTypesSend()
return


AddAdd:
Gui, 6:Submit
Gui, 2:Default
gui.HideAddStringWindow()
LV_Add(true,,AddTime, AddText)
LV_ModifyCol()
saveListView()
save.saveStrings()
save.saveWaitings()
save.saveEnters()
save.saveStringsNumber()
save.saveTypesSend()
return

CancelAdd:
gui.HideAddStringWindow()
AddTime := ""
AddText := ""
return
;
;		[ALL] Window
;
1GuiClose:
2GuiClose:
3GuiClose:
4GuiClose:
5GuiClose:
6GuiClose:
if(gui.Window = 1) {
	if(WinActive("Multi-Binder By McFree")) {
		gui.HideMainWindow()
		gui.Window := 0
	} else  {
		WinActive("Multi-Binder By McFree")
	}
} else if (gui.Window = 2) {
	if(WinActive("Редактор")) {
		gui.HideEditWindow()
		gui.Window := 1
	} else {
		WinActive("Редактор")
	}
} else if (gui.Window = 3) {
	if(WinActive("Настройки")) {
		gui.HideSettingsWindow()
		gui.Window := 1
	} else {
		WinActive("Настройки")
	}
} else if (gui.Window = 4) {
	if(WinActive("Загрузка Биндера")) {
		gui.HideLoadingWindow()
		gui.Window := 1
	} else {
		WinActive("Загрузка Биндера")
	}
} else if (gui.Window = 5) {
	if(WinActive("Об авторе")) {
		gui.HideAboutWindow()
		gui.Window := 1
	} else {
		WinActive("Об авторе")
	}
} else if (gui.Window = 6) {
	if(WinActive("Добавить строку")) {
		gui.HideAddStringWindow()
		gui.Window := 2
	} else {
		WinActive("Добавить строку")
	}
}
return

GetAllWaitTime() {
	Col := Bind[4,ThisBind]
	Wait := 0
	Loop, % Col
	{
		Wait += % Bind[2, ThisBind, %A_Index%]
	}
	return Wait/100
}

saveListView() {
	Col := Bind[4,ThisBind]
	Loop, % Col
	{
		LV_GetText(Enter, %A_Index%, 1)
		LV_GetText(Wait, %A_Index%, 2)
		LV_GetText(String, %A_Index%, 3)
		MsgBox, 0, , %Enter%`n%Wait%`n%String%
		Bind[3, ThisBind, %A_Index%] := Enter
		Bind[2, ThisBind, %A_Index%] := Wait
		Bind[1, ThisBind, %A_Index%] := String
	}
}