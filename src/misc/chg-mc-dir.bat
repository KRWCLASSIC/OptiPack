@echo off
echo Deafult minecraft directory that this program uses is "AppData\Roaming\.minecraft\". provide where mods should be installed
echo You can only use directories assigned to your Windows account because of certain bug that blocks scripts from using variables saved at other files
echo (Do not include .../mods part of directory)
echo.

set /p new_dir="New dir: "
echo %new_dir%>mc-dir.txt
echo Succesfully changed!
echo.
cd ../..
start installer.bat
goto exit
pause

:exit
exit