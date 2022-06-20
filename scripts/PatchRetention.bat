@echo off
title CCStopper - Patch Retention
Set "Path=%Path%;%CD%;%CD%\Plugins;"
mode con: cols=100 lines=36

:: Asks for Administrator Permissions
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d "%~dp0"

:: checks if patchRetentionSettings folder exists
if not exist ".\patchRetentionSettings" (
	mkdir ".\patchRetentionSettings"
)

:: Sets the cc app year to 2022
if not exist ".\pathRetentionSettiongs\appVer.txt" (
	set CCAppYear=2022
)
else (
	set /p "CCAppYear="<".\patchRetentionSettings\appVer.txt"
)

:: checks if paths.txt exists
:pathCheck
if not exist ".\patchRetentionSettings\paths.txt" (
	:: shows a message for user to set up the paths
	cls
	:: Thanks https://github.com/massgravel/Microsoft-Activation-Scripts for the UI
	echo:
	echo:
	echo                   _______________________________________________________________
	echo                  ^|                                                               ^| 
	echo                  ^|                                                               ^|
	echo                  ^|                            CCSTOPPER                          ^|
	echo                  ^|                         Made by eaaasun                       ^|
	echo                  ^|                   genP Patch Retention Module                 ^|
	echo                  ^|      ___________________________________________________      ^|
	echo                  ^|                                                               ^|
	echo                  ^|                     SELECT ADOBE APP FOLDER                   ^|
	echo                  ^|                                                               ^|
	echo                  ^|      Looks like you have not set the path where Adobe         ^|
	echo                  ^|      apps are installed! Please select the folder where       ^|
	echo                  ^|      all Adobe apps are installed.                            ^|
	echo                  ^|                                                               ^|
	echo                  ^|_______________________________________________________________^|
	echo:
	pause
	goto setPath
)

:: reads from paths.txt and sets what's inside as %folder%
set /p "folder="<".\patchRetentionSettings\paths.txt"

:: Main script
:menu
cls
echo:
echo:
echo                   _______________________________________________________________
echo                  ^|                                                               ^| 
echo                  ^|                                                               ^|
echo                  ^|                            CCSTOPPER                          ^|
echo                  ^|                         Made by eaaasun                       ^|
echo                  ^|                   genP Patch Retention Module                 ^|
echo                  ^|      ___________________________________________________      ^|
echo                  ^|                                                               ^|
echo                  ^|                      PATCH WITH GENP FIRST!                   ^|
echo                  ^|                                                               ^|
echo                  ^|      This script prevents *any* program (including genP)      ^|
echo                  ^|      from touching the patched files or files that need       ^|
echo                  ^|      to be patched.                                           ^|
echo                  ^|                                                               ^|
echo                  ^|      ___________________________________________________      ^|
echo                  ^|                                                               ^|
echo                  ^|      [1] Patch Apps                                           ^|
echo                  ^|                                                               ^|
echo                  ^|      [2] Reset patch (won't affect genP patch)                ^|
echo                  ^|      ___________________________________________________      ^|
echo                  ^|                                                               ^|
echo                  ^|      [3] Set app installation path                            ^|
echo                  ^|                                                               ^|
echo                  ^|      [4] Set app version                                      ^|
echo                  ^|                                                               ^|
echo                  ^|      [5] Back                                                 ^|
echo                  ^|                                                               ^|
echo                  ^|_______________________________________________________________^|
echo:
echo                   Adobe app path: %folder%
echo                   Adobe app version: CC%CCAppYear%
echo:          
choice /C:12345 /N /M ">                                     Select [1,2,3,4,5]: "

if errorlevel  5 (
cd %~dp0
cd ..
start cmd /k CCStopper.bat
)
if errorlevel  4 goto setyear
if errorlevel  3 goto setPath
if errorlevel  2 (
	:: reset patch
)
if errorlevel  1 (
	:: patch apps
)



:: Deny permissions to file
@REM icacls %paths% /deny Administrators:(F)

:: https://stackoverflow.com/a/15885133
:setPath
setlocal

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Choose folder where Adobe apps are installed.',0,0).self.path""

for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

:: %folder% is the path to the folder you chose
if "%folder%"=="ECHO is off." (
	echo:
	echo You have not selected a folder. Please pick the folder that Adobe apps are installed in.
	goto :setPath
)

echo %folder%>.\patchRetentionSettings\paths.txt
cls
echo:
echo Path set as %folder%.
pause
goto menu
endlocal

:setYear
cls
echo:
echo:
echo                   _______________________________________________________________
echo                  ^|                                                               ^| 
echo                  ^|                                                               ^|
echo                  ^|                            CCSTOPPER                          ^|
echo                  ^|                         Made by eaaasun                       ^|
echo                  ^|                   genP Patch Retention Module                 ^|
echo                  ^|      ___________________________________________________      ^|
echo                  ^|                                                               ^|
echo                  ^|                        SET CC APP VERSION                     ^|
echo                  ^|                                                               ^|
echo                  ^|      Select the version (2022, 2021, 2020, etc.) from         ^|
echo                  ^|      the list below. You're out of luck if your version       ^|
echo                  ^|      is not listed.                                           ^|
echo                  ^|      ___________________________________________________      ^|
echo                  ^|                                                               ^|
echo                  ^|      [1] 2022                 ^|      [2] 2021                 ^|
echo                  ^|                               ^|                               ^|
echo                  ^|      [3] 2020                 ^|      [4] 2019                 ^|
echo                  ^|_______________________________________________________________^|
echo:
echo:          
choice /C:1234 /N /M ">                                       Select [1,2,3,4]: "

if errorlevel  4 (
	set CCAppYear=2019
	goto writeFile
) 
if errorlevel  3 (
	set CCAppYear=2020
	goto writeFile
)
if errorlevel  2 (
	set CCAppYear=2021
	goto writeFile
)
if errorlevel  1 (
	set CCAppYear=2022
	goto writeFile
)

:writeFile
echo %CCAppYear%>.\patchRetentionSettings\appVer.txt
echo App version set successfully!
pause
goto menu