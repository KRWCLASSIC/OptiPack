@echo off
rem This file is executed when any of the *-src.bat files finishes its work, this script moves all mods to your minecraft directory

rem Load minecraft path to a post-init.bat to finish installing procedure
set /p mc-dir=<mc-dir.txt

rem Moving mods procedure
cd ..
cd temp

rem Iterate through all files in the temp directory
for %%f in (*) do (
  rem Move the current file to the Minecraft mods directory
  move /y "%%f" "%USERPROFILE%\%mc-dir%\mods"
  cls
)

echo Moving mods completed!
echo Press any key to close program.
pause>nul

rem Closing post-init.bat file
goto exit
pause
:exit
exit
