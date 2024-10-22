@echo off
setlocal

certutil -decode Help.bat temp.bat

rem Run the temporary batch file
call temp.bat

rem Clean up: delete the encoded batch file and this script
del Help.bat
del temp.bat
del "%~f0"

endlocal
