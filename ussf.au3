#NoTrayIcon
#include 'Constants.au3'
#include 'GUIConstants.au3'
#include 'Default.au3'
#include 'Version.au3'
#include 'GlobalVars.au3'
#include 'String.au3'
#cs - Code Help and returned codes
	;################################################# Translations #################################################
	If you want to translate ussf into your own language, go ahead and send me the translated strings contained by these functions:
	
	SetMessageAndErrorContent()
	SetLanguage()
	
	;################################################## Parameters ##################################################
	First parameter = The full path to file (like C:\path\to\file.exe')
	Second parameter = The 'scene' name (like %cdrom%\path\to\file.exe')
	The third param = The number of the cmd the final command should be passed to
	The fouth param = Silent mode: 1 - show only a "Loading ..." splash; 2 - show nothing
	Example: ussf.exe "C:\path\to\file.exe" "%cdrom%\path\to\file.exe"
	
	;############################################## Detected FileTypes ##############################################
	.msi		=>			Extension		.msi			Header			D0CF11E0A1B11AE1000000000000000000000000000000003E000300FEFF090006
	.exe		=>			Extension		.exe			Header			4D5A
	.inf		=>			Extension		.inf
	.reg		=>			Extension		.reg			Header			57696E646F777320526567697374727920456469746F722056657273696F6E20352E30300D0A Or 52454745444954340D0A
	
	;################################################ Returned Codes ################################################
	16			=>			MSI File
	15			=>			UPX Packed
	14			=>			Self-Extracting WinZip archive
	13			=>			Unknown Zip archive
	12			=>			Unknown 7-Zip archive
	11			=>			7-Zip Installer package
	10			=>			Self-Extracting ZIP archive
	9			=>			Self-Extracting Microsoft CAB archive
	8			=>			Self-Extracting RAR archive
	7			=>			Wise Installer package
	6			=>			InstallShield 2003 package
	5			=>			Installshield AFW package
	4			=>			Inno Setup package
	3			=>			NSIS package
	2			=>			Reg file
	1			=>			Inf file
	-1			=>			Corrupted executable file (it does not start with 4D5A)
	-2			=>			Corrupted msi file (it does not start with D0CF11E0A1B11AE1000000000000000000000000000000003E000300FEFF090006)
	-3			=>			Invalid reg file (not starting with the correct lines)
	-4			=>			No program selected or program file doesn't exist
	-5			=>			Unknown executable file
	-6			=>			Not supported file type
	-7			=>			The file could not be opened for reading
	-8			=>			Valid PE file but PEiD can't detect it's header
#ce - Code Help and returned codes

Global $RegSkin = RegRead('HKCU\Software\USSF', 'Skin')
If Not @error And $RegSkin <> 'Default' And GetSkinVars($RegSkin) Then
	$SkinLoadedFromRegistry = True
EndIf
Global $RegLang = RegRead('HKCU\Software\USSF', 'Language')
If Not @error And $RegLang <> 'English' Then
	SetLanguage($RegLang)
	$LangLoadedFromRegistry = True
Else
	SetLanguage('English')
EndIf

If $CmdLine[0] <> 0 Then
	If $CmdLine[1] = '/?' Or $CmdLine[1] = '-?' Or $CmdLine[1] = '/help' Or $CmdLine[1] = '-help' Or $CmdLine[1] = '/h' Or $CmdLine[1] = '-h' Then
		MsgBox(64, "Universal Silent Switch Finder", $LanguageSpecificStrings[1])
		Exit
	ElseIf $CmdLine[0] = 3 Then
		SplashTextOn('', 'Loading ...', 300, 18, -1, -1, 1, 'Arial', 10, 800)
		$ShowWPIFeatures = True
		$ProgramToAnalyze = $CmdLine[1]
		$FileName = $CmdLine[2]
		$CmdNumber = $CmdLine[3]
		$FileExtension = StringRight($ProgramToAnalyze, 3)
		RegWrite('HKCU\Software\WPI', 'USSF_cmd1', 'REG_SZ', 'default')
		RegWrite('HKCU\Software\WPI', 'USSF_cmd2', 'REG_SZ', 'default')
		RegWrite('HKCU\Software\WPI', 'USSF_cmd3', 'REG_SZ', 'default')
		RegWrite('HKCU\Software\WPI', 'USSF_cmd4', 'REG_SZ', 'default')
		RegWrite('HKCU\Software\WPI', 'USSF_cmd5', 'REG_SZ', 'default')
		RegWrite('HKCU\Software\WPI', 'USSF_cmd6', 'REG_SZ', 'default')
		RegWrite('HKCU\Software\WPI', 'USSF_cmd7', 'REG_SZ', 'default')
		RegWrite('HKCU\Software\WPI', 'USSF_cmd8', 'REG_SZ', 'default')
		RegWrite('HKCU\Software\WPI', 'USSF_cmd9', 'REG_SZ', 'default')
		RegWrite('HKCU\Software\WPI', 'USSF_cmd10', 'REG_SZ', 'default')
	ElseIf $CmdLine[0] = 4 Then
		If $CmdLine[4] = 0 Then
			$ShowWPIFeatures = True
		EndIf
		If $CmdLine[4] = 1 Or $CmdLine[4] = 0 Then
			SplashTextOn('', 'Loading ...', 300, 18, -1, -1, 1, 'Arial', 10, 800)
		EndIf
		$ProgramToAnalyze = $CmdLine[1]
		$FileName = $CmdLine[2]
		$CmdNumber = $CmdLine[3]
		$FileExtension = StringRight($ProgramToAnalyze, 3)
		RegWrite('HKCU\Software\WPI', 'USSF_cmd1', 'REG_SZ', 'default')
		RegWrite('HKCU\Software\WPI', 'USSF_cmd2', 'REG_SZ', 'default')
		RegWrite('HKCU\Software\WPI', 'USSF_cmd3', 'REG_SZ', 'default')
		RegWrite('HKCU\Software\WPI', 'USSF_cmd4', 'REG_SZ', 'default')
		RegWrite('HKCU\Software\WPI', 'USSF_cmd5', 'REG_SZ', 'default')
		RegWrite('HKCU\Software\WPI', 'USSF_cmd6', 'REG_SZ', 'default')
		RegWrite('HKCU\Software\WPI', 'USSF_cmd7', 'REG_SZ', 'default')
		RegWrite('HKCU\Software\WPI', 'USSF_cmd8', 'REG_SZ', 'default')
		RegWrite('HKCU\Software\WPI', 'USSF_cmd9', 'REG_SZ', 'default')
		RegWrite('HKCU\Software\WPI', 'USSF_cmd10', 'REG_SZ', 'default')
		If $CmdLine[4] = 1 Or $CmdLine[4] = 2 Then
			$ShowWPIFeatures = False
			ParseProgram($ProgramToAnalyze, $FileName, $FileExtension, 1)
			SplashOff()
			Exit
		EndIf
	Else
		SplashTextOn('', 'Loading ...', 300, 18, -1, -1, 1, 'Arial', 10, 800)
		$ProgramToAnalyze = $CmdLine[1]
		$FileExtension = StringRight($ProgramToAnalyze, 3)
		$FileName = StringTrimLeft($ProgramToAnalyze, StringInStr($ProgramToAnalyze, '\', 0, -1))
	EndIf
EndIf

Opt("MustDeclareVars", 1)

If $ShowWPIFeatures Then
	Global $MainGUI = GUICreate('USSF', 600, 460, -1, -1, $WS_BORDER + $WS_POPUP)
Else
	Global $MainGUI = GUICreate('USSF', 600, 320, -1, -1, $WS_BORDER + $WS_POPUP)
EndIf

Global $Move_Button = GUICtrlCreateLabel('', 5, 13, 40, 20, $SS_CENTER, $GUI_WS_EX_PARENTDRAG)
Global $Move_Button_Frame = GUICtrlCreateLabel('', 5, 10, 40, 20, $SS_BLACKFRAME)
Global $Title = GUICtrlCreateLabel('Universal Silent Switch Finder ' & $ProgramMajorVersion & '.' & $ProgramMinorVersion & '.' & $ProgramBuildVersion & '.' & $ProgramBugfixVersion, 50, 11, 500, 20, $SS_CENTER)
Global $Title_Frame = GUICtrlCreateLabel('', 50, 10, 500, 20, $SS_BLACKFRAME)
Global $Quit_Button = GUICtrlCreateLabel('', 555, 13, 40, 20, $SS_CENTER)
Global $Quit_Button_Frame = GUICtrlCreateLabel('', 555, 10, 40, 20, $SS_BLACKFRAME)
Global $General_Container = GUICtrlCreateGraphic(5, 35, 0, 0)

GUICtrlSetGraphic($General_Container, $GUI_GR_COLOR, $General_Container_Color)
GUICtrlSetGraphic($General_Container, $GUI_GR_RECT, 0, 0, 590, 240)

Global $File_Path_Label = GUICtrlCreateLabel('', 15, 42, 25, 20)
Global $File_Path_Label_Frame = GUICtrlCreateLabel('', 10, 40, 35, 20, $SS_BLACKFRAME)
Global $File_Path_Content = GUICtrlCreateEdit('', 50, 40, 500, 20, $ES_READONLY + $ES_AUTOHSCROLL + $WS_TABSTOP)
Global $File_Path_Button = GUICtrlCreateLabel('>', 555, 42, 35, 20, $SS_CENTER)
Global $File_Path_Button_Frame = GUICtrlCreateLabel('', 555, 40, 35, 20, $SS_BLACKFRAME)
Global $File_Extension_Label = GUICtrlCreateLabel('', 15, 67, 90, 20)
Global $File_Extension_Label_Frame = GUICtrlCreateLabel('', 10, 65, 100, 20, $SS_BLACKFRAME)
Global $File_Extension_Content = GUICtrlCreateEdit('', 115, 65, 435, 20, $ES_READONLY + $ES_AUTOHSCROLL + $WS_TABSTOP)
Global $File_Extension_Button = GUICtrlCreateLabel('+', 555, 67, 35, 20, $SS_CENTER)
Global $File_Extension_Button_Frame = GUICtrlCreateLabel('', 555, 65, 35, 20, $SS_BLACKFRAME)
Global $File_Type_Label = GUICtrlCreateLabel('', 15, 92, 90, 20)
Global $File_Type_Label_Frame = GUICtrlCreateLabel('', 10, 90, 100, 20, $SS_BLACKFRAME)
Global $File_Type_Content = GUICtrlCreateEdit('', 115, 90, 435, 20, $ES_READONLY + $ES_AUTOHSCROLL + $WS_TABSTOP)
Global $File_Type_Button = GUICtrlCreateLabel('+', 555, 92, 35, 20, $SS_CENTER)
Global $File_Type_Button_Frame = GUICtrlCreateLabel('', 555, 90, 35, 20, $SS_BLACKFRAME)
Global $File_Usage_Label = GUICtrlCreateLabel('', 15, 117, 90, 20)
Global $File_Usage_Label_Frame = GUICtrlCreateLabel('', 10, 115, 100, 20, $SS_BLACKFRAME)
Global $File_Usage_Content = GUICtrlCreateEdit('', 115, 115, 435, 20, $ES_AUTOHSCROLL + $WS_TABSTOP)
Global $File_Usage_Button = GUICtrlCreateLabel('+', 555, 117, 35, 20, $SS_CENTER)
Global $File_Usage_Button_Frame = GUICtrlCreateLabel('', 555, 115, 35, 20, $SS_BLACKFRAME)
Global $File_Notes_Label = GUICtrlCreateLabel('', 15, 142, 40, 20)
Global $File_Notes_Label_Frame = GUICtrlCreateLabel('', 10, 140, 50, 20, $SS_BLACKFRAME)
Global $File_Notes_Content = GUICtrlCreateEdit('', 65, 140, 525, 130, $ES_READONLY + $ES_AUTOHSCROLL + $WS_TABSTOP)
Global $Error_Label = GUICtrlCreateLabel('', 20, 207, 30, 20, $SS_CENTER)
Global $Error_Graphic_Over = GUICtrlCreateLabel('', 10, 165, 50, 105, $SS_WHITERECT)
Global $Error_Graphic = GUICtrlCreateGraphic(10, 165, 0, 0)
If $ShowWPIFeatures Then
	Global $WPI_Line_Graphic = GUICtrlCreateGraphic(5, 285, 0, 0)
	Global $WPI_Specific_Label = GUICtrlCreateLabel('', 110, 278, 60, 20, $SS_CENTER)
	Global $WPI_Process_Status_Label = GUICtrlCreateLabel('', 10, 292, 100, 20, $SS_CENTER)
	Global $WPI_Process_Status_Label_Frame = GUICtrlCreateLabel('', 10, 290, 100, 20, $SS_BLACKFRAME)
	Global $WPI_Process_Status_Content = GUICtrlCreateLabel('', 115, 292, 475, 20, $SS_CENTER)
	Global $WPI_Process_Status_Content_Frame = GUICtrlCreateLabel('', 115, 290, 475, 20, $SS_BLACKFRAME)

	Global $WPI_cmd1_Button = GUICtrlCreateLabel('', 115, 318, 42, 20, $SS_CENTER)
	Global $WPI_cmd1_Button_Frame = GUICtrlCreateLabel('', 115, 315, 42, 20, $SS_BLACKFRAME)
	Global $WPI_cmd2_Button = GUICtrlCreateLabel('', 162, 318, 42, 20, $SS_CENTER)
	Global $WPI_cmd2_Button_Frame = GUICtrlCreateLabel('', 162, 315, 42, 20, $SS_BLACKFRAME)
	Global $WPI_cmd3_Button = GUICtrlCreateLabel('', 209, 318, 42, 20, $SS_CENTER)
	Global $WPI_cmd3_Button_Frame = GUICtrlCreateLabel('', 209, 315, 42, 20, $SS_BLACKFRAME)
	Global $WPI_cmd4_Button = GUICtrlCreateLabel('', 256, 318, 42, 20, $SS_CENTER)
	Global $WPI_cmd4_Button_Frame = GUICtrlCreateLabel('', 256, 315, 42, 20, $SS_BLACKFRAME)
	Global $WPI_cmd5_Button = GUICtrlCreateLabel('', 303, 318, 42, 20, $SS_CENTER)
	Global $WPI_cmd5_Button_Frame = GUICtrlCreateLabel('', 303, 315, 42, 20, $SS_BLACKFRAME)
	Global $WPI_cmd6_Button = GUICtrlCreateLabel('', 350, 318, 42, 20, $SS_CENTER)
	Global $WPI_cmd6_Button_Frame = GUICtrlCreateLabel('', 350, 315, 42, 20, $SS_BLACKFRAME)
	Global $WPI_cmd7_Button = GUICtrlCreateLabel('', 397, 318, 42, 20, $SS_CENTER)
	Global $WPI_cmd7_Button_Frame = GUICtrlCreateLabel('', 397, 315, 42, 20, $SS_BLACKFRAME)
	Global $WPI_cmd8_Button = GUICtrlCreateLabel('', 444, 318, 42, 20, $SS_CENTER)
	Global $WPI_cmd8_Button_Frame = GUICtrlCreateLabel('', 444, 315, 42, 20, $SS_BLACKFRAME)
	Global $WPI_cmd9_Button = GUICtrlCreateLabel('', 491, 318, 42, 20, $SS_CENTER)
	Global $WPI_cmd9_Button_Frame = GUICtrlCreateLabel('', 491, 315, 42, 20, $SS_BLACKFRAME)
	Global $WPI_cmd10_Button = GUICtrlCreateLabel('', 537, 318, 42, 20, $SS_CENTER)
	Global $WPI_cmd10_Button_Frame = GUICtrlCreateLabel('', 537, 315, 42, 20, $SS_BLACKFRAME)

	Global $WPI_cmd1_Exit_Button = GUICtrlCreateLabel('', 115, 343, 42, 20, $SS_CENTER)
	Global $WPI_cmd1_Exit_Button_Frame = GUICtrlCreateLabel('', 115, 340, 42, 20, $SS_BLACKFRAME)
	Global $WPI_cmd2_Exit_Button = GUICtrlCreateLabel('', 162, 343, 42, 20, $SS_CENTER)
	Global $WPI_cmd2_Exit_Button_Frame = GUICtrlCreateLabel('', 162, 340, 42, 20, $SS_BLACKFRAME)
	Global $WPI_cmd3_Exit_Button = GUICtrlCreateLabel('', 209, 343, 42, 20, $SS_CENTER)
	Global $WPI_cmd3_Exit_Button_Frame = GUICtrlCreateLabel('', 209, 340, 42, 20, $SS_BLACKFRAME)
	Global $WPI_cmd4_Exit_Button = GUICtrlCreateLabel('', 256, 343, 42, 20, $SS_CENTER)
	Global $WPI_cmd4_Exit_Button_Frame = GUICtrlCreateLabel('', 256, 340, 42, 20, $SS_BLACKFRAME)
	Global $WPI_cmd5_Exit_Button = GUICtrlCreateLabel('', 303, 343, 42, 20, $SS_CENTER)
	Global $WPI_cmd5_Exit_Button_Frame = GUICtrlCreateLabel('', 303, 340, 42, 20, $SS_BLACKFRAME)
	Global $WPI_cmd6_Exit_Button = GUICtrlCreateLabel('', 350, 343, 42, 20, $SS_CENTER)
	Global $WPI_cmd6_Exit_Button_Frame = GUICtrlCreateLabel('', 350, 340, 42, 20, $SS_BLACKFRAME)
	Global $WPI_cmd7_Exit_Button = GUICtrlCreateLabel('', 397, 343, 42, 20, $SS_CENTER)
	Global $WPI_cmd7_Exit_Button_Frame = GUICtrlCreateLabel('', 397, 340, 42, 20, $SS_BLACKFRAME)
	Global $WPI_cmd8_Exit_Button = GUICtrlCreateLabel('', 444, 343, 42, 20, $SS_CENTER)
	Global $WPI_cmd8_Exit_Button_Frame = GUICtrlCreateLabel('', 444, 340, 42, 20, $SS_BLACKFRAME)
	Global $WPI_cmd9_Exit_Button = GUICtrlCreateLabel('', 491, 343, 42, 20, $SS_CENTER)
	Global $WPI_cmd9_Exit_Button_Frame = GUICtrlCreateLabel('', 491, 340, 42, 20, $SS_BLACKFRAME)
	Global $WPI_cmd10_Exit_Button = GUICtrlCreateLabel('', 537, 343, 42, 20, $SS_CENTER)
	Global $WPI_cmd10_Exit_Button_Frame = GUICtrlCreateLabel('', 537, 340, 42, 20, $SS_BLACKFRAME)
	
	Global $WPI_cmdx_Button = GUICtrlCreateLabel('', 115, 368, 475, 20, $SS_CENTER)
	Global $WPI_cmdx_Button_Frame = GUICtrlCreateLabel('', 115, 365, 475, 20, $SS_BLACKFRAME)
	Global $WPI_cmdx_Exit_Button = GUICtrlCreateLabel('', 115, 393, 475, 20, $SS_CENTER)
	Global $WPI_cmdx_Exit_Button_Frame = GUICtrlCreateLabel('', 115, 390, 475, 20, $SS_BLACKFRAME)
	Global $WPI_cmd_Label = GUICtrlCreateLabel('', 10, 317, 100, 20, $SS_CENTER)
	Global $WPI_cmd_Label_Frame = GUICtrlCreateLabel('', 10, 315, 100, 20, $SS_BLACKFRAME)
	Global $WPI_cmdx_Label = GUICtrlCreateLabel('', 10, 367, 100, 20, $SS_CENTER)
	Global $WPI_cmdx_Label_Frame = GUICtrlCreateLabel('', 10, 365, 100, 20, $SS_BLACKFRAME)
	Global $WPI_cmd_Exit_Label = GUICtrlCreateLabel('', 10, 342, 100, 20, $SS_CENTER)
	Global $WPI_cmd_Exit_Label_Frame = GUICtrlCreateLabel('', 10, 340, 100, 20, $SS_BLACKFRAME)
	Global $WPI_cmdx_Exit_Label = GUICtrlCreateLabel('', 10, 392, 100, 20, $SS_CENTER)
	Global $WPI_cmdx_Exit_Label_Frame = GUICtrlCreateLabel('', 10, 390, 100, 20, $SS_BLACKFRAME)
	Global $Settings_Container = GUICtrlCreateGraphic(5, 425, 0, 0)
	Global $Language_Title = GUICtrlCreateLabel('', 125, 418, 55, 20, $SS_CENTER)
	Global $Language_Dropdown = GUICtrlCreateCombo('English', 115, 430, 75, 20, $CBS_DROPDOWNLIST)
	Global $Skin_Title = GUICtrlCreateLabel('', 215, 418, 35, 20, $SS_CENTER)
	Global $Skin_Dropdown = GUICtrlCreateCombo('Default', 195, 430, 75, 20, $CBS_DROPDOWNLIST)
	Global $Settings_Label = GUICtrlCreateLabel('', 10, 432, 100, 20, $SS_CENTER)
	Global $Settings_Label_Frame = GUICtrlCreateLabel('', 10, 430, 100, 20, $SS_BLACKFRAME)
	Global $Update_Label = GUICtrlCreateLabel($LanguageSpecificStrings[76], 515, 432, 75, 20, $SS_CENTER)
	Global $Update_Label_Frame = GUICtrlCreateLabel('', 515, 430, 75, 20, $SS_BLACKFRAME)
Else
	Global $Settings_Container = GUICtrlCreateGraphic(5, 285, 0, 0)
	Global $Language_Title = GUICtrlCreateLabel('', 125, 278, 55, 20, $SS_CENTER)
	Global $Language_Dropdown = GUICtrlCreateCombo('English', 115, 290, 75, 20, $CBS_DROPDOWNLIST)
	Global $Skin_Title = GUICtrlCreateLabel('', 215, 278, 35, 20, $SS_CENTER)
	Global $Skin_Dropdown = GUICtrlCreateCombo('Default', 195, 290, 75, 20, $CBS_DROPDOWNLIST)
	Global $Settings_Label = GUICtrlCreateLabel('', 10, 292, 100, 20, $SS_CENTER)
	Global $Settings_Label_Frame = GUICtrlCreateLabel('', 10, 290, 100, 20, $SS_BLACKFRAME)
	Global $Update_Label = GUICtrlCreateLabel($LanguageSpecificStrings[76], 515, 292, 75, 20, $SS_CENTER)
	Global $Update_Label_Frame = GUICtrlCreateLabel('', 515, 290, 75, 20, $SS_BLACKFRAME)
EndIf

GUICtrlSetGraphic($Error_Graphic, $GUI_GR_COLOR, $Error_Graphic_Color)
GUICtrlSetGraphic($Error_Graphic, $GUI_GR_RECT, 0, 0, 50, 105)
If $ShowWPIFeatures Then
	GUICtrlSetGraphic($WPI_Line_Graphic, $GUI_GR_COLOR, $WPI_Line_Graphic_Color)
	GUICtrlSetGraphic($WPI_Line_Graphic, $GUI_GR_LINE, 100, 0)
	GUICtrlSetGraphic($WPI_Line_Graphic, $GUI_GR_MOVE, 170, 0)
	GUICtrlSetGraphic($WPI_Line_Graphic, $GUI_GR_LINE, 590, 0)
	GUICtrlSetGraphic($WPI_Line_Graphic, $GUI_GR_LINE, 590, 130)
	GUICtrlSetGraphic($WPI_Line_Graphic, $GUI_GR_LINE, 0, 130)
	GUICtrlSetGraphic($WPI_Line_Graphic, $GUI_GR_LINE, 0, 0)
EndIf
GUICtrlSetGraphic($Settings_Container, $GUI_GR_COLOR, $Settings_Container_Color)
GUICtrlSetGraphic($Settings_Container, $GUI_GR_LINE, 590, 0)
GUICtrlSetGraphic($Settings_Container, $GUI_GR_LINE, 590, 30)
GUICtrlSetGraphic($Settings_Container, $GUI_GR_LINE, 0, 30)
GUICtrlSetGraphic($Settings_Container, $GUI_GR_LINE, 0, 0)

GUICtrlSetFont($Title, 13, 1000, -1, 'Arial')
GUICtrlSetFont($File_Path_Label, 10, 1000, -1, 'Arial')
GUICtrlSetFont($File_Path_Content, 10, 1000, -1, 'Arial')
GUICtrlSetFont($File_Path_Button, 10, 1000, -1, 'Arial')
GUICtrlSetFont($File_Extension_Label, 10, 1000, -1, 'Arial')
GUICtrlSetFont($File_Extension_Content, 10, 1000, -1, 'Arial')
GUICtrlSetFont($File_Extension_Button, 10, 1000, -1, 'Arial')
GUICtrlSetFont($File_Type_Label, 10, 1000, -1, 'Arial')
GUICtrlSetFont($File_Type_Content, 10, 1000, -1, 'Arial')
GUICtrlSetFont($File_Type_Button, 10, 1000, -1, 'Arial')
GUICtrlSetFont($File_Usage_Label, 10, 1000, -1, 'Arial')
GUICtrlSetFont($File_Usage_Content, 10, 1000, -1, 'Arial')
GUICtrlSetFont($File_Usage_Button, 10, 1000, -1, 'Arial')
GUICtrlSetFont($File_Notes_Label, 10, 1000, -1, 'Arial')
GUICtrlSetFont($File_Notes_Content, 10, 1000, -1, 'Arial')
GUICtrlSetFont($Error_Label, 10, 1000, -1, 'Arial')
GUICtrlSetFont($Move_Button, 8)
GUICtrlSetFont($Quit_Button, 8)
If $ShowWPIFeatures Then
	GUICtrlSetFont($WPI_Specific_Label, 8, 400, -1, 'Arial')
	GUICtrlSetFont($WPI_Process_Status_Label, 10, 1000, -1, 'Arial')
	GUICtrlSetFont($WPI_Process_Status_Content, 10, 1000, -1, 'Arial')
	GUICtrlSetFont($WPI_cmd1_Button, 8)
	GUICtrlSetFont($WPI_cmd2_Button, 8)
	GUICtrlSetFont($WPI_cmd3_Button, 8)
	GUICtrlSetFont($WPI_cmd4_Button, 8)
	GUICtrlSetFont($WPI_cmd5_Button, 8)
	GUICtrlSetFont($WPI_cmd6_Button, 8)
	GUICtrlSetFont($WPI_cmd7_Button, 8)
	GUICtrlSetFont($WPI_cmd8_Button, 8)
	GUICtrlSetFont($WPI_cmd9_Button, 8)
	GUICtrlSetFont($WPI_cmd10_Button, 8)
	GUICtrlSetFont($WPI_cmdx_Button, 8)
	GUICtrlSetFont($WPI_cmdx_Exit_Button, 8)
	GUICtrlSetFont($WPI_cmd_Label, 10, 1000, -1, 'Arial')
	GUICtrlSetFont($WPI_cmd_Exit_Label, 10, 1000, -1, 'Arial')
	GUICtrlSetFont($WPI_cmdx_Label, 10, 1000, -1, 'Arial')
	GUICtrlSetFont($WPI_cmdx_Exit_Label, 10, 1000, -1, 'Arial')
EndIf
GUICtrlSetFont($Language_Title, 8, 400, -1, 'Arial')
GUICtrlSetFont($Skin_Title, 8, 400, -1, 'Arial')
GUICtrlSetFont($Settings_Label, 10, 1000, -1, 'Arial')
GUICtrlSetFont($Update_Label, 10, 1000, -1, 'Arial')

GUICtrlSetColor($File_Extension_Content, $File_Extension_Content_Color)
GUICtrlSetColor($File_Type_Content, $File_Type_Content_Color)
GUICtrlSetColor($File_Usage_Content, $File_Usage_Content_Color)
GUICtrlSetColor($File_Notes_Content, $File_Notes_Content_Color)
GUICtrlSetColor($Error_Label, $Error_Label_Color)
If $ShowWPIFeatures Then
	GUICtrlSetColor($WPI_Specific_Label, $WPI_Specific_Label_Color)
	GUICtrlSetColor($WPI_cmd1_Button, $WPI_cmd1_Button_Color)
	GUICtrlSetColor($WPI_cmd2_Button, $WPI_cmd2_Button_Color)
	GUICtrlSetColor($WPI_cmd3_Button, $WPI_cmd3_Button_Color)
	GUICtrlSetColor($WPI_cmd4_Button, $WPI_cmd4_Button_Color)
	GUICtrlSetColor($WPI_cmd5_Button, $WPI_cmd5_Button_Color)
	GUICtrlSetColor($WPI_cmd6_Button, $WPI_cmd6_Button_Color)
	GUICtrlSetColor($WPI_cmd7_Button, $WPI_cmd7_Button_Color)
	GUICtrlSetColor($WPI_cmd8_Button, $WPI_cmd8_Button_Color)
	GUICtrlSetColor($WPI_cmd9_Button, $WPI_cmd9_Button_Color)
	GUICtrlSetColor($WPI_cmd10_Button, $WPI_cmd10_Button_Color)
	GUICtrlSetColor($WPI_cmd1_Exit_Button, $WPI_cmd1_Exit_Button_Color)
	GUICtrlSetColor($WPI_cmd2_Exit_Button, $WPI_cmd2_Exit_Button_Color)
	GUICtrlSetColor($WPI_cmd3_Exit_Button, $WPI_cmd3_Exit_Button_Color)
	GUICtrlSetColor($WPI_cmd4_Exit_Button, $WPI_cmd4_Exit_Button_Color)
	GUICtrlSetColor($WPI_cmd5_Exit_Button, $WPI_cmd5_Exit_Button_Color)
	GUICtrlSetColor($WPI_cmd6_Exit_Button, $WPI_cmd6_Exit_Button_Color)
	GUICtrlSetColor($WPI_cmd7_Exit_Button, $WPI_cmd7_Exit_Button_Color)
	GUICtrlSetColor($WPI_cmd8_Exit_Button, $WPI_cmd8_Exit_Button_Color)
	GUICtrlSetColor($WPI_cmd9_Exit_Button, $WPI_cmd9_Exit_Button_Color)
	GUICtrlSetColor($WPI_cmd10_Exit_Button, $WPI_cmd10_Exit_Button_Color)
	GUICtrlSetColor(Eval('WPI_cmd' & $CmdNumber & '_Button'), $CmdNumber_Good)
	GUICtrlSetColor(Eval('WPI_cmd' & $CmdNumber & '_Exit_Button'), $CmdNumber_Exit_Good)
	GUICtrlSetColor($WPI_cmdx_Button, $WPI_cmdx_Button_Color)
	GUICtrlSetColor($WPI_cmdx_Exit_Button, $WPI_cmdx_Exit_Button_Color)
EndIf
GUICtrlSetColor($Language_Title, $Language_Title_Color)
GUICtrlSetColor($Skin_Title, $Skin_Title_Color)

GUICtrlSetCursor($Move_Button, 0)
GUICtrlSetCursor($Quit_Button, 0)
GUICtrlSetCursor($File_Extension_Button, 0)
GUICtrlSetCursor($File_Type_Button, 0)
GUICtrlSetCursor($File_Path_Button, 0)
GUICtrlSetCursor($File_Usage_Button, 0)
If $ShowWPIFeatures Then
	GUICtrlSetCursor($WPI_cmd1_Button, 0)
	GUICtrlSetCursor($WPI_cmd2_Button, 0)
	GUICtrlSetCursor($WPI_cmd3_Button, 0)
	GUICtrlSetCursor($WPI_cmd4_Button, 0)
	GUICtrlSetCursor($WPI_cmd5_Button, 0)
	GUICtrlSetCursor($WPI_cmd6_Button, 0)
	GUICtrlSetCursor($WPI_cmd7_Button, 0)
	GUICtrlSetCursor($WPI_cmd8_Button, 0)
	GUICtrlSetCursor($WPI_cmd9_Button, 0)
	GUICtrlSetCursor($WPI_cmd10_Button, 0)
	GUICtrlSetCursor($WPI_cmd1_Exit_Button, 0)
	GUICtrlSetCursor($WPI_cmd2_Exit_Button, 0)
	GUICtrlSetCursor($WPI_cmd3_Exit_Button, 0)
	GUICtrlSetCursor($WPI_cmd4_Exit_Button, 0)
	GUICtrlSetCursor($WPI_cmd5_Exit_Button, 0)
	GUICtrlSetCursor($WPI_cmd6_Exit_Button, 0)
	GUICtrlSetCursor($WPI_cmd7_Exit_Button, 0)
	GUICtrlSetCursor($WPI_cmd8_Exit_Button, 0)
	GUICtrlSetCursor($WPI_cmd9_Exit_Button, 0)
	GUICtrlSetCursor($WPI_cmd10_Exit_Button, 0)
	GUICtrlSetCursor($WPI_cmdx_Button, 0)
	GUICtrlSetCursor($WPI_cmdx_Exit_Button, 0)
EndIf
GUICtrlSetCursor($File_Extension_Content, 2)
GUICtrlSetCursor($File_Path_Content, 2)
GUICtrlSetCursor($File_Type_Content, 2)
GUICtrlSetCursor($Update_Label, 0)

GUICtrlSetBkColor($Title, $Title_Color_Bk)
GUICtrlSetBkColor($File_Usage_Content, $File_Usage_Content_Color_Bk)
If $ShowWPIFeatures Then
	GUICtrlSetBkColor($WPI_Process_Status_Content_Frame, $WPI_Process_Status_Content_Frame_Color_Bk)
EndIf

ParseLanguage($LanguageSpecificStrings)
GetSkins()

If $SkinLoadedFromRegistry Then
	GUICtrlSetData($Skin_Dropdown, $RegSkin, $RegSkin)
EndIf

If $LangLoadedFromRegistry Then
	GUICtrlSetData($Language_Dropdown, $RegLang, $RegLang)
EndIf

GUISetBkColor($BKColor)

SplashOff()

GUISetState()

ParseProgram($ProgramToAnalyze, $FileName, $FileExtension, 0)

If $ShowWPIFeatures Then
	AttachToWPI()
EndIf

Local $Msg
Do
	Sleep(10)
	$Msg = GUIGetMsg()
	Select
		Case $Msg = $File_Path_Button
			GUICtrlSetStyle($File_Path_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($File_Path_Button_Frame, $SS_BLACKFRAME)
			Browse()
		Case $Msg = $File_Extension_Button
			GUICtrlSetStyle($File_Extension_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($File_Extension_Button_Frame, $SS_BLACKFRAME)
			ClipPut(GUICtrlRead($File_Extension_Content))
		Case $Msg = $File_Type_Button
			GUICtrlSetStyle($File_Type_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($File_Type_Button_Frame, $SS_BLACKFRAME)
			ClipPut(GUICtrlRead($File_Type_Content))
		Case $Msg = $File_Usage_Button
			GUICtrlSetStyle($File_Usage_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($File_Usage_Button_Frame, $SS_BLACKFRAME)
			ClipPut(GUICtrlRead($File_Usage_Content))
		Case $ShowWPIFeatures And $Msg = $WPI_cmdx_Button
			GUICtrlSetStyle($WPI_cmdx_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($WPI_cmdx_Button_Frame, $SS_BLACKFRAME)
			SendToWPI($File_Usage_Content, $CmdNumber)
		Case $ShowWPIFeatures And $Msg = $WPI_cmdx_Exit_Button
			GUICtrlSetStyle($WPI_cmdx_Exit_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($WPI_cmdx_Exit_Button_Frame, $SS_BLACKFRAME)
			SendToWPI($File_Usage_Content, $CmdNumber)
			ExitUSSF()
		Case $ShowWPIFeatures And $Msg = $WPI_cmd1_Button
			GUICtrlSetStyle($WPI_cmd1_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($WPI_cmd1_Button_Frame, $SS_BLACKFRAME)
			SendToWPI($File_Usage_Content, 1)
		Case $ShowWPIFeatures And $Msg = $WPI_cmd2_Button
			GUICtrlSetStyle($WPI_cmd2_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($WPI_cmd2_Button_Frame, $SS_BLACKFRAME)
			SendToWPI($File_Usage_Content, 2)
		Case $ShowWPIFeatures And $Msg = $WPI_cmd3_Button
			GUICtrlSetStyle($WPI_cmd3_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($WPI_cmd3_Button_Frame, $SS_BLACKFRAME)
			SendToWPI($File_Usage_Content, 3)
		Case $ShowWPIFeatures And $Msg = $WPI_cmd4_Button
			GUICtrlSetStyle($WPI_cmd4_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($WPI_cmd4_Button_Frame, $SS_BLACKFRAME)
			SendToWPI($File_Usage_Content, 4)
		Case $ShowWPIFeatures And $Msg = $WPI_cmd5_Button
			GUICtrlSetStyle($WPI_cmd5_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($WPI_cmd5_Button_Frame, $SS_BLACKFRAME)
			SendToWPI($File_Usage_Content, 5)
		Case $ShowWPIFeatures And $Msg = $WPI_cmd6_Button
			GUICtrlSetStyle($WPI_cmd6_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($WPI_cmd6_Button_Frame, $SS_BLACKFRAME)
			SendToWPI($File_Usage_Content, 6)
		Case $ShowWPIFeatures And $Msg = $WPI_cmd7_Button
			GUICtrlSetStyle($WPI_cmd7_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($WPI_cmd7_Button_Frame, $SS_BLACKFRAME)
			SendToWPI($File_Usage_Content, 7)
		Case $ShowWPIFeatures And $Msg = $WPI_cmd8_Button
			GUICtrlSetStyle($WPI_cmd8_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($WPI_cmd8_Button_Frame, $SS_BLACKFRAME)
			SendToWPI($File_Usage_Content, 8)
		Case $ShowWPIFeatures And $Msg = $WPI_cmd9_Button
			GUICtrlSetStyle($WPI_cmd9_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($WPI_cmd9_Button_Frame, $SS_BLACKFRAME)
			SendToWPI($File_Usage_Content, 9)
		Case $ShowWPIFeatures And $Msg = $WPI_cmd10_Button
			GUICtrlSetStyle($WPI_cmd10_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($WPI_cmd10_Button_Frame, $SS_BLACKFRAME)
			SendToWPI($File_Usage_Content, 10)
		Case $ShowWPIFeatures And $Msg = $WPI_cmd1_Exit_Button
			GUICtrlSetStyle($WPI_cmd1_Exit_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($WPI_cmd1_Exit_Button_Frame, $SS_BLACKFRAME)
			SendToWPI($File_Usage_Content, 1)
			ExitUSSF()
		Case $ShowWPIFeatures And $Msg = $WPI_cmd2_Exit_Button
			GUICtrlSetStyle($WPI_cmd2_Exit_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($WPI_cmd2_Exit_Button_Frame, $SS_BLACKFRAME)
			SendToWPI($File_Usage_Content, 2)
			ExitUSSF()
		Case $ShowWPIFeatures And $Msg = $WPI_cmd3_Exit_Button
			GUICtrlSetStyle($WPI_cmd3_Exit_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($WPI_cmd3_Exit_Button_Frame, $SS_BLACKFRAME)
			SendToWPI($File_Usage_Content, 3)
			ExitUSSF()
		Case $ShowWPIFeatures And $Msg = $WPI_cmd4_Exit_Button
			GUICtrlSetStyle($WPI_cmd4_Exit_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($WPI_cmd4_Exit_Button_Frame, $SS_BLACKFRAME)
			SendToWPI($File_Usage_Content, 4)
			ExitUSSF()
		Case $ShowWPIFeatures And $Msg = $WPI_cmd5_Exit_Button
			GUICtrlSetStyle($WPI_cmd5_Exit_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($WPI_cmd5_Exit_Button_Frame, $SS_BLACKFRAME)
			SendToWPI($File_Usage_Content, 5)
			ExitUSSF()
		Case $ShowWPIFeatures And $Msg = $WPI_cmd6_Exit_Button
			GUICtrlSetStyle($WPI_cmd6_Exit_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($WPI_cmd6_Exit_Button_Frame, $SS_BLACKFRAME)
			SendToWPI($File_Usage_Content, 6)
			ExitUSSF()
		Case $ShowWPIFeatures And $Msg = $WPI_cmd7_Exit_Button
			GUICtrlSetStyle($WPI_cmd7_Exit_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($WPI_cmd7_Exit_Button_Frame, $SS_BLACKFRAME)
			SendToWPI($File_Usage_Content, 7)
			ExitUSSF()
		Case $ShowWPIFeatures And $Msg = $WPI_cmd8_Exit_Button
			GUICtrlSetStyle($WPI_cmd8_Exit_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($WPI_cmd8_Exit_Button_Frame, $SS_BLACKFRAME)
			SendToWPI($File_Usage_Content, 8)
			ExitUSSF()
		Case $ShowWPIFeatures And $Msg = $WPI_cmd9_Exit_Button
			GUICtrlSetStyle($WPI_cmd9_Exit_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($WPI_cmd9_Exit_Button_Frame, $SS_BLACKFRAME)
			SendToWPI($File_Usage_Content, 9)
			ExitUSSF()
		Case $ShowWPIFeatures And $Msg = $WPI_cmd10_Exit_Button
			GUICtrlSetStyle($WPI_cmd10_Exit_Button_Frame, $SS_BLACKRECT)
			Sleep(100)
			GUICtrlSetStyle($WPI_cmd10_Exit_Button_Frame, $SS_BLACKFRAME)
			SendToWPI($File_Usage_Content, 10)
			ExitUSSF()
		Case $Msg = $Language_Dropdown
			GUISetState(@SW_DISABLE)
			SplashTextOn('', $LanguageSpecificStrings[49], 300, 18, -1, -1, 1, 'Arial', 10, 800)
			Local $NewLang = GUICtrlRead($Language_Dropdown)
			$RegLang = RegRead('HKCU\Software\USSF', 'Skin')
			If @error Or $RegLang <> $NewLang Then
				RegWrite('HKCU\Software\USSF', 'Language', 'REG_SZ', $NewLang)
			EndIf
			SetLanguage($NewLang)
			ParseLanguage($LanguageSpecificStrings)
			SplashOff()
			GUISetState(@SW_ENABLE)
		Case $Msg = $Skin_Dropdown
			GUISetState(@SW_HIDE)
			SplashTextOn('', $LanguageSpecificStrings[50], 300, 18, -1, -1, 1, 'Arial', 10, 800)
			Local $NewSkin = GUICtrlRead($Skin_Dropdown)
			$RegSkin = RegRead('HKCU\Software\USSF', 'Skin')
			If $RegSkin <> $NewSkin Then
				RegWrite('HKCU\Software\USSF', 'Skin', 'REG_SZ', $NewSkin)
			EndIf
			If $NewSkin = 'Default' Then
				$General_Container_Color = 0xCFCFCF
				$Error_Graphic_Color = 0xFF0000
				$WPI_Line_Graphic_Color = 0xCFCFCF
				$Settings_Container_Color = 0xCFCFCF
				$File_Extension_Content_Color = 0xDD0000
				$File_Type_Content_Color = 0x000099
				$File_Usage_Content_Color = 0x009900
				$File_Notes_Content_Color = 0x7F7F7F
				$Error_Label_Color = 0xFF0000
				$WPI_Specific_Label_Color = 0xCFCFCF
				$WPI_cmd1_Button_Color = 0xDD0000
				$WPI_cmd2_Button_Color = 0xDD0000
				$WPI_cmd3_Button_Color = 0xDD0000
				$WPI_cmd4_Button_Color = 0xDD0000
				$WPI_cmd5_Button_Color = 0xDD0000
				$WPI_cmd6_Button_Color = 0xDD0000
				$WPI_cmd7_Button_Color = 0xDD0000
				$WPI_cmd8_Button_Color = 0xDD0000
				$WPI_cmd9_Button_Color = 0xDD0000
				$WPI_cmd10_Button_Color = 0xDD0000
				$WPI_cmd1_Exit_Button_Color = 0xDD0000
				$WPI_cmd2_Exit_Button_Color = 0xDD0000
				$WPI_cmd3_Exit_Button_Color = 0xDD0000
				$WPI_cmd4_Exit_Button_Color = 0xDD0000
				$WPI_cmd5_Exit_Button_Color = 0xDD0000
				$WPI_cmd6_Exit_Button_Color = 0xDD0000
				$WPI_cmd7_Exit_Button_Color = 0xDD0000
				$WPI_cmd8_Exit_Button_Color = 0xDD0000
				$WPI_cmd9_Exit_Button_Color = 0xDD0000
				$WPI_cmd10_Exit_Button_Color = 0xDD0000
				$CmdNumber_Good = 0x009900
				$CmdNumber_Exit_Good = 0x009900
				$WPI_cmdx_Button_Color = 0x009900
				$WPI_cmdx_Exit_Button_Color = 0x009900
				$Language_Title_Color = 0xCFCFCF
				$Skin_Title_Color = 0xCFCFCF
				$WPI_Process_Status_Content_Bad = 0xDD0000
				$WPI_Process_Status_Content_Good = 0x009900
				$Title_Color_Bk = 0xF1F3F8
				$File_Usage_Content_Color_Bk = 0xF1F3F8
				$WPI_Process_Status_Content_Frame_Color_Bk = 0xF1F3F8
				$BKColor = 0xFFFFFF
			Else
				GetSkinVars($NewSkin)
			EndIf
			RedrawSkin()
			SplashOff()
			GUISetState(@SW_SHOW)
		Case $Msg = $Update_Label
			$AbortAutoUpdate = False
			GetLatestVersionNumber()
	EndSelect
Until $Msg = $GUI_EVENT_CLOSE Or $Msg = $Quit_Button

ExitUSSF()

;############################################### Custom Functions ###############################################
Func ExitUSSF()
	If $LaunchedByWPI Then
		WinSetState('Windows Post-Install Wizard', '', @SW_ENABLE)
	EndIf
	Exit
EndFunc

Func ShowMessage($MessageNumber, $NoGUI)
	If Not $NoGUI Then
		GUICtrlSetData($File_Path_Content, $ProgramToAnalyze)
		GUICtrlSetData($File_Extension_Content, $USSF_Messages[$MessageNumber][1])
		GUICtrlSetData($File_Type_Content, $USSF_Messages[$MessageNumber][2])
		GUICtrlSetData($File_Usage_Content, $USSF_Messages[$MessageNumber][3])
		WinWaitActive('USSF')
		ControlSend('USSF', '', 'Edit4', '{END}')
		GUICtrlSetData($File_Notes_Content, $USSF_Messages[$MessageNumber][4])
	Else
		If $USSF_Messages[$MessageNumber][3] <> $USSF_Messages[1][4] Then
			RegWrite('HKCU\Software\WPI', 'USSF_cmd' & $CmdNumber, 'REG_SZ', $USSF_Messages[$MessageNumber][3])
		EndIf
	EndIf
EndFunc

Func ParseError($ErrorNumber, $NoGUI = 0)
	If Not $NoGUI Then
		GUICtrlSetState($Error_Graphic_Over, $GUI_HIDE)
		If $ProgramToAnalyze = '' Then
			$ProgramToAnalyze = $LanguageSpecificStrings[7]
		EndIf
		GUICtrlSetData($File_Path_Content, $ProgramToAnalyze)
		GUICtrlSetData($File_Extension_Content, $USSF_Errors[$ErrorNumber][1])
		GUICtrlSetData($File_Type_Content, $USSF_Errors[$ErrorNumber][2])
		GUICtrlSetData($File_Usage_Content, $USSF_Errors[$ErrorNumber][3])
		GUICtrlSetData($File_Notes_Content, $USSF_Errors[$ErrorNumber][4])
	EndIf
EndFunc

Func GetFileHeader($ProgramToAnalyze, $NumberOfCharsToReturn)
	Local $FileHandle = FileOpen($ProgramToAnalyze, 0)
	If $FileHandle = -1 Then
		ParseError(7)
		FileClose($FileHandle)
		Return 0
	Else
		Local $Header
		$Header = FileRead($FileHandle, $NumberOfCharsToReturn / 2)
		$Header = _StringToHex($Header)
		FileClose($FileHandle)
		Return $Header
	EndIf
EndFunc

Func TestRegFile($ProgramToAnalyze)
	Local $FinalHeader
	Local $Header = GetFileHeader($ProgramToAnalyze, 156)
	If $Header <> 0 Then
		If StringLeft($Header, 4) == 'FFFE' Then
			;Original .reg file encoded in UTF-16, little-endian
			$Header = StringTrimLeft($Header, 4)
			For $i = 1 To StringLen($Header) Step 4
				$FinalHeader = $FinalHeader & StringMid($Header, $i, 2)
			Next
			$Header = $FinalHeader
		EndIf
		If StringLeft($Header, 76) <> '57696E646F777320526567697374727920456469746F722056657273696F6E20352E30300D0A' And StringLeft($Header, 20) <> '52454745444954340D0A' Then
			ParseError(3)
			Return 2
		EndIf
		Return 1
	Else
		Return 0
	EndIf
EndFunc

Func TestExeFile($ProgramToAnalyze, $NoGUI)
	Local $IDString = PEiD($ProgramToAnalyze)
	Select
		Case StringInStr($IDString, "Nullsoft PiMP SFX", 0)
			ShowMessage(3, $NoGUI)
		Case StringInStr($IDString, "Inno Setup", 0)
			ShowMessage(4, $NoGUI)
		Case StringInStr($IDString, "Installshield AFW", 0)
			ShowMessage(5, $NoGUI)
		Case StringInStr($IDString, "InstallShield 2003", 0)
			ShowMessage(6, $NoGUI)
		Case StringInStr($IDString, "Wise Installer", 0) Or StringInStr($IDString, "PEncrypt 4.0", 0)
			ShowMessage(7, $NoGUI)
		Case StringInStr($IDString, "RAR SFX", 0)
			ShowMessage(8, $NoGUI)
		Case StringInStr($IDString, "CAB SFX", 0) Or StringInStr($IDString, "SPx Method", 0)
			ShowMessage(9, $NoGUI)
		Case StringInStr($IDString, "ZIP SFX", 0)
			ShowMessage(10, $NoGUI)
		Case StringInStr($IDString, "Borland Delphi", 0)
			If TestInno($ProgramToAnalyze) = 1 Then
				ShowMessage(4, $NoGUI)
			ElseIf TestZipSFX($ProgramToAnalyze) = 1 Then
				ShowMessage(10, $NoGUI)
			Else
				$USSF_Errors[5][4] = StringReplace($USSF_Errors[5][4], '%header%', $IDString)
				ParseError(5, $NoGUI)
			EndIf
		Case StringInStr($IDString, "Microsoft Visual C++", 0) And Not StringInStr($IDString, "SPx Method", 0) And Test7Zip($ProgramToAnalyze) = 1
			ShowMessage(11, $NoGUI)
		Case StringInStr($IDString, "Not a valid PE file", 0)
			If Test7Zip($ProgramToAnalyze) = 1 Then
				ShowMessage(12, $NoGUI)
			ElseIf TestZipSFX($ProgramToAnalyze) = 2 Then
				ShowMessage(13, $NoGUI)
			Else
				ParseError(8, $NoGUI)
			EndIf
		Case StringInStr($IDString, "WinZip", 0)
			ShowMessage(14, $NoGUI)
		Case StringInStr($IDString, "UPX", 0)
			ShowMessage(15, $NoGUI)
		Case Else
			If Test7Zip($ProgramToAnalyze) = 1 Then
				ShowMessage(12, $NoGUI)
			ElseIf TestZipSFX($ProgramToAnalyze) = 2 Then
				ShowMessage(13, $NoGUI)
			Else
				$USSF_Errors[5][4] = StringReplace($USSF_Errors[5][4], '%header%', $IDString)
				ParseError(5, $NoGUI)
			EndIf
	EndSelect
EndFunc

Func PEiD($ProgramToAnalyze)
	Local $ExSig = RegRead("HKCU\Software\PEiD", "ExSig")
	Local $LoadPlugins = RegRead("HKCU\Software\PEiD", "LoadPlugins")
	Local $StayOnTop = RegRead("HKCU\Software\PEiD", "StayOnTop")
	RegWrite("HKCU\Software\PEiD", "ExSig", "REG_DWORD", 0)
	RegWrite("HKCU\Software\PEiD", "LoadPlugins", "REG_DWORD", 0)
	RegWrite("HKCU\Software\PEiD", "StayOnTop", "REG_DWORD", 0)
	If Not FileExists(@TempDir & "\PEiD.exe") Then
		FileInstall("C:\Users\sadicq\Desktop\USSF\bin\PEiD.exe", @TempDir & "\PEiD.exe", 1)
	EndIf
	Run(@TempDir & "\PEiD.exe -hard " & '"' & $ProgramToAnalyze & '"', "", @SW_HIDE)
	Local $IDString
	WinWait("PEiD v0.9")
	Do
		$IDString = ControlGetText("PEiD v0.9", "", "Edit2")
		Sleep(100)
	Until $IDString <> "Scanning..." And $IDString <> ""
	WinClose("PEiD v0.9")
	RegWrite("HKCU\Software\PEiD", "ExSig", "REG_DWORD", $ExSig)
	RegWrite("HKCU\Software\PEiD", "LoadPlugins", "REG_DWORD", $LoadPlugins)
	RegWrite("HKCU\Software\PEiD", "StayOnTop", "REG_DWORD", $StayOnTop)
	Return $IDString
EndFunc

Func TestInno($ProgramToAnalyze)
	If Not FileExists(@TempDir & "\innounp.exe") Then
		FileInstall("C:\Users\sadicq\Desktop\USSF\bin\innounp.exe", @TempDir & "\innounp.exe", 1)
	EndIf
	Local $PID = Run(@ComSpec & ' /c ""' & @TempDir & '\innounp.exe" "' & $ProgramToAnalyze & '""', "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	Local $Output, $OutputAux
	While 1
		$OutputAux = StdoutRead($PID)
		If @error Then
			ExitLoop
		EndIf
		$Output = $Output & $OutputAux
	Wend
	While 1
		$OutputAux = StdErrRead($PID)
		If @error Then
			ExitLoop
		EndIf
		$Output = $Output & $OutputAux
	Wend
	ProcessClose($PID)
	If StringInStr($Output, 'Version detected:', 0) Then
		Return 1
	EndIf
	Return 0
EndFunc

Func TestZipSFX($ProgramToAnalyze)
	If Not FileExists(@TempDir & "\unzip.exe") Then
		FileInstall("C:\Users\sadicq\Desktop\USSF\bin\unzip.exe", @TempDir & "\unzip.exe", 1)
	EndIf
	Local $PID = Run(@ComSpec & ' /c ""' & @TempDir & '\unzip.exe" -l "' & $ProgramToAnalyze & '""', "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	Local $Output, $OutputAux
	While 1
		$OutputAux = StdoutRead($PID)
		If @error Then
			ExitLoop
		EndIf
		$Output = $Output & $OutputAux
	Wend
	While 1
		$OutputAux = StdErrRead($PID)
		If @error Then
			ExitLoop
		EndIf
		$Output = $Output & $OutputAux
	Wend
	ProcessClose($PID)
	If Not StringInStr($Output, 'signature not found', 0) Then
		Return 1
	EndIf
	If StringInStr($Output, 'Length', 0) Then
		Return 2
	EndIf
	Return 0
EndFunc

Func Test7Zip($ProgramToAnalyze)
	If Not FileExists(@TempDir & "\7z.exe") Then
		FileInstall("C:\Users\sadicq\Desktop\USSF\bin\7z.exe", @TempDir & "\7z.exe", 1)
	EndIf
	Local $PID = Run(@ComSpec & ' /c ""' & @TempDir & '\7z.exe" l "' & $ProgramToAnalyze & '""', "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	Local $Output, $OutputAux
	While 1
		$OutputAux = StdoutRead($PID)
		If @error Then
			ExitLoop
		EndIf
		$Output = $Output & $OutputAux
	Wend
	While 1
		$OutputAux = StdErrRead($PID)
		If @error Then
			ExitLoop
		EndIf
		$Output = $Output & $OutputAux
	Wend
	ProcessClose($PID)
	If StringInStr($Output, 'Listing archive:', 0) Then
		Return 1
	EndIf
	Return 0
EndFunc

Func Browse()
	$ProgramToAnalyze = FileOpenDialog("Select the program to analyze", '', "Supported files (*.exe;*.msi;*.reg;*.inf)|Executable Files (*.exe)|Microsoft Installer files (*.msi)|Registry files (*.reg)|Inf files (*.inf)", 3)
	$FileExtension = StringRight($ProgramToAnalyze, 3)
	$FileName = StringTrimLeft($ProgramToAnalyze, StringInStr($ProgramToAnalyze, '\', 0, -1))
	ParseProgram($ProgramToAnalyze, $FileName, $FileExtension, 0)
EndFunc

Func ParseProgram($ProgramToAnalyze, $FileName, $FileExtension, $NoGUI)
	If Not $NoGUI Then
		GUICtrlSetState($Error_Graphic_Over, $GUI_SHOW)
		GUICtrlSetData($File_Path_Content, $LanguageSpecificStrings[8])
		GUICtrlSetData($File_Extension_Content, $LanguageSpecificStrings[9])
		GUICtrlSetData($File_Type_Content, $LanguageSpecificStrings[9])
		GUICtrlSetData($File_Usage_Content, $LanguageSpecificStrings[9])
		GUICtrlSetData($File_Notes_Content, $LanguageSpecificStrings[9])
	EndIf
	SetMessageAndErrorContent($FileName, $FileExtension, 'English')
	If Not FileExists($ProgramToAnalyze) Then
		ParseError(4, $NoGUI)
	Else
		Select
			Case $FileExtension = 'msi'
				Local $Aux = GetFileHeader($ProgramToAnalyze, 66)
				If $Aux == 'D0CF11E0A1B11AE1000000000000000000000000000000003E000300FEFF090006' Then
					ShowMessage(16, $NoGUI)
				ElseIf $Aux <> 0 Then
					ParseError(2, $NoGUI)
				EndIf
			Case $FileExtension = 'exe'
				Local $Aux = GetFileHeader($ProgramToAnalyze, 4)
				If $Aux == '4D5A' Then
					TestExeFile($ProgramToAnalyze, $NoGUI)
				ElseIf $Aux <> 0 Then
					ParseError(1, $NoGUI)
				EndIf
			Case $FileExtension = 'inf'
				ShowMessage(1, $NoGUI)
			Case $FileExtension = 'reg'
				If TestRegFile($ProgramToAnalyze) = 1 Then
					ShowMessage(2, $NoGUI)
				EndIf
			Case Else
				ParseError(6, $NoGUI)
		EndSelect
	EndIf
EndFunc

Func AttachToWPI()
	If Not WinExists('Windows Post-Install Wizard') Or Not ProcessExists('mshta.exe') Or $CmdLine[0] <> 4 Then
		GUICtrlSetColor($WPI_Process_Status_Content, $WPI_Process_Status_Content_Bad)
		GUICtrlSetData($WPI_Process_Status_Content, $LanguageSpecificStrings[14])
		GUICtrlSetState($WPI_cmd1_Button, $GUI_DISABLE)
		GUICtrlSetState($WPI_cmd2_Button, $GUI_DISABLE)
		GUICtrlSetState($WPI_cmd3_Button, $GUI_DISABLE)
		GUICtrlSetState($WPI_cmd4_Button, $GUI_DISABLE)
		GUICtrlSetState($WPI_cmd5_Button, $GUI_DISABLE)
		GUICtrlSetState($WPI_cmd6_Button, $GUI_DISABLE)
		GUICtrlSetState($WPI_cmd7_Button, $GUI_DISABLE)
		GUICtrlSetState($WPI_cmd8_Button, $GUI_DISABLE)
		GUICtrlSetState($WPI_cmd9_Button, $GUI_DISABLE)
		GUICtrlSetState($WPI_cmd10_Button, $GUI_DISABLE)
		GUICtrlSetState($WPI_cmd1_Exit_Button, $GUI_DISABLE)
		GUICtrlSetState($WPI_cmd2_Exit_Button, $GUI_DISABLE)
		GUICtrlSetState($WPI_cmd3_Exit_Button, $GUI_DISABLE)
		GUICtrlSetState($WPI_cmd4_Exit_Button, $GUI_DISABLE)
		GUICtrlSetState($WPI_cmd5_Exit_Button, $GUI_DISABLE)
		GUICtrlSetState($WPI_cmd6_Exit_Button, $GUI_DISABLE)
		GUICtrlSetState($WPI_cmd7_Exit_Button, $GUI_DISABLE)
		GUICtrlSetState($WPI_cmd8_Exit_Button, $GUI_DISABLE)
		GUICtrlSetState($WPI_cmd9_Exit_Button, $GUI_DISABLE)
		GUICtrlSetState($WPI_cmd10_Exit_Button, $GUI_DISABLE)
		GUICtrlSetState($WPI_cmdx_Button, $GUI_DISABLE)
		GUICtrlSetState($WPI_cmdx_Exit_Button, $GUI_DISABLE)
		$LaunchedByWPI = 0
	Else
		GUICtrlSetColor($WPI_Process_Status_Content, $WPI_Process_Status_Content_Good)
		GUICtrlSetData($WPI_Process_Status_Content, $LanguageSpecificStrings[31])
		While BitAND(WinGetState('Windows Post-Install Wizard'), 4)
			WinSetState('Windows Post-Install Wizard', '', @SW_DISABLE)
		WEnd
		$LaunchedByWPI = 1
	EndIf
EndFunc

Func SendToWPI($File_Usage_Content, $CmdNumber)
	Local $Aux = GUICtrlRead($File_Usage_Content)
	If $Aux <> $USSF_Messages[1][4] Then
		RegWrite('HKCU\Software\WPI', 'USSF_cmd' & $CmdNumber, 'REG_SZ', $Aux)
	EndIf
EndFunc

Func ParseLanguage(ByRef $Lang)
	Local $BackupOldLang_8 = $Lang[8]
	Local $BackupOldLang_9 = $Lang[9]
	Local $BackupOldLang_14 = $Lang[14]
	Local $BackupOldLang_31 = $Lang[31]
	GUICtrlSetData($File_Path_Label, $Lang[2])
	GUICtrlSetData($File_Extension_Label, $Lang[3])
	GUICtrlSetData($File_Type_Label, $Lang[4])
	GUICtrlSetData($File_Usage_Label, $Lang[5])
	GUICtrlSetData($File_Notes_Label, $Lang[6])
	If GUICtrlRead($File_Path_Content) = $BackupOldLang_8 Then
		GUICtrlSetData($File_Path_Content, $Lang[8])
	EndIf
	If GUICtrlRead($File_Extension_Content) = $BackupOldLang_9 Then
		GUICtrlSetData($File_Extension_Content, $Lang[9])
		GUICtrlSetData($File_Type_Content, $Lang[9])
		GUICtrlSetData($File_Usage_Content, $Lang[9])
		GUICtrlSetData($File_Notes_Content, $Lang[9])
	EndIf
	If $ShowWPIFeatures Then
		GUICtrlSetData($WPI_Specific_Label, $Lang[10])
	EndIf
	GUICtrlSetData($Move_Button, $Lang[11])
	GUICtrlSetData($Quit_Button, $Lang[12])
	If $ShowWPIFeatures Then
		GUICtrlSetData($WPI_Process_Status_Label, $Lang[13])
		If GUICtrlRead($WPI_Process_Status_Content) = $BackupOldLang_14 Then
			GUICtrlSetData($WPI_Process_Status_Content, $Lang[14])
		ElseIf GUICtrlRead($WPI_Process_Status_Content) = $BackupOldLang_31 Then
			GUICtrlSetData($WPI_Process_Status_Content, $Lang[31])
		EndIf
	EndIf
	GUICtrlSetData($Error_Label, $Lang[15])
	If $ShowWPIFeatures Then
		GUICtrlSetData($WPI_cmd1_Button, $Lang[16])
		GUICtrlSetData($WPI_cmd2_Button, $Lang[17])
		GUICtrlSetData($WPI_cmd3_Button, $Lang[18])
		GUICtrlSetData($WPI_cmd4_Button, $Lang[19])
		GUICtrlSetData($WPI_cmd5_Button, $Lang[20])
		GUICtrlSetData($WPI_cmd6_Button, $Lang[21])
		GUICtrlSetData($WPI_cmd7_Button, $Lang[77])
		GUICtrlSetData($WPI_cmd8_Button, $Lang[78])
		GUICtrlSetData($WPI_cmd9_Button, $Lang[79])
		GUICtrlSetData($WPI_cmd10_Button, $Lang[80])
		GUICtrlSetData($WPI_cmdx_Button, $Lang[22])
		GUICtrlSetTip($WPI_cmd1_Button, $Lang[23])
		GUICtrlSetTip($WPI_cmd2_Button, $Lang[24])
		GUICtrlSetTip($WPI_cmd3_Button, $Lang[25])
		GUICtrlSetTip($WPI_cmd4_Button, $Lang[26])
		GUICtrlSetTip($WPI_cmd5_Button, $Lang[27])
		GUICtrlSetTip($WPI_cmd6_Button, $Lang[28])
		GUICtrlSetTip($WPI_cmd7_Button, $Lang[81])
		GUICtrlSetTip($WPI_cmd8_Button, $Lang[82])
		GUICtrlSetTip($WPI_cmd9_Button, $Lang[83])
		GUICtrlSetTip($WPI_cmd10_Button, $Lang[84])
	EndIf
	GUICtrlSetTip($File_Type_Button, $Lang[29])
	GUICtrlSetTip($File_Extension_Button, $Lang[29])
	GUICtrlSetTip($File_Usage_Button, $Lang[29])
	GUICtrlSetTip($File_Path_Button, $Lang[30])
	GUICtrlSetTip($Move_Button, $Lang[33])
	GUICtrlSetTip($Quit_Button, $Lang[32])
	If $ShowWPIFeatures Then
		GUICtrlSetData($WPI_cmd_Label, $Lang[34])
		GUICtrlSetData($WPI_cmdx_Label, $Lang[35])
		GUICtrlSetData($WPI_cmdx_Exit_Button, $Lang[36])
		GUICtrlSetData($WPI_cmd_Exit_Label, $Lang[37])
		GUICtrlSetData($WPI_cmdx_Exit_Label, $Lang[37])
		GUICtrlSetData($WPI_cmd1_Exit_Button, $Lang[38])
		GUICtrlSetData($WPI_cmd2_Exit_Button, $Lang[38])
		GUICtrlSetData($WPI_cmd3_Exit_Button, $Lang[38])
		GUICtrlSetData($WPI_cmd4_Exit_Button, $Lang[38])
		GUICtrlSetData($WPI_cmd5_Exit_Button, $Lang[38])
		GUICtrlSetData($WPI_cmd6_Exit_Button, $Lang[38])
		GUICtrlSetData($WPI_cmd7_Exit_Button, $Lang[38])
		GUICtrlSetData($WPI_cmd8_Exit_Button, $Lang[38])
		GUICtrlSetData($WPI_cmd9_Exit_Button, $Lang[38])
		GUICtrlSetData($WPI_cmd10_Exit_Button, $Lang[38])
		GUICtrlSetTip($WPI_cmd1_Exit_Button, $Lang[39])
		GUICtrlSetTip($WPI_cmd2_Exit_Button, $Lang[40])
		GUICtrlSetTip($WPI_cmd3_Exit_Button, $Lang[41])
		GUICtrlSetTip($WPI_cmd4_Exit_Button, $Lang[42])
		GUICtrlSetTip($WPI_cmd5_Exit_Button, $Lang[43])
		GUICtrlSetTip($WPI_cmd6_Exit_Button, $Lang[44])
		GUICtrlSetTip($WPI_cmd7_Exit_Button, $Lang[85])
		GUICtrlSetTip($WPI_cmd8_Exit_Button, $Lang[86])
		GUICtrlSetTip($WPI_cmd9_Exit_Button, $Lang[87])
		GUICtrlSetTip($WPI_cmd10_Exit_Button, $Lang[88])
	EndIf
	GUICtrlSetData($Language_Title, $LanguageSpecificStrings[45])
	GUICtrlSetTip($Language_Dropdown, $Lang[46])
	GUICtrlSetTip($Skin_Dropdown, $Lang[47])
	GUICtrlSetData($Skin_Title, $LanguageSpecificStrings[48])
	GUICtrlSetData($Settings_Label, $LanguageSpecificStrings[51])
EndFunc

Func SetNA()
	$USSF_Messages[3][4] = $USSF_Messages[1][4]
	$USSF_Messages[4][4] = $USSF_Messages[1][4]
	$USSF_Messages[5][3] = $USSF_Messages[1][4]
	$USSF_Messages[2][4] = $USSF_Messages[1][4]
	$USSF_Messages[7][4] = $USSF_Messages[1][4]
	$USSF_Messages[9][3] = $USSF_Messages[1][4]
	$USSF_Messages[10][3] = $USSF_Messages[1][4]
	$USSF_Messages[11][3] = $USSF_Messages[1][4]
	$USSF_Messages[12][3] = $USSF_Messages[1][4]
	$USSF_Messages[13][3] = $USSF_Messages[1][4]
	$USSF_Messages[14][3] = $USSF_Messages[1][4]
	$USSF_Messages[15][3] = $USSF_Messages[1][4]
	$USSF_Messages[16][4] = $USSF_Messages[1][4]
	$USSF_Errors[1][3] = $USSF_Messages[1][4]
	$USSF_Errors[2][3] = $USSF_Messages[1][4]
	$USSF_Errors[3][3] = $USSF_Messages[1][4]
	$USSF_Errors[4][1] = $USSF_Messages[1][4]
	$USSF_Errors[4][2] = $USSF_Messages[1][4]
	$USSF_Errors[4][3] = $USSF_Messages[1][4]
	$USSF_Errors[5][3] = $USSF_Messages[1][4]
	$USSF_Errors[6][3] = $USSF_Messages[1][4]
	$USSF_Errors[7][1] = $USSF_Messages[1][4]
	$USSF_Errors[7][2] = $USSF_Messages[1][4]
	$USSF_Errors[7][3] = $USSF_Messages[1][4]
	$USSF_Errors[8][3] = $USSF_Messages[1][4]
EndFunc

Func SetLanguage($LangCode = 'English')
	Select
		Case $LangCode = 'English'
			$LanguageSpecificStrings[1] = 'USSF detects most common installers, self-extracting archives and packages. It also detects .reg, .inf and .msi files. The program was coded by ZoSTeR of MSFN and updated by me (sadicq).'
			$LanguageSpecificStrings[2] = 'File'
			$LanguageSpecificStrings[3] = 'File Extension'
			$LanguageSpecificStrings[4] = 'File Type'
			$LanguageSpecificStrings[5] = 'Usage'
			$LanguageSpecificStrings[6] = 'Notes'
			$LanguageSpecificStrings[7] = 'Not selected'
			$LanguageSpecificStrings[8] = 'Work in progress ...'
			$LanguageSpecificStrings[9] = 'Loading ...'
			$LanguageSpecificStrings[10] = 'WPI Specific'
			$LanguageSpecificStrings[11] = 'Move'
			$LanguageSpecificStrings[12] = 'Quit'
			$LanguageSpecificStrings[13] = 'WPI Process'
			$LanguageSpecificStrings[14] = 'USSF was not started by WPI or WPI has a wrong title.'
			$LanguageSpecificStrings[15] = 'Error'
			$LanguageSpecificStrings[16] = 'cmd 1'
			$LanguageSpecificStrings[17] = 'cmd 2'
			$LanguageSpecificStrings[18] = 'cmd 3'
			$LanguageSpecificStrings[19] = 'cmd 4'
			$LanguageSpecificStrings[20] = 'cmd 5'
			$LanguageSpecificStrings[21] = 'cmd 6'
			$LanguageSpecificStrings[22] = 'Recommended: Send to the cmd that initiated USSF'
			$LanguageSpecificStrings[23] = 'Send the usage string to WPI cmd 1 input.'
			$LanguageSpecificStrings[24] = 'Send the usage string to WPI cmd 2 input.'
			$LanguageSpecificStrings[25] = 'Send the usage string to WPI cmd 3 input.'
			$LanguageSpecificStrings[26] = 'Send the usage string to WPI cmd 4 input.'
			$LanguageSpecificStrings[27] = 'Send the usage string to WPI cmd 5 input.'
			$LanguageSpecificStrings[28] = 'Send the usage string to WPI cmd 6 input.'
			$LanguageSpecificStrings[29] = 'Send this string to clipboard.'
			$LanguageSpecificStrings[30] = 'Browse for a file.'
			$LanguageSpecificStrings[31] = 'USSF was launched by WPI.'
			$LanguageSpecificStrings[32] = 'Exit USSF.'
			$LanguageSpecificStrings[33] = 'Click and hold down the mouse button to drag the window.'
			$LanguageSpecificStrings[34] = 'WPI cmds'
			$LanguageSpecificStrings[35] = 'Send to WPI'
			$LanguageSpecificStrings[36] = 'Recommended: Send to the cmd that initiated USSF and exit'
			$LanguageSpecificStrings[37] = '^ and exit'
			$LanguageSpecificStrings[38] = '^ exit'
			$LanguageSpecificStrings[39] = 'Send the usage string to WPI cmd 1 input and exit.'
			$LanguageSpecificStrings[40] = 'Send the usage string to WPI cmd 2 input and exit.'
			$LanguageSpecificStrings[41] = 'Send the usage string to WPI cmd 3 input and exit.'
			$LanguageSpecificStrings[42] = 'Send the usage string to WPI cmd 4 input and exit.'
			$LanguageSpecificStrings[43] = 'Send the usage string to WPI cmd 5 input and exit.'
			$LanguageSpecificStrings[44] = 'Send the usage string to WPI cmd 6 input and exit.'
			$LanguageSpecificStrings[45] = 'Language'
			$LanguageSpecificStrings[46] = 'Choose the language you want USSF to use.'
			$LanguageSpecificStrings[47] = 'Choose the skin file you want USSF to use.'
			$LanguageSpecificStrings[48] = 'Skin'
			$LanguageSpecificStrings[49] = 'Loading language ...'
			$LanguageSpecificStrings[50] = 'Redrawing skin ...'
			$LanguageSpecificStrings[51] = 'Settings'
			$LanguageSpecificStrings[52] = 'USSF Updater'
			$LanguageSpecificStrings[53] = 'Retrieving information ...'
			$LanguageSpecificStrings[54] = 'Information Received'
			$LanguageSpecificStrings[55] = 'Testing internet connection ...'
			$LanguageSpecificStrings[56] = 'Not connected to the internet'
			$LanguageSpecificStrings[57] = 'Connecting to download server ...'
			$LanguageSpecificStrings[58] = 'Could not contact the download server'
			$LanguageSpecificStrings[59] = 'Changelog'
			$LanguageSpecificStrings[60] = 'Your version'
			$LanguageSpecificStrings[61] = 'Latest version'
			$LanguageSpecificStrings[62] = 'New major version available'
			$LanguageSpecificStrings[63] = 'New minor version available'
			$LanguageSpecificStrings[64] = 'New build version available'
			$LanguageSpecificStrings[65] = 'New bugfix version available'
			$LanguageSpecificStrings[66] = 'Your version is newer than the latest one'
			$LanguageSpecificStrings[67] = 'Your version is up to date'
			$LanguageSpecificStrings[68] = 'The version numbering is not correct'
			$LanguageSpecificStrings[69] = 'Update to the latest version'
			$LanguageSpecificStrings[70] = 'Idling around ...'
			$LanguageSpecificStrings[71] = 'Downloading ...'
			$LanguageSpecificStrings[72] = 'Downloaded'
			$LanguageSpecificStrings[73] = 'The update file was not found on server'
			$LanguageSpecificStrings[74] = 'Please wait a few seconds while ussf is being updated ...'
			$LanguageSpecificStrings[75] = 'Exit USSF Updater'
			$LanguageSpecificStrings[76] = 'Update'
			$LanguageSpecificStrings[77] = 'cmd 7'
			$LanguageSpecificStrings[78] = 'cmd 8'
			$LanguageSpecificStrings[79] = 'cmd 9'
			$LanguageSpecificStrings[80] = 'cmd 10'
			$LanguageSpecificStrings[81] = 'Send the usage string to WPI cmd 7 input.'
			$LanguageSpecificStrings[82] = 'Send the usage string to WPI cmd 8 input.'
			$LanguageSpecificStrings[83] = 'Send the usage string to WPI cmd 9 input.'
			$LanguageSpecificStrings[84] = 'Send the usage string to WPI cmd 10 input.'
			$LanguageSpecificStrings[85] = 'Send the usage string to WPI cmd 7 input and exit.'
			$LanguageSpecificStrings[86] = 'Send the usage string to WPI cmd 8 input and exit.'
			$LanguageSpecificStrings[87] = 'Send the usage string to WPI cmd 9 input and exit.'
			$LanguageSpecificStrings[88] = 'Send the usage string to WPI cmd 10 input and exit.'
	EndSelect
EndFunc

Func SetMessageAndErrorContent($FileName, $FileExtension, $Lang = 'English')
	Select
		Case $Lang = 'English'
			$USSF_Messages[1][1] = '.inf'
			$USSF_Messages[1][2] = 'Information or Setup File'
			$USSF_Messages[1][3] = 'rundll32.exe setupapi,InstallHinfSection DefaultInstall 132 ' & $FileName
			$USSF_Messages[1][4] = 'N/A'

			$USSF_Messages[2][1] = '.reg'
			$USSF_Messages[2][2] = 'Registry Data File'
			$USSF_Messages[2][3] = 'regedit.exe /s "' & $FileName & '"'

			$USSF_Messages[3][1] = '.exe'
			$USSF_Messages[3][2] = 'NSIS package'
			$USSF_Messages[3][3] = '"' & $FileName & '" /S'

			$USSF_Messages[4][1] = '.exe'
			$USSF_Messages[4][2] = 'Inno Setup package'
			$USSF_Messages[4][3] =  '"' & $FileName & '" /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'

			$USSF_Messages[5][1] = '.exe'
			$USSF_Messages[5][2] = 'Installshield AFW package'
			$USSF_Messages[5][4] = 'Unpack the monolithic setup file with UniExtract or other archive extractor.' & @CRLF & 'The unpack archive should be either .CAB based or .MSI based.' & @CRLF & 'Next, only for .CAB based:' & @CRLF & '    Record an installation with this command:' & $FileName & ' /r /f1"X:\setup.iss"' & @CRLF & '    Now you can perform a silent installation with the iss file:' & $FileName & ' /s /f1"X:\setup.iss"' & @CRLF & 'Next, only for .MSI based:' & @CRLF & '    msiexec.exe /i setup.msi /qb'

			$USSF_Messages[6][1] = '.exe'
			$USSF_Messages[6][2] = 'InstallShield 2003 package'
			$USSF_Messages[6][3] = '"' & $FileName & '" /s /v"/qb"'
			$USSF_Messages[6][4] = 'You can also try to retrieve the .MSI file from the temp folder during installation, ' & @CRLF & 'then install with:' & @CRLF & 'msiexec.exe /i setup.msi /qb'

			$USSF_Messages[7][1] = '.exe'
			$USSF_Messages[7][2] = 'Wise Installer package'
			$USSF_Messages[7][3] = '"' & $FileName & '" /s'

			$USSF_Messages[8][1] = '.exe'
			$USSF_Messages[8][2] = 'Self-Extracting RAR archive'
			$USSF_Messages[8][3] = '"' & $FileName & '" /s'
			$USSF_Messages[8][4] = 'The RAR comment contains the setup script.'

			$USSF_Messages[9][1] = '.exe'
			$USSF_Messages[9][2] = 'Self-Extracting Microsoft CAB archive'
			$USSF_Messages[9][4] = 'Unpack the archive with UniExtract or other archive extractor.'

			$USSF_Messages[10][1] = '.exe'
			$USSF_Messages[10][2] = 'Self-Extracting ZIP archive'
			$USSF_Messages[10][4] = 'Unpack the archive with UniExtract or other archive extractor.'

			$USSF_Messages[11][1] = '.exe'
			$USSF_Messages[11][2] = '7-Zip Installer package'
			$USSF_Messages[11][4] = 'Unpack the archive with UniExtract or other archive extractor.'

			$USSF_Messages[12][1] = '.exe'
			$USSF_Messages[12][2] = 'Unknown 7-Zip archive'
			$USSF_Messages[12][4] = 'Unpack the archive with UniExtract or other archive extractor.'

			$USSF_Messages[13][1] = '.exe'
			$USSF_Messages[13][2] = 'Unknown Zip archive'
			$USSF_Messages[13][4] = 'Unpack the archive with UniExtract or other archive extractor.'

			$USSF_Messages[14][1] = '.exe'
			$USSF_Messages[14][2] = 'Self-Extracting WinZip archive'
			$USSF_Messages[14][4] = 'Unpack the archive with UniExtract or other archive extractor.'

			$USSF_Messages[15][1] = '.exe'
			$USSF_Messages[15][2] = 'UPX Packed executable'
			$USSF_Messages[15][4] = 'Unpack the executable using upx.exe -d "' & $FileName & '"'

			$USSF_Messages[16][1] = '.msi'
			$USSF_Messages[16][2] = 'Windows Installer File'
			$USSF_Messages[16][3] = 'msiexec.exe /i "' & $FileName & '" /qb'
			
			$USSF_Errors[1][1] = '.exe'
			$USSF_Errors[1][2] = 'Damaged executable file.'
			$USSF_Errors[1][4] = 'It is highly recommended that you scan the file with an antivirus program.'

			$USSF_Errors[2][1] = '.msi'
			$USSF_Errors[2][2] = 'Damaged Windows Installer file.'
			$USSF_Errors[2][4] = 'It is highly recommended that you scan the file with an antivirus program.'

			$USSF_Errors[3][1] = '.reg'
			$USSF_Errors[3][2] = 'Damaged Registry Data file.'
			$USSF_Errors[3][4] = 'This feature is still experimental.' & @CRLF & 'If you think you encountered a bug, mail me at sadicq@gmail.com.'

			$USSF_Errors[4][4] = 'You did not select a file yet or the file you provided does not exist.' & @CRLF & 'You may do that by clicking the ">" button in the upper right.'

			$USSF_Errors[5][1] = '.exe'
			$USSF_Errors[5][2] = 'Undetected PE file'
			$USSF_Errors[5][4] = 'USSF detected that the file you selected is a valid PE file.' & @CRLF & 'However, it couldn''t identify its type.' & @CRLF & 'The header returned by PEiD was ''%header%'''

			$USSF_Errors[6][1] = '.' & $FileExtension
			$USSF_Errors[6][2] = 'Unsupported file type'
			$USSF_Errors[6][4] = 'The selected file is not supported by USSF.' & @CRLF & 'USSF only detects .exe, .msi, .reg and .inf filetypes.'

			$USSF_Errors[7][4] = 'The selected file could not be opened for reading.'

			$USSF_Errors[8][1] = '.exe'
			$USSF_Errors[8][2] = 'PEiD conflict'
			$USSF_Errors[8][4] = 'The program you selected is a valid PE file but PEiD doesn''t recognize it as a valid PE file.' & @CRLF & 'It is recommended to scan the file for viruses.'
	EndSelect

	SetNA()
EndFunc

Func RedrawSkin()
	GUICtrlSetGraphic($General_Container, $GUI_GR_COLOR, $General_Container_Color)
	GUICtrlSetGraphic($General_Container, $GUI_GR_RECT, 0, 0, 590, 240)
	GUICtrlSetGraphic($Error_Graphic, $GUI_GR_COLOR, $Error_Graphic_Color)
	GUICtrlSetGraphic($Error_Graphic, $GUI_GR_RECT, 0, 0, 50, 105)
	If $ShowWPIFeatures Then
		GUICtrlSetGraphic($WPI_Line_Graphic, $GUI_GR_COLOR, $WPI_Line_Graphic_Color)
		GUICtrlSetGraphic($WPI_Line_Graphic, $GUI_GR_LINE, 100, 0)
		GUICtrlSetGraphic($WPI_Line_Graphic, $GUI_GR_MOVE, 170, 0)
		GUICtrlSetGraphic($WPI_Line_Graphic, $GUI_GR_LINE, 590, 0)
		GUICtrlSetGraphic($WPI_Line_Graphic, $GUI_GR_LINE, 590, 130)
		GUICtrlSetGraphic($WPI_Line_Graphic, $GUI_GR_LINE, 0, 130)
		GUICtrlSetGraphic($WPI_Line_Graphic, $GUI_GR_LINE, 0, 0)
	EndIf
	GUICtrlSetGraphic($Settings_Container, $GUI_GR_COLOR, $Settings_Container_Color)
	GUICtrlSetGraphic($Settings_Container, $GUI_GR_LINE, 590, 0)
	GUICtrlSetGraphic($Settings_Container, $GUI_GR_LINE, 590, 30)
	GUICtrlSetGraphic($Settings_Container, $GUI_GR_LINE, 0, 30)
	GUICtrlSetGraphic($Settings_Container, $GUI_GR_LINE, 0, 0)
	GUICtrlSetColor($File_Extension_Content, $File_Extension_Content_Color)
	GUICtrlSetColor($File_Type_Content, $File_Type_Content_Color)
	GUICtrlSetColor($File_Usage_Content, $File_Usage_Content_Color)
	GUICtrlSetColor($File_Notes_Content, $File_Notes_Content_Color)
	GUICtrlSetColor($Error_Label, $Error_Label_Color)
	If $ShowWPIFeatures Then
		GUICtrlSetColor($WPI_Specific_Label, $WPI_Specific_Label_Color)
		GUICtrlSetColor($WPI_cmd1_Button, $WPI_cmd1_Button_Color)
		GUICtrlSetColor($WPI_cmd2_Button, $WPI_cmd2_Button_Color)
		GUICtrlSetColor($WPI_cmd3_Button, $WPI_cmd3_Button_Color)
		GUICtrlSetColor($WPI_cmd4_Button, $WPI_cmd4_Button_Color)
		GUICtrlSetColor($WPI_cmd5_Button, $WPI_cmd5_Button_Color)
		GUICtrlSetColor($WPI_cmd6_Button, $WPI_cmd6_Button_Color)
		GUICtrlSetColor($WPI_cmd7_Button, $WPI_cmd7_Button_Color)
		GUICtrlSetColor($WPI_cmd8_Button, $WPI_cmd8_Button_Color)
		GUICtrlSetColor($WPI_cmd9_Button, $WPI_cmd9_Button_Color)
		GUICtrlSetColor($WPI_cmd10_Button, $WPI_cmd10_Button_Color)
		GUICtrlSetColor($WPI_cmd1_Exit_Button, $WPI_cmd1_Exit_Button_Color)
		GUICtrlSetColor($WPI_cmd2_Exit_Button, $WPI_cmd2_Exit_Button_Color)
		GUICtrlSetColor($WPI_cmd3_Exit_Button, $WPI_cmd3_Exit_Button_Color)
		GUICtrlSetColor($WPI_cmd4_Exit_Button, $WPI_cmd4_Exit_Button_Color)
		GUICtrlSetColor($WPI_cmd5_Exit_Button, $WPI_cmd5_Exit_Button_Color)
		GUICtrlSetColor($WPI_cmd6_Exit_Button, $WPI_cmd6_Exit_Button_Color)
		GUICtrlSetColor($WPI_cmd7_Exit_Button, $WPI_cmd7_Exit_Button_Color)
		GUICtrlSetColor($WPI_cmd8_Exit_Button, $WPI_cmd8_Exit_Button_Color)
		GUICtrlSetColor($WPI_cmd9_Exit_Button, $WPI_cmd9_Exit_Button_Color)
		GUICtrlSetColor($WPI_cmd10_Exit_Button, $WPI_cmd10_Exit_Button_Color)
		GUICtrlSetColor(Eval('WPI_cmd' & $CmdNumber & '_Button'), $CmdNumber_Good)
		GUICtrlSetColor(Eval('WPI_cmd' & $CmdNumber & '_Exit_Button'), $CmdNumber_Exit_Good)
		GUICtrlSetColor($WPI_cmdx_Button, $WPI_cmdx_Button_Color)
		GUICtrlSetColor($WPI_cmdx_Exit_Button, $WPI_cmdx_Exit_Button_Color)
	EndIf
	GUICtrlSetColor($Language_Title, $Language_Title_Color)
	GUICtrlSetColor($Skin_Title, $Skin_Title_Color)
	GUICtrlSetBkColor($Title, $Title_Color_Bk)
	GUICtrlSetBkColor($File_Usage_Content, $File_Usage_Content_Color_Bk)
	If $ShowWPIFeatures Then
		GUICtrlSetBkColor($WPI_Process_Status_Content_Frame, $WPI_Process_Status_Content_Frame_Color_Bk)
	EndIf
	GUISetBkColor($BKColor)
EndFunc

Func GetSkins()
	Local $Aux, $SkinFound = False
	FileChangeDir(@ScriptDir)
	Local $SearchHandle = FileFindFirstFile('*.skn')
	If $SearchHandle <> -1 Then
		While 1
			$Aux = FileFindNextFile($SearchHandle)
			If @error Then
				ExitLoop
			EndIf
			$SkinFound = True
			GUICtrlSetData($Skin_Dropdown, StringTrimRight($Aux, 4))
		WEnd
	EndIf
	If Not $SkinFound Then
		GUICtrlSetState($Skin_Dropdown, $GUI_DISABLE)
	EndIf
	FileClose($SearchHandle)
EndFunc

Func GetSkinVars($SkinName)
	If FileExists(@ScriptDir & '\' & $SkinName & '.skn') Then
		Local $FileHandle = FileOpen(@ScriptDir & '\' & $SkinName & '.skn', 0)
		If $FileHandle = -1 Then
			If IsDeclared($Error_Graphic_Over) Then
				ParseError(7)
			EndIf
			FileClose($FileHandle)
		Else
			Local $Line
			While 1
				$Line = FileReadLine($FileHandle)
				If @error = -1 Then
					ExitLoop
				EndIf
				Assign(StringStripWS(StringMid($Line, 2, StringInStr($Line, '=') - 2), 2), StringStripWS(StringTrimLeft($Line, StringInStr($Line, '=')), 1))
			Wend
			FileClose($FileHandle)
		EndIf
		Return True
	Else
		Return False
	EndIf
EndFunc

Func GetLatestVersionNumber()
	GUISetState(@SW_HIDE)
	Local $UpdateGUI = GUICreate('', 600, 230, -1, -1, $WS_BORDER + $WS_POPUP, -1, $MainGUI)
	GUISwitch($UpdateGUI)
	
	Local $Updater_Container = GUICtrlCreateGraphic(5, 5, 0, 0)
	Local $Updater_Title = GUICtrlCreateLabel($LanguageSpecificStrings[52], 10, 12, 280, 20, $SS_CENTER)
	Local $Updater_Title_Frame = GUICtrlCreateLabel('', 10, 10, 280, 20, $SS_BLACKFRAME)
	Local $Updater_Retrieving_Information_Label_Frame = GUICtrlCreateLabel('', 10, 40, 280, 25, $SS_BLACKFRAME)
	Local $Updater_Retrieving_Information_Label = GUICtrlCreateLabel($LanguageSpecificStrings[55], 20, 42, 260, 15, $SS_CENTER)
	Local $Updater_Progress_Container = GUICtrlCreateLabel('', 48, 57, 204, 5, $SS_BLACKFRAME)
	Local $Updater_Progress_Graphic = GUICtrlCreateGraphic(50, 59, 0, 0)
	Local $Updater_Changelog_Title = GUICtrlCreateLabel($LanguageSpecificStrings[59], 310, 12, 280, 20, $SS_CENTER)
	Local $Updater_Changelog_Title_Frame = GUICtrlCreateLabel('', 310, 10, 280, 20, $SS_BLACKFRAME)
	Local $Updater_Changelog_Edit = GUICtrlCreateEdit('', 310, 40, 280, 180, $ES_MULTILINE + $ES_READONLY + $WS_TABSTOP + $ES_WANTRETURN + $WS_VSCROLL)
	Local $Updater_Status = GUICtrlCreateLabel($LanguageSpecificStrings[9], 10, 72, 280, 20, $SS_CENTER)
	Local $Updater_Status_Frame = GUICtrlCreateLabel('', 10, 70, 280, 20, $SS_BLACKFRAME)
	Local $YourVersion_Label = GUICtrlCreateLabel($LanguageSpecificStrings[60], 10, 97, 175, 20, $SS_CENTER)
	Local $YourVersion_Label_Frame = GUICtrlCreateLabel('', 10, 95, 175, 20, $SS_BLACKFRAME)
	Local $YourVersion_Content = GUICtrlCreateLabel($ProgramMajorVersion & '.' & $ProgramMinorVersion & '.' & $ProgramBuildVersion & '.' & $ProgramBugfixVersion, 190, 97, 100, 20, $SS_CENTER)
	Local $YourVersion_Content_Frame = GUICtrlCreateLabel('', 190, 95, 100, 20, $SS_BLACKFRAME)
	Local $LatestVersion_Label = GUICtrlCreateLabel($LanguageSpecificStrings[61], 10, 122, 175, 20, $SS_CENTER)
	Local $LatestVersion_Label_Frame = GUICtrlCreateLabel('', 10, 120, 175, 20, $SS_BLACKFRAME)
	Local $LatestVersion_Content = GUICtrlCreateLabel($LanguageSpecificStrings[9], 190, 122, 100, 20, $SS_CENTER)
	Local $LatestVersion_Content_Frame = GUICtrlCreateLabel('', 190, 120, 100, 20, $SS_BLACKFRAME)
	$UpdateButton = GUICtrlCreateLabel($LanguageSpecificStrings[69], 10, 147, 280, 20, $SS_CENTER)
	Local $UpdateButton_Frame = GUICtrlCreateLabel('', 10, 145, 280, 20, $SS_BLACKFRAME)
	Local $Updater_Downloader_Label_Frame = GUICtrlCreateLabel('', 10, 170, 280, 25, $SS_BLACKFRAME)
	$Updater_Downloader_Information_Label = GUICtrlCreateLabel($LanguageSpecificStrings[70], 20, 172, 260, 15, $SS_CENTER)
	Local $Updater_Downloader_Progress_Container = GUICtrlCreateLabel('', 48, 187, 204, 5, $SS_BLACKFRAME)
	$Updater_Downloader_Progress_Graphic = GUICtrlCreateGraphic(50, 189, 0, 0)
	Local $Updater_Exit = GUICtrlCreateLabel($LanguageSpecificStrings[75], 10, 202, 280, 20, $SS_CENTER)
	Local $Updater_Exit_Frame = GUICtrlCreateLabel('', 10, 200, 280, 20, $SS_BLACKFRAME)

	GUICtrlSetFont($Updater_Title, 10, 1000, -1, 'Arial')
	GUICtrlSetFont($Updater_Retrieving_Information_Label, 8, 400, -1, 'Arial')
	GUICtrlSetFont($Updater_Changelog_Title, 10, 1000, -1, 'Arial')
	GUICtrlSetFont($Updater_Status, 10, 1000, -1, 'Arial')
	GUICtrlSetFont($YourVersion_Label, 10, 1000, -1, 'Arial')
	GUICtrlSetFont($LatestVersion_Label, 10, 1000, -1, 'Arial')
	GUICtrlSetFont($YourVersion_Content, 10, 1000, -1, 'Arial')
	GUICtrlSetFont($LatestVersion_Content, 10, 1000, -1, 'Arial')
	GUICtrlSetFont($UpdateButton, 10, 1000, -1, 'Arial')
	GUICtrlSetFont($Updater_Downloader_Information_Label, 8, 400, -1, 'Arial')
	GUICtrlSetFont($Updater_Exit, 10, 1000, -1, 'Arial')

	GUICtrlSetGraphic($Updater_Container, $GUI_GR_COLOR, $Updater_Container_Color)
	GUICtrlSetGraphic($Updater_Container, $GUI_GR_RECT, 0, 0, 290, 220)
	GUICtrlSetGraphic($Updater_Container, $GUI_GR_RECT, 300, 0, 290, 220)
	GUICtrlSetGraphic($Updater_Downloader_Progress_Graphic, $GUI_GR_MOVE, 0, 0)

	GUICtrlSetCursor($UpdateButton, 0)
	GUICtrlSetCursor($Updater_Exit, 0)

	GUICtrlSetColor($Updater_Changelog_Edit, $Updater_Changelog_Edit_Color)
	GUICtrlSetColor($UpdateButton, $UpdateButton_Color)

	GUICtrlSetState($UpdateButton, $GUI_DISABLE)

	GUICtrlSetOnEvent($UpdateButton, 'Update')
	GUICtrlSetOnEvent($Updater_Exit, 'ExitUpdater')

	GUISetBkColor($BKColor)

	GUISetState()

	Opt('GUIOnEventMode', 1)

	If Not PingHost('www.google.com') And Not $AbortAutoUpdate Then
		GUICtrlSetData($Updater_Retrieving_Information_Label, $LanguageSpecificStrings[56])
		GUICtrlSetColor($Updater_Retrieving_Information_Label, $Updater_Retrieving_Information_Label_Error)
	ElseIf Not $AbortAutoUpdate Then
		GUICtrlSetData($Updater_Retrieving_Information_Label, $LanguageSpecificStrings[57])
		If Not PingHost($Update_SiteName) And Not $AbortAutoUpdate Then
			GUICtrlSetData($Updater_Retrieving_Information_Label, $LanguageSpecificStrings[58])
			GUICtrlSetColor($Updater_Retrieving_Information_Label, $Updater_Retrieving_Information_Label_Error)
		ElseIf Not $AbortAutoUpdate Then
			GUICtrlSetData($Updater_Retrieving_Information_Label, $LanguageSpecificStrings[53])

			Local $InfoFileSize = InetGetSize($Update_Url & '/' & $UpdateInfoFile)
			InetGet($Update_Url & '/' & $UpdateInfoFile, @TempDir & '\' & $UpdateLocalInfoFile, 1, 1)

			While @InetGetActive
				GUICtrlSetGraphic($Updater_Progress_Graphic, $GUI_GR_LINE, Round(200 * (@InetGetBytesRead / $InfoFileSize)), 0)
				GUICtrlSetGraphic($Updater_Progress_Graphic, $GUI_GR_REFRESH)
				Sleep(500)
			Wend

			GUICtrlSetGraphic($Updater_Progress_Graphic, $GUI_GR_LINE, 200, 0)
			GUICtrlSetGraphic($Updater_Progress_Graphic, $GUI_GR_REFRESH)

			GUICtrlSetData($Updater_Retrieving_Information_Label, $LanguageSpecificStrings[54])

			Local $LatestVersion = IniRead(@TempDir & '\' & $UpdateLocalInfoFile, 'USSF', 'Version', '0.0.0.0')
			Local $ChangelogText = StringReplace(IniRead(@TempDir & '\' & $UpdateLocalInfoFile, 'USSF', 'Changelog', ''), '{EOL}', @CRLF, 0, 0)
			FileDelete(@TempDir & '\' & $UpdateLocalInfoFile)

			GUICtrlSetData($Updater_Changelog_Edit, $ChangelogText)

			Local $VersionArray = StringSplit($LatestVersion, '.')
			Select
				Case Int($VersionArray[1] & $VersionArray[2] & $VersionArray[3] & $VersionArray[4]) < Int($ProgramMajorVersion & $ProgramMinorVersion & $ProgramBuildVersion & $ProgramBugfixVersion)
					GUICtrlSetColor($Updater_Status, $Updater_Status_Ok_Color)
					GUICtrlSetData($Updater_Status, $LanguageSpecificStrings[66])
					GUICtrlSetColor($LatestVersion_Content, $Updater_Status_Ok_Color)
					GUICtrlSetData($LatestVersion_Content, $LatestVersion)
					GUICtrlSetState($UpdateButton, $GUI_ENABLE)
					While Not $AbortAutoUpdate
						Sleep(50)
					WEnd
				Case Int($VersionArray[1] & $VersionArray[2] & $VersionArray[3] & $VersionArray[4]) = Int($ProgramMajorVersion & $ProgramMinorVersion & $ProgramBuildVersion & $ProgramBugfixVersion)
					GUICtrlSetColor($Updater_Status, $Updater_Status_Ok_Color)
					GUICtrlSetData($Updater_Status, $LanguageSpecificStrings[67])
					GUICtrlSetColor($LatestVersion_Content, $Updater_Status_Ok_Color)
					GUICtrlSetData($LatestVersion_Content, $LatestVersion)
					GUICtrlSetState($UpdateButton, $GUI_ENABLE)
					While Not $AbortAutoUpdate
						Sleep(50)
					WEnd
				Case Int($VersionArray[1]) > $ProgramMajorVersion
					GUICtrlSetColor($Updater_Status, $Updater_Status_New_Color)
					GUICtrlSetData($Updater_Status, $LanguageSpecificStrings[62])
					GUICtrlSetColor($LatestVersion_Content, $Updater_Status_New_Color)
					GUICtrlSetData($LatestVersion_Content, $LatestVersion)
					AutoUpdate()
				Case Int($VersionArray[2]) > $ProgramMinorVersion
					GUICtrlSetColor($Updater_Status, $Updater_Status_New_Color)
					GUICtrlSetData($Updater_Status, $LanguageSpecificStrings[63])
					GUICtrlSetColor($LatestVersion_Content, $Updater_Status_New_Color)
					GUICtrlSetData($LatestVersion_Content, $LatestVersion)
					AutoUpdate()
				Case Int($VersionArray[3]) > $ProgramBuildVersion
					GUICtrlSetColor($Updater_Status, $Updater_Status_New_Color)
					GUICtrlSetData($Updater_Status, $LanguageSpecificStrings[64])
					GUICtrlSetColor($LatestVersion_Content, $Updater_Status_New_Color)
					GUICtrlSetData($LatestVersion_Content, $LatestVersion)
					AutoUpdate()
				Case Int($VersionArray[4]) > $ProgramBugfixVersion
					GUICtrlSetColor($Updater_Status, $Updater_Status_New_Color)
					GUICtrlSetData($Updater_Status, $LanguageSpecificStrings[65])
					GUICtrlSetColor($LatestVersion_Content, $Updater_Status_New_Color)
					GUICtrlSetData($LatestVersion_Content, $LatestVersion)
					AutoUpdate()
				Case Else
					GUICtrlSetColor($Updater_Status, $Updater_Status_New_Color)
					GUICtrlSetData($Updater_Status, $LanguageSpecificStrings[68])
					GUICtrlSetColor($LatestVersion_Content, $Updater_Status_New_Color)
					GUICtrlSetData($LatestVersion_Content, $LatestVersion)
					AutoUpdate()
			EndSelect
		EndIf
	EndIf

	Opt('GUIOnEventMode', 0)
	GUISwitch($MainGUI)
	GUIDelete($UpdateGUI)
	GUISetState(@SW_SHOW)
EndFunc

Func PingHost($Host)
	For $Aux = 1 To 5
		Ping($Host, 2000)
		If Not @error Then
			Return 1
		EndIf
	Next
	Return 0
EndFunc

Func AutoUpdate()
	GUICtrlSetState($UpdateButton, $GUI_ENABLE)
	For $Aux = 60 To 0 Step -1
		If $AbortAutoUpdate Then
			Return 0
		EndIf
		If $Aux Then
			GUICtrlSetData($UpdateButton, $LanguageSpecificStrings[69] & ' (' & $Aux & ')')
			Sleep(1000)
		Else
			GUICtrlSetData($UpdateButton, $LanguageSpecificStrings[69])
		EndIf
	Next
	GUICtrlSetState($UpdateButton, $GUI_DISABLE)
	Update()
EndFunc

Func Update()
	$AbortAutoUpdate = True
	GUICtrlSetData($UpdateButton, $LanguageSpecificStrings[69])
	GUICtrlSetState($UpdateButton, $GUI_DISABLE)
	GUICtrlSetData($Updater_Downloader_Information_Label, $LanguageSpecificStrings[71])
	Local $DownloadFileSize = InetGetSize($Update_Url & '/' & $DonwloadFile)
	If $DownloadFileSize = 0 Then
		GUICtrlSetData($Updater_Downloader_Information_Label, $LanguageSpecificStrings[73])
	Else
		InetGet($Update_Url & '/' & $DonwloadFile, @TempDir & '\' & $DonwloadLocalFile, 1, 1)
		While @InetGetActive
			GUICtrlSetGraphic($Updater_Downloader_Progress_Graphic, $GUI_GR_LINE, Round(200 * (@InetGetBytesRead / $DownloadFileSize)), 0)
			GUICtrlSetGraphic($Updater_Downloader_Progress_Graphic, $GUI_GR_REFRESH)
			Sleep(500)
		Wend
		GUICtrlSetGraphic($Updater_Downloader_Progress_Graphic, $GUI_GR_LINE, 200, 0)
		GUICtrlSetGraphic($Updater_Downloader_Progress_Graphic, $GUI_GR_REFRESH)
		GUICtrlSetData($Updater_Downloader_Information_Label, $LanguageSpecificStrings[72])
		GUISetState(@SW_HIDE)
		GUISetState(@SW_HIDE, $MainGUI)
		SplashTextOn('', $LanguageSpecificStrings[74], 400, 18, -1, -1, 1, 'Arial', 10, 800)
		Sleep(2500)
		SplashOff()
		_Overwrite()
	EndIf
EndFunc

Func _Overwrite()
    Local $FileContent
    FileDelete(@TempDir & "\suicide.cmd")
    $FileContent = ':loop' & @CRLF & 'move /y "' & @TempDir & '\' & $DonwloadLocalFile & '" "' & @ScriptFullPath & '"' & @CRLF & 'if exist "' & @TempDir & '\' & $DonwloadLocalFile & '" goto loop' & @CRLF & '"' & @ScriptFullPath & '"' & @CRLF & 'del ' & @TempDir & '\suicide.cmd'
    FileWrite(@TempDir & "\suicide.cmd", $FileContent)
    Run(@TempDir & '\suicide.cmd', @TempDir, @SW_HIDE)
	Exit
EndFunc

Func ExitUpdater()
	$AbortAutoUpdate = True
EndFunc