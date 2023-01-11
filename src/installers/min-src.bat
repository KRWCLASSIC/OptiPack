@echo on
cd ..
echo %cd%

set "where=%CD%\misc\download-sources"
set "filename=full-src.txt"
set "dlpath=%where%\%filename%"
set "savefolder=%CD%\temp"

for /F "delims=" %%i in (%dlpath%) do (
    set "url=%%i"
    curl -r 0- -np -s -l -o "%savefolder%\%%~nxi" "%url%"
)

echo bruuuuuuuuuuuh
echo some serious skill issue right there
echo why isnt this working
echo im gonna cry rn
echo yk what? im gonna fix it later lmao
pause
exit