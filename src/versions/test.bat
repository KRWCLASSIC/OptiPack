@echo off
cd ..
mkdir test
cd test
cls
curl https://github.com/KRWCLASSIC/OptiPack/blob/master/src/misc/download-sources/test_download.txt -o test_downloadED.txt
echo.
echo Downloading done!
pause
cd ../..
start installer.bat
exit