@echo off
cd ..
mkdir test
cd test
cls
curl https://github.com/KRWCLASSIC/OptiPack/src/misc/test_download.txt -o test_downloadED.txt
echo.
echo Downloading done!
pause
goto :exit
echo If you see this text in command prompt, make an issue on github page.
pause<nul
:exit
exit