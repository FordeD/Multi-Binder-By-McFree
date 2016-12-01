class Message
{
	info(Text, Wait=0) {
		if(WinActive("GTA:SA:MP")) {
			StringSplit, Text, Text, `n
			addChatMessage("						======[INFO]======") 
			addChatMessage("[Multi-Binder] " Text1)
			if (StrLen(Text2) > 0) 
				addChatMessage("[Multi-Binder] " Text2)
			addChatMessage("						===============") 
		} else {
			if (!Wait)
				MsgBox, 64, Multi-Binder INFO, %Text%, %Wait%
			else
				MsgBox, 64, Multi-Binder INFO, %Text%
		}
	}
	Error(Text, Wait=0) {
		if(WinActive("GTA:SA:MP")) {
			StringSplit, Text, Text, `n
			addChatMessage("						======[ERROR]======") 
			addChatMessage("[Multi-Binder] " Text1)
			if (StrLen(Text2) > 0) 
				addChatMessage("[Multi-Binder] " Text2)
			addChatMessage("						================") 
		} else {
			if (!Wait)
				MsgBox, 16, Multi-Binder ERROR, %Text%, %Wait%
			else
				MsgBox, 16, Multi-Binder ERROR, %Text%
		}
	}
}