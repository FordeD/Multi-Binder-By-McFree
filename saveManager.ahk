class saveManager
{
	saveStrings() {
		j := 0
		Loop % NumTabs * 10
		{
			j++
			i := 0
			Loop, % Bind[4, j]
			{
				i++
				String := Bind[1,j, i]
				
				IniWrite, %String%, Profiles\%Profile%\Hotkeys\Hotkey%A_Index%.mbmf, Sting%i%, Text
			}
		}
	}
	saveWaitings() {
		j := 0
		Loop % NumTabs * 10
		{
			j++
			i := 0
			Loop, % Bind[4, j]
			{
				i++
				Time := Bind[2,j, i]
				IniWrite, %Time%, Profiles\%Profile%\Hotkeys\Hotkey%A_Index%.mbmf, Sting%i%, Wait
			}
		}
	}
	saveEnters() {
		j := 0
		Loop % NumTabs * 10
		{
			j++
			i := 0
			Loop, % Bind[4, j]
			{
				i++
				Enters := Bind[3,j, i]
				IniWrite, %Enters%, Profiles\%Profile%\Hotkeys\Hotkey%A_Index%.mbmf, Sting%i%, TEnter
			}
		}
	}
	saveStringsNumber() {
		Loop % NumTabs * 10
		{
			NumStrings := Bind[4,A_Index]
			IniWrite, %NumStrings%, Profiles\%Profile%\Hotkeys\Hotkey%A_Index%.mbmf, Main, NumStrings
		}
	}
	saveHotKeys() {
		Loop % NumTabs * 10
		{
			HKey := Bind[5,A_Index]
			IniWrite, %HKey%, Profiles\%Profile%\Hotkeys\Hotkey%A_Index%.mbmf, Main, HKey
		}
	}
	saveFlooders() {
		Loop % NumTabs * 10
		{
			Flooder := Bind[6,A_Index]
			IniWrite, %Flooder%, Profiles\%Profile%\Hotkeys\Hotkey%A_Index%.mbmf, Main, Flooder
		}
	}
	saveTypesSend() {
		Loop % NumTabs * 10
		{
			SendType := Bind[7,A_Index]
			IniWrite, %SendType%, Profiles\%Profile%\Hotkeys\Hotkey%A_Index%.mbmf, Main, Type
		}
	}
	saveDefWaitings() {
		Loop % NumTabs * 10
		{
			DWait := Bind[8,A_Index]
			IniWrite, %DWait%, Profiles\%Profile%\Hotkeys\Hotkey%A_Index%.mbmf, Main, DefWaiting
		}
	}
}