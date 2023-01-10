@echo off
cd ..

rem Making "test" folder and going into it
mkdir test
cd test
cls

rem Download test file from github with diffrent name
curl https://raw.githubusercontent.com/KRWCLASSIC/OptiPack/master/src/misc/download-sources/test_download.txt -o test_downloadED.txt
echo.

rem Going back to the installer.bat and closing this script
echo Downloading done!
pause
cd ../..
start installer.bat
exit