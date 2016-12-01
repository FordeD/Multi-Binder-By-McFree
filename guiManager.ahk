class guiManager
{
	Window := 0
	LoadTrayMenu() {
		Menu, tray,NoStandard 
		Menu, tray,DeleteAll
		Menu, tray,add,�� ������, ShowAbout
		Menu, tray,add
		Menu, tray,add,����������, maximize
		Menu, tray,add,���������, ShowSettings
		Menu, tray,add,�������������, ReloadBinder
		Menu, tray,add
		Menu, tray,add,���������, Close
	}
	
	LoadLoadingWindow() {
		Mess:= ["�� ���� � ����������", "�������� ������", "������ ����� ������", "� ������ ������� ���.", "�����: ����� ������� ������������.", "�����: �� ������ ���������� ����� ��������", "�����: ��� ���������� ������ �� .���� ���� ������", "���, ������, �� ��� ������.", "�����: ������ ����������, �������� ������������", "� ��� ���� ��������.", "�� ����� ���������, ��� ��������� ���� �� ���", "��� �� �������� ��������� � ���� ������?", "AHK ��� ������!", "�����: ��������� ������� ������ ������� �� �����", "��� ����� ��� �� �������.", "��, ��� �������� �������", "��������� �����", "������� ����", "����� ������ � �������? ���� �������!", "QIWI ������������: +79816808916"]
		Gui, 4:Default
		Gui 4:-Border
		Random, ICO, 1,5
		Random, String, 1, Mess.Length()
		Gui, 4:Add, Text, x3 y-8 w274 h15 +Center, ___________________________________________________________________
		Gui, 4:Add, Picture, x10 y20 w50 h50 , %A_ScriptDir%\Images\McFreeICO%ICO%.ico
		Gui, 4:Add, Text, x73 y11 w250 h20, �����������: McFree 
		Gui, 4:Add, Text, x73 y28 w250 h20, ������: %Version% [21.05.2016] 
		Gui, 4:Add, Text, x73 y46 w250 h20, Skype: Maletsifist  | VK.com/mcfreeman
		Gui, 4:Add, Text, x73 y66 w250 h20, ��� ���: %Users%! Online: %Online%!
		Gui, 4:Add, Text, x3 y80 w274 h15 +Center, ___________________________________________________________________
		Gui, 4:Add, Text, x0 y96 w280 h20 +Center, % Mess[String]
	}
	ShowLoadingWindow() {
		this.Window := 4
		Gui, 4:Default
		Gui, 4:Show, center h118 w280, �������� �������
	}
	HideLoadingWindow() {
		Gui, 4:Hide
	}
	DestroyLoadingWindow() {
		Gui, 4:Destroy
	}
	
	LoadSettingsWindow() {
		Gui, 3:+Border
		Gui, 3:+Caption
		Gui, 3:Default
		Gui, 3:Add, Text, x12 y12 w60 h20 +Right, �������:
		Gui, 3:Add, Hotkey, x82 y12 w100 h20 vHKReload, 
		Gui, 3:Add, Text, x12 y42 w60 h20 +Right, �����:
		Gui, 3:Add, Hotkey, x82 y42 w100 h20 vHKPause, 
		Gui, 3:Add, Text, x12 y72 w90 h20 , ���-�� �������:
		Gui, 3:Add, Edit, x112 y72 w70 h20 vColTabs, 2
		Gui, 3:Add, Text, x12 y102 w60 h20 +Right, ����:
		Gui, 3:Add, DropDownList, x82 y102 w100 h100 , ������|�������|�������|�����
		Gui, 3:Add, CheckBox, x12 y132 w170 h20 vAutoupdate, ��������������
		Gui, 3:Add, CheckBox, x12 y152 w170 h20 vAnswer, ���������� �� ����������
		Gui, 3:Add, CheckBox, x12 y172 w170 h20 vTrayLoad, ������ � ����
		Gui, 3:Add, Button, x12 y202 w170 h30 gSaveSettings, ���������
	}
	ShowSettingsWindow() {
		this.Window := 3
		Gui, 3:Default
		Gui, 3:Show, w198 h246, ���������
	}
	HideSettingsWindow() {
		Gui, 3:Hide
	}
	DestroySettingsWindow() {
		Gui, 3:Destroy
	}
	
	LoadEditWindow() {
		Gui, 2:+Border
		Gui, 2:+Caption
		Gui, 2:Default
		Gui, 2:Add, GroupBox, x12 y2 w160 h60 , ��� �����
		Gui, 2:Add, Radio, x22 y22 w140 h20 vTHK1, �������� �������
		Gui, 2:Add, Radio, x22 y42 w140 h20 vTHK2, �������� �� ������
		Gui, 2:Add, GroupBox, x172 y2 w170 h60 , ����������
		Gui, 2:Add, Text, x182 y22 w150 h20 vCHK, ���������� �����: 9
		Gui, 2:Add, Text, x182 y42 w150 h20 vWHK, ����� �����: 19 ���.
		Gui, 2:Add, ListView, x12 y72 w430 h240 vSHK +Checked -LV0x10 -Multi +NoSortHdr -WantF2, Enter|Wait(sec)|Text
		Gui, 2:Add, Button, x352 y2 w90 h30 gAddString, ��������
		Gui, 2:Add, Button, x352 y32 w90 h30 gRemoveString, �������
	}
	ShowEditWindow() {
		this.Window := 2
		Gui, 2:Default
		if (Bind[7,ThisBind] == "true") {
			GuiControl, , THK2, 1
			GuiControl, , THK1, 0
		} else{
			GuiControl, , THK2, 0
			GuiControl, , THK1, 1
		}
		Cols := Bind[4,%ThisBind%]
		Waits := GetAllWaitTime()
		GuiControl, Text, CHK, ���������� ����� %Cols%
		GuiControl, Text, WHK, ����� �����: %Waits% ���.
		LV_Delete()
		this.UpdateListViev()
		Gui, 2:Show, w457 h329, ��������
	}
	HideEditWindow() {
		Gui, 2:Hide
	}
	DestroyEditWindow() {
		Gui, 2:Destroy
	}

	LoadMainWindow() {
		Gui, 1:+Border
		Gui, 1:+Caption
		Gui, 1:Default
		this.Window := 1
		;MainButtons
		Gui, 1:Add, Button, x2 y371 w80 h22 gShowSettings, Settings
		Gui, 1:Add, Button, x86 y371 w80 h22 gSaveBinds, Save
		Gui, 1:Add, Button, x170 y371 w60 h22 gShowAbout, About
		Gui, 1:Add, DropDownList, x236 y372 w100 h100 gChangeProfile vProfile, DropDownList|����� �������
		
		;IniRead, NumTabs, Settings.mbmf, Main, NumTabs, 2
		i := 0
		Loop, %NumTabs%
		{
			i++
			Tabs .= "" i "|"
		}
		Gui, Add, Tab2, x2 y2 w355 h360 +Center, %Tabs%
		i := 0
		j := 0
		Loop, %NumTabs%
		{
			i++
			Gui, 1:Tab, %i%
			Gui, 1:Add, Text, x12 y32 w50 h20 +Center, HotKeys
			Gui, 1:Add, Text, x72 y32 w80 h20 +Center , Edit
			Gui, 1:Add, Text, x162 y32 w40 h20 +Center, Load
			Gui, 1:Add, GroupBox, x212 y18 w130 h340 +Center, Options
			Gui, 1:Add, Text, x222 y32 w40 h20 +Center, Flood
			Gui, 1:Add, Text, x272 y32 w40 h20 +Center, D.Wait
			yPos := 62
			Loop, 10
			{
				j++
				DTimw := Bind[8,j]
				HKey := Bind[5,j]
				HFlooder := Bind[6,j]
				Gui, 1:Add, Hotkey, x12 y%yPos% w50 h20 gHK, %HKey%
				Gui, 1:Add, Button, x68 y%yPos% w86 h20 gHE, Edit%j%
				Gui, 1:Add, Button, x160 y%yPos% w48 h20 gHL, Load%j%
				Gui, 1:Add, Edit, x272 y%yPos% w40 h20 , %DTime%
				if ( %HFlooder% == "false" ) {
					Gui, 1:Add, CheckBox, x232 y%yPos% w20 h20 ,
				}
				else {
					Gui, 1:Add, CheckBox, x232 y%yPos% w20 h20 +Checked,
				}
				yPos += 30
			}
		}
	}
	ShowMainWindow() {
		this.Window := 1
		Gui, 1:Default
		Gui, 1:Show, w355 h406, Multi-Binder By McFree
	}
	HideMainWindow() {
		Gui, 1:Hide
	}
	DestroyMainWindow() {
		Gui, 1:Destroy
	}
	
	LoadAboutWindow() {
		Gui, 5:+Border
		Gui, 5:+Caption
		Gui, 5:Default
		Gui, 5:Add, Text, x12 y12 w140 h20 , Author: McFree
		Gui, 5:Add, Text, x12 y32 w170 h20 , Dev. language: AutoHotKey
		Gui, 5:Add, Text, x12 y52 w140 h20 , Version: 3.0
		Gui, 5:Add, Text, x12 y72 w140 h20 , SA:MP Version: 0.3.7 (Only)
		
		Gui, 5:Add, GroupBox, x2 y102 w180 h70 , Contacts
		Gui, 5:Add, Text, x22 y122 w150 h20 , Skype: Maletsifist
		Gui, 5:Add, Text, x22 y142 w150 h20 , Social: vk.com/mcfreeman
		
		Gui, 5:Add, Button, x12 y182 w160 h40 gDonate, Donate me : )
	}
	ShowAboutWindow() {
		this.Window := 5
		Gui, 5:Default
		Gui, 5:Show, w190 h234, �� ������
	}
	HideAboutWindow() {
		Gui, 5:Hide
	}
	DestroyAboutWindow() {
		Gui, 5:Destroy
	}
	
	LoadAddStringWindow() {
		Gui, 6:-Border
		Gui, 6:+Caption
		Gui, 6:Default
		Gui, 6:Add, Text, x12 y12 w70 h20 +Center, Wait(Sec)
		Gui, 6:Add, Edit, x12 y32 w70 h20 vAddTime, Edit
		Gui, 6:Add, Text, x112 y12 w60 h20 , Text
		Gui, 6:Add, Edit, x112 y32 w320 h20 vAddText, Edit
		Gui, 6:Add, Button, x12 y62 w100 h30 gAddAdd, Add
		Gui, 6:Add, Button, x132 y62 w100 h30 gCancelAdd, Cancel
	}
	ShowAddStringWindow() {
		this.Window := 6
		Gui, 6:Default
		Gui, 6:Show, w440 h100, �������� ������
	}
	HideAddStringWindow() {
		Gui, 6:Hide
		this.Window := 2
	}
	DestroyAddStringWindow() {
		Gui, 6:Destroy
	}
 	
	UpdateListViev() {
		Col := % Bind[4,ThisBind]
		Loop, % Col
		{
			Enter := % Bind[3,ThisBind,A_Index]
			Text := % Bind[1,ThisBind,A_Index]
			Wait := % Bind[2,ThisBind,A_Index]
			LV_Add(%Enter%,,%Wait%,%Text%)
		}
	}
}
