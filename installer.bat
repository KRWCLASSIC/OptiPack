@echo off
rem "chcp 65001" allows to use non ASCII characters (used for OptiPack logo below)
chcp 65001
rem "cls" here clears output of chcp command that says its now using other character set
cls

rem Handler for downloading modules, if you making own version of this installer make git repo with your own /src folder and include your mods
:src-existance-checker
if exist "src" (
  rem Going to the "temp" folder handler
  goto temphandler
) else (
  rem Downloading "src" folder from project github, this folder includes modules for this to work (By going to src-handler)
  goto src-handler
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
echo ╭━━━╮╱╱╭╮╱╭━━━╮╱╱╱╱╱╭╮
echo ┃╭━╮┃╱╭╯╰╮┃╭━╮┃╱╱╱╱╱┃┃
echo ┃┃╱┃┣━┻╮╭╋┫╰━╯┣━━┳━━┫┃╭╮
echo ┃┃╱┃┃╭╮┃┃┣┫╭━━┫╭╮┃╭━┫╰╯╯
echo ┃╰━╯┃╰╯┃╰┫┃┃╱╱┃╭╮┃╰━┫╭╮╮
echo ╰━━━┫╭━┻━┻┻╯╱╱╰╯╰┻━━┻╯╰╯
echo ╱╱╱╱┃┃
echo ╱╱╱╱╰╯   Version 0.2
echo.
echo.

rem Selection procedure
echo 1) Test download to "test" folder.
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
cd src/installers
call full+cheats-src.bat
exit

:5
cd src/installers
call min+cheats-src.bat
exit

:6
cd src/misc
call chg-mc-dir.bat
exit

rem Handler for situations where there is no "src" folder e.g. first boot
:src-handler
cls
rem Check if there is 7-Zip installed anywhere (Will be changed in the future to: Check if installed in "C:\Program Files\7-Zip\7z.exe" because of cases like 7-Zip installed elsewhere will break unzipping procedure)
where 7z.exe >nul 2>&1
if %ERRORLEVEL% == 0 (
  rem If there is installed 7-Zip, go to :src-handler-7zipconfirmed label
  goto src-handler-7zipconfirmed
) else (
  rem If there isnt (Error output by "where" command) go to :select7zip label (Install 7-Zip or not)
  goto select7zip
)

rem Asking for 7-Zip install agreement
rem Yes - go to installing procedure, No - close the installer, ? - show more info
:select7zip
echo Can installer download 7-Zip on your computer? This is needed for unzipping file that includes "src" folder (You need to have winget installed, if you want more info type "?")
set /p select7z="Option (y/n/?): "
if %select7z%==y goto 7zipins
if %select7z%==n goto exit
if %select7z%==? goto ?
exit

rem Basicly nothing important, just some info about winget
:?
echo You can test if you have winget installed by opening cmd (Win + R and type cmd) and typing "winget" and if you get results with command help you have winget installed.
echo If you get error you can install winget from Microsoft Store. (May be called "Package manager")
pause>nul
goto select7zip

rem Installing 7-Zip using winget with user agreement and continuing the installation
:7zipins
cls
echo Installing 7-Zip
winget install 7-Zip
cls
goto src-handler-7zipconfirmed

rem Creating temp folder outside of the "src" folder (because it isnt exists yet) and downloading into it OptiPack github repo
:src-handler-7zipconfirmed
cls
mkdir temp
cd temp
echo Downloading neccessary files...
echo.
curl -LJO https://github.com/KRWCLASSIC/OptiPack/archive/master.zip
"C:\Program Files\7-Zip\7z.exe" x OptiPack-master.zip
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