@echo off
cls
echo Deafult minecraft directory that this program uses is "AppData\Roaming\.minecraft". 
echo Provide where mods should be installed.
echo You can only use directories assigned to your Windows account because of certain bug 
echo that blocks scripts from using variables saved at other files
echo (Do not include .../mods part of directory and do not add any slash at the end of the program, this will break the program)
echo.

rem User input for variable %new_dir%
set /p new_dir="New dir: "

rem Saving entire variable into mc-dir.txt file
echo %new_dir%>mc-dir.txt

echo Succesfully changed!
echo Press any key to contiune.
echo.
pause >nul

rem Going back to the installer.bat and closing this script
cd ../..
call installer.bat
exit