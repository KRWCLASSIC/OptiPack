@echo off
cd ..
cd temp
curl https://raw.githubusercontent.com/bucanero/pkgi-ps3/master/CHANGELOG.md -o clog.md
echo.
echo Downloading done!
pause
goto :exit
echo If you see this text in command prompt, make an issue on github page.
pause<nul
:exit
exit