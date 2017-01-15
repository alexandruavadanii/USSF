;sadicq@gmail.com
#include 'Version.au3'
RunWait(@ProgramFilesDir & '\AutoIt3\Aut2Exe\Aut2Exe.exe /in "' & @ScriptDir & '\ussf.au3" /out "' & @ScriptDir & '\ussf_noextra.exe" /icon "' & @ScriptDir & '\ussf.ico" /comp 4 /nodecompile')
RunWait(@ComSpec & ' /c copy /b "' & @ScriptDir & '\ussf_noextra.exe" + "' & @ScriptDir & '\Extra.txt" /b "' & @ScriptDir & '\ussf.exe"', @ScriptDir, @SW_HIDE)
FileDelete(@ScriptDir & '\ussf_noextra.exe')

$Content = '1 VERSIONINFO' & @CRLF & 'FILEVERSION ' & $ProgramMajorVersion & ',' & $ProgramMinorVersion & ',' & $ProgramBuildVersion & ',' & $ProgramBugfixVersion & @CRLF & 'PRODUCTVERSION ' & $ProgramMajorVersion & ',' & $ProgramMinorVersion & ',' & $ProgramBuildVersion & ',' & $ProgramBugfixVersion & @CRLF & 'FILEOS 0x4' & @CRLF & 'FILETYPE 0x0' & @CRLF & '{' & @CRLF & 'BLOCK "StringFileInfo"' & @CRLF & '{' & @CRLF & '	BLOCK "080904b0"' & @CRLF & '	{' & @CRLF & '		VALUE "Comments", "USSF"' & @CRLF & '		VALUE "FileDescription", "USSF ' & $ProgramMajorVersion & '.' & $ProgramMinorVersion & '.' & $ProgramBuildVersion & '.' & $ProgramBugfixVersion & '."' & @CRLF & '		VALUE "FileVersion", "' & $ProgramMajorVersion & '.' & $ProgramMinorVersion & '.' & $ProgramBuildVersion & '.' & $ProgramBugfixVersion & '"' & @CRLF & '		VALUE "LegalCopyright", "Contact me at sadicq@gmail.com"' & @CRLF & '	}' & @CRLF & '}' & @CRLF & @CRLF & 'BLOCK "VarFileInfo"' & @CRLF & '{' & @CRLF & '	VALUE "Translation", 0x0809 0x04B0' & @CRLF & '}' & @CRLF & '}'
FileWrite(@ScriptDir & '\ussf.rc', $Content)
RunWait('ResHacker.exe -addoverwrite ussf.exe,ussf.exe,ussf.res,,,', @ScriptDir, @SW_HIDE)
;~ FileDelete(@ScriptDir & '\ussf.rc')