@echo off
rem This file is executed when any of the *-src.bat files finishes its work, this script moves all mods to your minecraft directory

rem Load minecraft path to a post-init.bat to finish installing procedure
set /p mc-dir=<mc-dir.txt

rem Setting %num% to 0
set "num=0"

rem Saving downloaded mods from combining with mods in ".minecraft/mods" procedure, basicly checks if there is any *.jar file in mods dir, if there is archive it in a folder
rem loop that adds 1 to the %num% variable if there is Archive folder with that number
:checkloop
set /a num+=1
if exist "%USERPROFILE%\%mc-dir%\mods\Archive%num%" goto checkloop

rem Create the new Archive folder
mkdir "%USERPROFILE%\%mc-dir%\mods\Archive%num%"
rem Move all *.jar files to the Archive folder with current value of %num% variable ()
move "%USERPROFILE%\%mc-dir%\mods\*.jar" "%USERPROFILE%\%mc-dir%\mods\Archive%num%"


rem Moving mods procedure
cd ..
cd temp

rem Iterate through all *.jar files in the temp directory
for %%f in (*jar) do (
  rem Move the current *.jar file to the Minecraft mods directory
  echo Moving %%~nxi...
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
