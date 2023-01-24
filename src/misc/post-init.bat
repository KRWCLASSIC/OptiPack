@echo off
title Post Initialization
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
move "%USERPROFILE%\%mc-dir%\mods\*.jar" "%USERPROFILE%\%mc-dir%\mods\Archive%num%" >nul
cls

rem Check if any *.jar file was moved
if exist "%USERPROFILE%\%mc-dir%\mods\Archive%num%\*.jar" (
  echo Previously installed mods detected: Mods were moved to "%USERPROFILE%\%mc-dir%\mods\Archive%num%"
) else (
  echo No previously installed mods found. Started mods moving procedure!
  rd /s /q "%USERPROFILE%\%mc-dir%\mods\Archive%num%"
)
timeout /t 3 >nul
cls

cd ..

rem Unzipping modpack
rem Use a for loop to iterate through all *.zip files
for %%f in (temp\*.zip) do (
  echo Extracting files from %~nx1...
  rem Extract the current file using 7-Zip
  "%cd%\misc\7zEmbeded.exe" x -y "%%f" -o"temp" >nul
  del "%%f" 
)
echo Modpack files extracted.
timeout /t 2 >nul
cls

cd temp

rem Moving mods procedure
rem Iterate through all *.jar files in the temp directory
for %%f in (*jar) do (
  rem Move the current *.jar file to the Minecraft mods directory
  echo Moving %%~nxi...
  move /y "%%f" "%USERPROFILE%\%mc-dir%\mods"
  cls
)

echo Moving mods completed!
timeout /t 5 >nul

rem Closing post-init.bat file
goto exit
:exit
exit
