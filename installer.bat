@echo off
rem "chcp 65001" allows to use non ASCII characters (used for OptiPack logo below)
chcp 65001
rem "cls" here clears output of chcp command that says its now using other character set
cls

rem Handler for downloading modules, if you making own version of this installer make git repo with your own /src folder and include your mods
if exist "src" (
  goto boot
) else (
  rem Downloading "src" folder from project github, this folder includes modules for this to work
  goto src-handler
)
cls

rem Handler for "temp" folder
cd src
if exist "temp" (
  cd ..
  cls
  goto boot
) else (
  rem Making "temp" directory
  mkdir temp
)
cls

rem If you want to change installer file name you need to include it in all files that go back to this .bat file (This file also uses it 2 lines)

rem Booting procedure and boot logo/art
:boot
echo ╭━━━╮╱╱╭╮╱╭━━━╮╱╱╱╱╱╭╮
echo ┃╭━╮┃╱╭╯╰╮┃╭━╮┃╱╱╱╱╱┃┃
echo ┃┃╱┃┣━┻╮╭╋┫╰━╯┣━━┳━━┫┃╭╮
echo ┃┃╱┃┃╭╮┃┃┣┫╭━━┫╭╮┃╭━┫╰╯╯
echo ┃╰━╯┃╰╯┃╰┫┃┃╱╱┃╭╮┃╰━┫╭╮╮
echo ╰━━━┫╭━┻━┻┻╯╱╱╰╯╰┻━━┻╯╰╯
echo ╱╱╱╱┃┃
echo ╱╱╱╱╰╯   Version 0.1
echo.
echo.

rem Selection procedure
echo 1) Test download to test folder.
echo 2) Download full OptiPack.
echo 3) Download minimal OptiPack.
echo 4) Download full OptiPack with cheats.
echo 5) Download minimal OptiPack with cheats.
echo 6) Change deafult minecraft directory.
echo.
set /p select="Option: "
if %select%==1 goto 1
if %select%==2 goto 2
if %select%==3 goto 3
if %select%==4 goto 4
if %select%==5 goto 5
if %select%==6 goto 6
rem Restart procedure
if %select%==r goto r
rem Testing procedure for handling src folder download
if %select%==sh goto src-handler
start installer.bat
exit

rem Selection executables
rem "exit" line between of each tag is to make sure installer.bat window is getting closed when opening other *.bat file

:1
cd src/versions
start test.bat
exit

:2
cd src/versions
start full-src.bat
exit

:3
cd src/versions
start min-src.bat
exit

:4
cd src/versions
start full+cheats-src.bat
exit

:5
cd src/versions
start min+cheats-src.bat
exit

:6
cd src/misc
start chg-mc-dir.bat
exit

rem Handler for situations where there is no "src" folder
:src-handler
cls
where 7z.exe >nul 2>&1
if %ERRORLEVEL% == 0 (
  goto src-handler-7zipconfirmed
) else (
  goto select7zip
)

rem Asking for 7-Zip install agreement
:select7zip
echo Can installer download 7-Zip on your computer? This is needed for unzipping file that includes "src" folder (You need to have winget installed)
set /p select7z="Option (y/n): "
if %select7z%==y goto 7zipins
if %select7z%==n goto r
exit

rem Installing 7-Zip and adding to the PATH to be executed from command line with command with user agreement
:7zipins
cls
winget install 7-Zip
setx path "%path%;C:\Program Files\7-Zip"
cls
goto r

:src-handler-7zipconfirmed
cls
mkdir temp
cd temp
curl -LJO https://github.com/KRWCLASSIC/OptiPack/archive/master.zip
7z x OptiPack-master.zip
cls
goto src-extract
exit

:src-extract
cd ..
move /y "temp/OptiPack-master/src" .
cls
goto boot
exit

rem Restart installer (For debugging)
:r
start installer.bat
exit