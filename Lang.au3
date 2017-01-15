Func SetLanguage($LangCode = 'English')
	Select
;~ 		edit all strings below this line; make sure you don't mess the numbers
		Case $LangCode = 'English' ;this will be your language. Ex: French
			$LanguageSpecificStrings[1] = 'USSF erkennt die meisten bekannten Installer, selbstextrahierende Archive und Pakete. Es erkennt auch .reg, .inf and .msi Dateien. Das Programm wurde von ZoSTeR von MSFN programmiert und von mir (sadicq) aktualisiert.'
			$LanguageSpecificStrings[2] = 'Datei'
			$LanguageSpecificStrings[3] = 'Dateierweiterung'
			$LanguageSpecificStrings[4] = 'Dateityp'
			$LanguageSpecificStrings[5] = 'Verwendung'
			$LanguageSpecificStrings[6] = 'Bemerkungen'
			$LanguageSpecificStrings[7] = 'Nicht ausgew�hlt'
			$LanguageSpecificStrings[8] = 'Prozess l�uft ...'
			$LanguageSpecificStrings[9] = 'Lade ...'
			$LanguageSpecificStrings[10] = 'WPI spezifisch'
			$LanguageSpecificStrings[11] = 'Verschieben'
			$LanguageSpecificStrings[12] = 'Beenden'
			$LanguageSpecificStrings[13] = 'WPI Prozess'
			$LanguageSpecificStrings[14] = 'USSF wurde nicht vom WPI gestartet oder das WPI hat eine falsche Bezeichnung.'
			$LanguageSpecificStrings[15] = 'Fehler'
			$LanguageSpecificStrings[16] = 'WPI cmd 1'
			$LanguageSpecificStrings[17] = 'WPI cmd 2'
			$LanguageSpecificStrings[18] = 'WPI cmd 3'
			$LanguageSpecificStrings[19] = 'WPI cmd 4'
			$LanguageSpecificStrings[20] = 'WPI cmd 5'
			$LanguageSpecificStrings[21] = 'WPI cmd 6'
			$LanguageSpecificStrings[22] = 'Empfohlen: An das cmd senden, welches das USSF ausgel�st hat'
			$LanguageSpecificStrings[23] = 'Sende die Zeichenfolge zur WPI cmd 1 Eingabe.'
			$LanguageSpecificStrings[24] = 'Sende die Zeichenfolge zur WPI cmd 2 Eingabe.'
			$LanguageSpecificStrings[25] = 'Sende die Zeichenfolge zur WPI cmd 3 Eingabe.'
			$LanguageSpecificStrings[26] = 'Sende die Zeichenfolge zur WPI cmd 4 Eingabe.'
			$LanguageSpecificStrings[27] = 'Sende die Zeichenfolge zur WPI cmd 5 Eingabe.'
			$LanguageSpecificStrings[28] = 'Sende die Zeichenfolge zur WPI cmd 6 Eingabe.'
			$LanguageSpecificStrings[29] = 'Sende diese Zeichenkette an die Zwischenablage.'
			$LanguageSpecificStrings[30] = 'Nach einer Datei suchen.'
			$LanguageSpecificStrings[31] = 'USSF wurde durch das WPI gestartet.'
			$LanguageSpecificStrings[32] = 'USSF verlassen.'
			$LanguageSpecificStrings[33] = 'Klicke und halte die Maustaste gedr�ckt um das Fenster zu ziehen.'
			$LanguageSpecificStrings[34] = 'WPI cmds'
			$LanguageSpecificStrings[35] = 'An WPI senden'
			$LanguageSpecificStrings[36] = 'Empfohlen: An das cmd senden, welches das USSF ausgel�st hat und das Programm verlassen'
			$LanguageSpecificStrings[37] = '^ und verlassen'
			$LanguageSpecificStrings[38] = '^ verlassen'
			$LanguageSpecificStrings[39] = 'Sende die Zeichenfolge zur WPI cmd 1 Eingabe und verlasse das Programm.'
			$LanguageSpecificStrings[40] = 'Sende die Zeichenfolge zur WPI cmd 2 Eingabe und verlasse das Programm.'
			$LanguageSpecificStrings[41] = 'Sende die Zeichenfolge zur WPI cmd 3 Eingabe und verlasse das Programm.'
			$LanguageSpecificStrings[42] = 'Sende die Zeichenfolge zur WPI cmd 4 Eingabe und verlasse das Programm.'
			$LanguageSpecificStrings[43] = 'Sende die Zeichenfolge zur WPI cmd 5 Eingabe und verlasse das Programm.'
			$LanguageSpecificStrings[44] = 'Sende die Zeichenfolge zur WPI cmd 6 Eingabe und verlasse das Programm.'
			$LanguageSpecificStrings[45] = 'Sprache'
			$LanguageSpecificStrings[46] = 'W�hle die Sprache aus, die USSF verwenden soll.'
			$LanguageSpecificStrings[47] = 'W�hle das Skin das, das USSF verwenden soll.'
			$LanguageSpecificStrings[48] = 'Skin'
			$LanguageSpecificStrings[49] = 'Lade Sprache ...'
			$LanguageSpecificStrings[50] = 'Lade Skin ...'
			$LanguageSpecificStrings[51] = 'Einstellungen'
	EndSelect
