@echo off
cls
cd ..

rem #Documentation#
rem %CD% variable is windows variable for current path user is in, during downloading procedure it is .../src/temp folder
rem %where% variable is path to the folder that has all the files with download sources (URLs) that this script uses
rem %filename% variable is what file from the %where% path program should use to download mods
rem %dlpath% variable is full path to the %filename%, basicly path with the file at the end
rem %savefolder% variable is "placeholder" where script should save downloaded files, yes "placeholder" because it doesnt work, you need to enter
rem the folder you want to save files to, weird but works.

set "where=%CD%\misc\download-sources"
set "filename=full-src.txt"
set "dlpath=%where%\%filename%"
set "savefolder=%CD%"

rem Downloading procedure saves files into .../src/temp folder to be later moved by post-init.bat
rem In the current state, downloading procedure doesnt support URLs that include all files (**1), 
rem *-src.txt needs to be filled with all mods one by one
rem Its planned to add full folder download feature in the future, mainly for OME project but may include it here to make my work easier

rem **1
rem Valid: https://superultrafilehosting/super-folder-with-files/mod.jar
rem Invalid: https://superultrafilehosting/super-folder-with-files/

rem Downloading procedure
cd temp
rem "For loop" uses variable %dlpath% ("for" loop takes full-src.txt as a refrence) for curl command (using %%i) 
for /f "usebackq delims=" %%i in ("%dlpath%") do (
 cls
 rem Display what file curl is now downloading using %%~nxi (n = file name, x = "and", i = file extension)
 echo Downloading %%~nxi
 rem Downloading command using %dlpath% variable (with %%i) as an input and %savefolder% variable as and output
 curl -L -O "%%i" -o "%savefolder%\%%~nxn"
)
cls

rem Finishing procedure
echo Downloading finished!
echo Entering the finalization procedure...
timeout /t 3 >nul

rem Starting post-init.bat and closing this script
cd ..
cd misc
call post-init.bat
exit