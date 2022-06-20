@echo off
title CCStopper - Patch Retention
mode con: cols=100 lines=42

:: Asks for Administrator Permissions
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd","/c %~s0 ::","","runas",1)(window.close) && exit
cd /d "%~dp0"

:: Check if PatchRetentionSettings folder exists
if not exist ".\PatchRetentionSettings" (
	mkdir ".\PatchRetentionSettings"
)

:: Set the cc app year to 2022
if not exist ".\PatchRetentionSettings\AppVersion.txt" set CCAppYear=2022
else set /p "CCAppYear="<".\PatchRetentionSettings\AppVersion.txt"

:: Check if Path.txt exists
:pathCheck
if not exist ".\PatchRetentionSettings\Path.txt" (
	:: Thanks https://github.com/massgravel/Microsoft-Activation-Scripts for the UI
	cls
	echo:
	echo:
	echo                   _______________________________________________________________
	echo                  ^|                                                               ^| 
	echo                  ^|                                                               ^|
	echo                  ^|                            CCSTOPPER                          ^|
	echo                  ^|                         Made by eaaasun                       ^|
	echo                  ^|                   GenP Patch Retention Module                 ^|
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

:: Reads from Path.txt and sets what's inside as %folder%
set /p "folder="<".\PatchRetentionSettings\Path.txt"

set afterEffects = "%folder%\Adobe After Effects CC %CCAppYear%\Support Files\AfterFXLib.dll"
set animate = "%folder%\Adobe Animate %CCAppYear%\Animate.exe"
set audition = "%folder%\Adobe Audition CC %CCAppYear%\AuUI.dll"
set bridge = "%folder%\Adobe Bridge CC %CCAppYear%\Bridge.exe"
set characterAnimator = "%folder%\Adobe Character Animator CC %CCAppYear%\Support Files\Character Animator.exe"
set dreamweaver = "%folder%\Adobe Dreamweaver CC %CCAppYear%\Dreamweaver.exe"
set illustrator = "%folder%\Adobe Illustrator CC %CCAppYear%\Support Files\Contents\Windows\Illustrator.exe"
set inCopy = "%folder%\Adobe InCopy CC %CCAppYear%\Public.dll"
set inDesign = "%folder%\Adobe InDesign CC %CCAppYear%\Public.dll"
set lightroom = "%folder%\Adobe Lightroom CC\lightroomcc.exe"
set lightroomClassic = "%folder%\Adobe Lightroom Classic CC\Lightroom.exe"
set mediaEncoder = "%folder%\Adobe Media Encoder CC %CCAppYear%\Adobe Media Encoder.exe"
set photoshop = "%folder%\Adobe Photoshop CC %CCAppYear%\Photoshop.exe"
set prelude = "%folder%\Adobe Prelude CC %CCAppYear%\Registration.dll"
set premierePro = "%folder%\Adobe Premiere Pro CC %CCAppYear%\Registration.dll"
set premiereRush = "%folder%\Adobe Premiere Rush CC\Registration.dll"
set acrobatDC = "%folder%\Acrobat DC\Acrobat\Acrobat.dll"
set apps = %afterEffects% %animate% %audition% %bridge% %characterAnimator% %dreamweaver% %illustrator% %inCopy% %inDesign% %lightroom% %lightroomClassic% %mediaEncoder% %photoshop% %prelude% %premierePro% %premiereRush% %acrobatDC%

:exit
start cmd /k %~dp0\..\CCStopper.bat
exit

:mainScript
cls
echo:
echo:
echo                   _______________________________________________________________
echo                  ^|                                                               ^| 
echo                  ^|                                                               ^|
echo                  ^|                            CCSTOPPER                          ^|
echo                  ^|                         Made by eaaasun                       ^|
echo                  ^|                   GenP Patch Retention Module                 ^|
echo                  ^|      ___________________________________________________      ^|
echo                  ^|                                                               ^|
echo                  ^|                      PATCH WITH GENP FIRST!                   ^|
echo                  ^|                                                               ^|
echo                  ^|      This script prevents *any* program (including GenP)      ^|
echo                  ^|      from touching the patched files or files that need       ^|
echo                  ^|      to be patched.                                           ^|
echo                  ^|                                                               ^|
echo                  ^|      ___________________________________________________      ^|
echo                  ^|                                                               ^|
echo                  ^|      [1] Patch Apps                                           ^|
echo                  ^|                                                               ^|
echo                  ^|      [2] Reset patch (Won't affect GenP patch)                ^|
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

if errorlevel 5 goto exit
if errorlevel 4 goto setYear
if errorlevel 3 goto setPath
if errorlevel 2 (
	:: Reset patch
	for %%a in (%files%) do (
		if exist %%a icacls %paths% /reset
	)
)
if errorlevel 1 (
	:: Patch apps
	for %%a in (%files%) do (
		if exist %%a icacls %paths% /deny Administrators:^(W^)
	)
)

:setPath
setlocal
set "psCommand="(New-Object -COMObject 'Shell.Application')^
.BrowseForFolder(0,'Choose folder where Adobe apps are installed.',0,0).self.path""
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

if not exist %folder% (
	echo:
	echo You have not selected a folder. Please pick the folder that Adobe apps are installed in.
	goto setPath
)

echo %folder%>.\PatchRetentionSettings\Path.txt
cls
echo:
echo Path set as %folder%.
timeout /t 3 /nobreak
goto mainScript
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
echo                  ^|                   GenP Patch Retention Module                 ^|
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

if errorlevel 4 (
	set CCAppYear=2019
	goto writeFile
) 
if errorlevel 3 (
	set CCAppYear=2020
	goto writeFile
)
if errorlevel 2 (
	set CCAppYear=2021
	goto writeFile
)
if errorlevel 1 (
	set CCAppYear=2022
	goto writeFile
)

:writeFile
echo %CCAppYear%>.\PatchRetentionSettings\AppVersion.txt
echo App version set successfully!
timeout /t 3 /nobreak
goto mainScript