EndFunc

Func SetMessageAndErrorContent($FileName, $FileExtension, $Lang = 'English')
	Select
		Case $Lang = 'English'
			$USSF_Messages[1][1] = '.inf'
			$USSF_Messages[1][2] = 'Informations- oder Installationsdatei'
			$USSF_Messages[1][3] = 'rundll32.exe setupapi,InstallHinfSection DefaultInstall 132 ' & $FileName
			$USSF_Messages[1][4] = 'N/A'

			$USSF_Messages[2][1] = '.reg'
			$USSF_Messages[2][2] = 'Registry Datei'
			$USSF_Messages[2][3] = 'regedit.exe /s "' & $FileName & '"'

			$USSF_Messages[3][1] = '.exe'
			$USSF_Messages[3][2] = 'NSIS Paket'
			$USSF_Messages[3][3] = '"' & $FileName & '" /S'

			$USSF_Messages[4][1] = '.exe'
			$USSF_Messages[4][2] = 'Inno Setup Paket'
			$USSF_Messages[4][3] =  '"' & $FileName & '" /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'

			$USSF_Messages[5][1] = '.exe'
			$USSF_Messages[5][2] = 'Installshield AFW Paket'
			$USSF_Messages[5][4] = 'Die Installationsdatei mit UniExtract oder einem anderen Entpacker extrahieren.' & @CRLF & 'Das entpackte Archiv sollte sollte entweder .CAB oder .MSI basierend.' & @CRLF & 'Als n�chstes nur f�r .CAB basierende Dateien:' & @CRLF & '    Erstelle eine Installation mit diesem Befehl:' & $FileName & ' /r /f1"X:\setup.iss"' & @CRLF & '    Nun kannst du eine stille Installation anhand der ISS Datei durchf�hren:' & $FileName & ' /s /f1"X:\setup.iss"' & @CRLF & 'Als n�chstes nur f�r .MSI bassierende Dateien:' & @CRLF & '    msiexec.exe /i setup.msi /qb'

			$USSF_Messages[6][1] = '.exe'
			$USSF_Messages[6][2] = 'InstallShield 2003 Paket'
			$USSF_Messages[6][3] = '"' & $FileName & '" /s /v"/qb"'
			$USSF_Messages[6][4] = 'Du kannst auch versuchen die .MSI Datei aus dem Temp Verzeichnis w�hrend der Installation zu erhalten, ' & @CRLF & 'danach mit folgendem Befehl installieren:' & @CRLF & 'msiexec.exe /i setup.msi /qb'

			$USSF_Messages[7][1] = '.exe'
			$USSF_Messages[7][2] = 'Wise Installer Paket'
			$USSF_Messages[7][3] = '"' & $FileName & '" /s'

			$USSF_Messages[8][1] = '.exe'
			$USSF_Messages[8][2] = 'Selbstextrahierendes RAR Archiv'
			$USSF_Messages[8][3] = '"' & $FileName & '" /s'
			$USSF_Messages[8][4] = 'Das RAR Kommentar enth�lt das Installationsscript.'

			$USSF_Messages[9][1] = '.exe'
			$USSF_Messages[9][2] = 'Selbstextrahierendes Microsoft CAB Archiv'
			$USSF_Messages[9][4] = 'Das Archiv mit UniExtract oder einem anderen Entpacker extrahieren.'

			$USSF_Messages[10][1] = '.exe'
			$USSF_Messages[10][2] = 'Selbstextrahierendes ZIP Archiv'
			$USSF_Messages[10][4] = 'Das Archiv mit UniExtract oder einem anderen Entpacker extrahieren.'

			$USSF_Messages[11][1] = '.exe'
			$USSF_Messages[11][2] = '7-Zip Installer Paket'
			$USSF_Messages[11][4] = 'Das Archiv mit UniExtract oder einem anderen Entpacker extrahieren.'

			$USSF_Messages[12][1] = '.exe'
			$USSF_Messages[12][2] = 'Unbekanntes 7-Zip Paket'
			$USSF_Messages[12][4] = 'Das Archiv mit UniExtract oder einem anderen Entpacker extrahieren.'

			$USSF_Messages[13][1] = '.exe'
			$USSF_Messages[13][2] = 'Unbekanntes Zip Archiv'
			$USSF_Messages[13][4] = 'Das Archiv mit UniExtract oder einem anderen Entpacker extrahieren.'

			$USSF_Messages[14][1] = '.exe'
			$USSF_Messages[14][2] = 'Selbstextrahierendes WinZip Archiv'
			$USSF_Messages[14][4] = 'Das Archiv mit UniExtract oder einem anderen Entpacker extrahieren.'

			$USSF_Messages[15][1] = '.exe'
			$USSF_Messages[15][2] = 'UPX gepacktes ausf�hrbares Programm'
			$USSF_Messages[15][4] = 'Das ausf�hrbare Programm mit dem Befehl upx.exe -d "' & $FileName & '" entpacken' 

			$USSF_Messages[16][1] = '.msi'
			$USSF_Messages[16][2] = 'Windows Installationsdatei'
			$USSF_Messages[16][3] = 'msiexec.exe /i "' & $FileName & '" /qb'
			
			$USSF_Errors[1][1] = '.exe'
			$USSF_Errors[1][2] = 'Zerst�rte ausf�hrbare Datei.'
			$USSF_Errors[1][4] = 'Es wird dringend empfohlen, die Datei mit einem Virenscanner zu �berpr�fen.'

			$USSF_Errors[2][1] = '.msi'
			$USSF_Errors[2][2] = 'Zerst�rte Windows Installationsdatei.'
			$USSF_Errors[2][4] = 'Es wird dringend empfohlen, die Datei mit einem Virenscanner zu �berpr�fen.'

			$USSF_Errors[3][1] = '.reg'
			$USSF_Errors[3][2] = 'Zerst�rte Registry Datei.'
			$USSF_Errors[3][4] = 'Dieses Feature ist noch experimentell.' & @CRLF & 'Wenn Du glaubst, auf einen Fehler gefunden zu haben, sende mir eine Email an sadicq@gmail.com.'

			$USSF_Errors[4][4] = 'Es wurde keine Datei ausgew�hlt oder die angegebene Datei existiert nicht.' & @CRLF & 'Du kannst dies durch Dr�cken des ">" Knopfes oben rechts tun.'

			$USSF_Errors[5][1] = '.exe'
			$USSF_Errors[5][2] = 'Unbekannte PE Datei'
			$USSF_Errors[5][4] = 'USSF stellte fest, dass die ausgew�hlte Datei eine g�ltige PE Datei ist.' & @CRLF & 'Der Typ der Datei konnte jedoch nicht identifiziert werden.' & @CRLF & 'Der von PEiD zur�ckgegebene Dateikopf war ''%header%'''

			$USSF_Errors[6][1] = '.' & $FileExtension
			$USSF_Errors[6][2] = 'Nicht unterst�tzter Dateityp'
			$USSF_Errors[6][4] = 'Die ausgew�hlte Datei wird von USSF nicht unterst�tzt.' & @CRLF & 'USSF erkennt nur .exe, .msi, .reg und .inf Dateitypen.'

			$USSF_Errors[7][4] = 'Die ausgew�hlte Datei konnte nicht ge�ffnet werden.'

			$USSF_Errors[8][1] = '.exe'
			$USSF_Errors[8][2] = 'PEiD Konflikt'
			$USSF_Errors[8][4] = 'Das ausgew�hlte Programm ist eine g�ltige PE Datei, PEiD erkennt diese jedoch nicht als eine g�ltige PE Datei.' & @CRLF & 'Es wird empfohlen, die Datei auf Viren zu �berpr�fen.'
	EndSelect

	SetNA()
EndFunc