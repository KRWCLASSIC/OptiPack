@echo off
cd ..

rem Selection of from what folder this script starts searching for a file with download links
set "where=%CD%\misc\download-sources
rem Selection of from what file this script will grab download links
set "filename=full-src.txt"

rem Merging these 2 variables
set "dlpath=%where%\%filename%"

rem Selection of the download folder (temporarly, when all file are downloaded post-init.bat is executed to finish the download)
set "savefolder=%CD%"

rem rem Installing procedure ("cd temp" before a downloading loop is for making sure to save the files into "temp" dir. Yeah it doesnt work if you add it to savefolder variable, weird ig)
rem cd temp
rem for /f "usebackq delims=" %%i in ("%dlpath%") do (
rem  cls
rem  echo Downloading %%~nxi
rem  curl -L -O "%%i" -o "%savefolder%\%%~nxn"
rem )

cls

rem Finishing procedure
echo Downloading finished!
echo Press any key to continue the installation
cd misc
start post-init.bat
pause
exit