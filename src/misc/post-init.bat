@echo off
rem This file is executed when any of the *-src.bat files finishes its work, this script moves all mods to your minecraft directory

rem Load minecraft path to a post-init.bat to finish installing procedure
set /p mc-dir=<mc-dir.txt

rem Moving mods procedure
cd ..
cd temp
move /y "*" "C:\Users\%USERNAME%\%mc-dir%\mods"
echo Moving mods completed!
pause>nul

rem Closing post-init.bat file
goto exit
pause
:exit
exit