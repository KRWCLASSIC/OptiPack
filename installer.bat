@echo off
title Main Menu
rem "chcp 65001" allows to use non ASCII characters (used for OptiPack logo below)
chcp 65001
rem "cls" here clears output of chcp command that says its now using other character set
cls

rem Version variable
set "ver=b0.4"

rem Handler for downloading modules, if you making own version of this installer make git repo with your own /src folder and include your mods
:src-existance-checker
if exist "src" (
  rem Going to the "temp" folder handler
  goto temphandler
) else (
  rem Downloading "src" folder from project github, this folder includes modules for this to work (By going to src-handler)
  goto 7zipins
)
cls

rem Handler for "temp" folder
:temphandler
if exist "src/temp" (
  rem Continuing with booting procedure
  cls
  goto boot
) else (
  rem Making "temp" directory in "src" folder
  cd src
  mkdir temp
  cd ..
)
cls

rem Booting procedure and boot logo/art
:boot
echo      ╭━━━╮╱╱╭╮╱╭━━━╮╱╱╱╱╱╭╮
echo      ┃╭━╮┃╱╭╯╰╮┃╭━╮┃╱╱╱╱╱┃┃
echo      ┃┃╱┃┣━┻╮╭╋┫╰━╯┣━━┳━━┫┃╭╮
echo      ┃┃╱┃┃╭╮┃┃┣┫╭━━┫╭╮┃╭━┫╰╯╯
echo      ┃╰━╯┃╰╯┃╰┫┃┃╱╱┃╭╮┃╰━┫╭╮╮
echo      ╰━━━┫╭━┻━┻┻╯╱╱╰╯╰┻━━┻╯╰╯
echo      ╱╱╱╱┃┃
echo      ╱╱╱╱╰╯   Version %ver%
echo.
echo.

rem Selection procedure
echo 1) Test download to "test" folder.
echo 2) Download full OptiPack.
echo 3) Download minimal OptiPack.
echo 4) Change deafult minecraft directory.
echo.
set /p select="Option: "
if %select%==1 goto 1
if %select%==2 goto 2
if %select%==3 goto 3
if %select%==4 goto 4
rem Restart procedure
if %select%==r goto r
call installer.bat
exit

rem Selection executables
rem "exit" line between of each tag is to make sure installer.bat window is getting closed when opening other *.bat file

:1
cd src/installers
call test.bat
exit

:2
cd src/installers
call full-src.bat
exit

:3
cd src/installers
call min-src.bat
exit

:4
cd src/misc
call chg-mc-dir.bat
exit

rem Installing 7-Zip from GitHub
:7zipins
mkdir temp
cd temp
echo Downloading embeded 7-Zip...
echo.
curl -LJOS https://github.com/KRWCLASSIC/OptiPack/raw/master/src/misc/7zEmbeded.exe
cls
goto src-handler-7zipconfirmed

rem Creating temp folder outside of the "src" folder (because it isnt exists yet) and downloading into it OptiPack github repo
:src-handler-7zipconfirmed
cls
echo Downloading neccessary files...
echo.
curl -LJO https://github.com/KRWCLASSIC/OptiPack/archive/master.zip
"7zEmbeded.exe" x -y OptiPack-master.zip
cls
rem Continuing with the installation
goto src-extract

rem Moving out "src" folder out of the "temp" folder and removing unnecessary "temp" folder
:src-extract
cd ..
move /y "temp/OptiPack-master/src" .
rd /s /q temp
cls
rem Restarting installer to make sure "src" folder is being detected, yes, you could just go back to the src-handler but why? lol
goto r

rem Restart installer procedure
:r
call installer.bat
exit

rem Closing installer procedure
:exit
exit