class Initializator
{
; 10 биндов
; MСтрок, 					МОжидания, 					МНажатия Enter, 					Кол-Строк, 					Горячая клавиша, 					Флудер, 						тип отправки, 					Деф. Ожидание
; [1, Bind, НСтроки], [2, Bind, НСтроки], 			[3, Bind, НСтроки], 				[4, Bind],							[5,Bind],									[6,Bind]						[7,Bind]								[8,Bind]				
	initStrings() {
		j := 0
		Loop % NumTabs * 10
		{
			j++
			i := 0
			Loop, % Bind[4, %A_Index%]
			{
				i++
				
				IniRead, String, Profiles\%Profile%\Hotkeys\Hotkey%A_Index%.mbmf, Sting%i%, Text
				Bind[1,j, i] := String
			}
		}
	}
	initWaitings() {
		j := 0
		Loop % NumTabs * 10
		{
			j++
			i := 0
			Loop, % Bind[4, %A_Index%]
			{
				i++
				IniRead, Time, Profiles\%Profile%\Hotkeys\Hotkey%A_Index%.mbmf, Sting%i%, Wait
				Bind[2,j, i] := Time
			}
		}
	}
	initPressEnters() {
		j := 0
		Loop % NumTabs * 10
		{
			j++
			i := 0
			Loop, % Bind[4, %A_Index%]
			{
				i++
				IniRead, Enters, Profiles\%Profile%\Hotkeys\Hotkey%A_Index%.mbmf, Sting%i%, TEnter
				Bind[3,j, i] := Enters
			}
		}
	}
	initNumberStrings() {
		Loop % NumTabs * 10
		{
			IniRead, NumStrings, Profiles\%Profile%\Hotkeys\Hotkey%A_Index%.mbmf, Main, NumStrings, 0
			Bind[4,%A_Index%] := NumStrings
		}
	}
	initHotKeys() {
		Loop % NumTabs * 10
		{
			IniRead, HKey, Profiles\%Profile%\Hotkeys\Hotkey%A_Index%.mbmf, Main, HKey, "none"
			Bind[5,%A_Index%] := HKey
		}
	}
	initIsFlooders() {
		Loop % NumTabs * 10
		{
			IniRead, Flooder, Profiles\%Profile%\Hotkeys\Hotkey%A_Index%.mbmf, Main, Flooder, "false"
			Bind[6,%A_Index%] := Flooder
		}
	}
	initTypeSends() {
		Loop % NumTabs * 10
		{
			IniRead, SendType, Profiles\%Profile%\Hotkeys\Hotkey%A_Index%.mbmf, Main, Type, "false"
			Bind[7,%A_Index%] := SendType
		}
	}
	initDefWaitings() {
		Loop % NumTabs * 10
		{
			IniRead, DWait, Profiles\%Profile%\Hotkeys\Hotkey%A_Index%.mbmf, Main, DefWaiting
			Bind[8,A_Index] := DWait
		}
	}
	initProfile() {
		msg := new Message()
		IfExist, Profiles/%Profile%/Settings.mbmf
		{
			IniRead, NumTabs, Profiles\%Profile%\Settings.mbmf, Main, NumTabs, 2
			IniRead, HkeyReload, Profiles\%Profile%\Settings.mbmf, Main, HKeyReload
			IniRead, HkeyPause, Profiles\%Profile%\Settings.mbmf, Main, HKeyPause
			IniRead, AutoUpdate, Profiles\%Profile%\Settings.mbmf, Main, AutoUpdate, "true"
			IniRead, UpdNotification, Profiles\%Profile%\Settings.mbmf, Main, UpdNotific, "true"
			IniRead, TrayLaunch, Profiles\%Profile%\Settings.mbmf, Main, TrayLaunch, "false"
		} else {
			msg.Info("Новый профиль настраивается, пожалуйста подождите", 3)
			FileCreateDir, %A_ScriptDir%\Profiles\%Profile%
			FileCreateDir, %A_ScriptDir%\Profiles\%Profile%\Hotkeys
			IniWrite, 2, Profiles\%Profile%\Settings.mbmf, Main, NumTabs
			IniWrite, none, Profiles\%Profile%\Settings.mbmf, Main, HKeyReload
			IniWrite, none, Profiles\%Profile%\Settings.mbmf, Main, HKeyPause
			IniWrite, true, Profiles\%Profile%\Settings.mbmf, Main, AutoUpdate
			IniWrite, true, Profiles\%Profile%\Settings.mbmf, Main, UpdNotific
			IniWrite, false, Profiles\%Profile%\Settings.mbmf, Main, TrayLaunch
			NumTabs := 2
			HKeyReload := "none"
			HKeyPause := "none"
			AutoUpdate := "true"
			UpdNotific := "true"
			TrayLaunch := "false"
		}
		Sys[1] := HkeyReload
		Sys[2] := HkeyPause
	}
	initSys() {
		IfExist,  Settings.mbmf
		{
			IniRead, Skin, Settings.mbmf, Main, Skin, Default
			IniRead, Profile, Settings.mbmf, Main, Profile, Default
		} else {
			IniWrite, Default, Settings.mbmf, Main, Skin
			IniWrite, Default, Settings.mbmf, Main, Profile
			IniWrite, %ID%, Settings.mbmf, Main, Key
			Skin := "Default"
			Profile := "Default"
		}
	}
	ActivateHotKeys() {
		j := 0
		Loop % NumTabs * 10
		{
			j++
			i := 0
			Loop, % Bind[4, A_Index]
			{
				i++
				Bind[2,j, i] := Time
			}
		}
	}
	initBinds() {
		this.initHotKeys()
		this.initNumberStrings()
		this.initStrings()
		this.initWaitings()
		this.initPressEnters()
		this.initIsFlooders()
		this.initTypeSends()
		this.initDefWaitings()
	}
}