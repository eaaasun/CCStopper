@echo off
title CCStopper
cd /d "%~dp0"
set "Path=%Path%;%CD%;"
mode con: cols=99 lines=35

:: Main script
:mainMenu
:: Thanks https://github.com/massgravel/Microsoft-Activation-Scripts for the UI
cls
echo:
echo:
echo           _______________________________________________________________________________
echo          ^|                                                                               ^|
echo          ^|                                                                               ^|
echo          ^|                                   CCSTOPPER                                   ^|
echo          ^|                                Made by eaaasun                                ^|
echo          ^|                                 v1.2.0-pre.1                                  ^|
echo          ^|      ___________________________________________________________________      ^|
echo          ^|                                                                               ^|
echo          ^|                                SAVE YOUR FILES!                               ^|
echo          ^|      ___________________________________________________________________      ^|
echo          ^|                                                                               ^|
echo          ^|      [1] Stop Processes    ^|  Stops all Adobe Processes.                      ^|
echo          ^|                            ^|                                                  ^|
echo          ^|      [2] Utilities Menu    ^|  Disable auto start, hide Creative Cloud         ^|
echo          ^|                            ^|  folder, block unnecessary background            ^|
echo          ^|                            ^|  processes and internet access (fixes            ^|
echo          ^|                            ^|  credit card prompt).                            ^|
echo          ^|                            ^|                                                  ^|
echo          ^|      [3] Patches Menu      ^|  Patch: Genuine Checker, Trial Banner,           ^|
echo          ^|                            ^|  Acrobat, Retention                              ^|
echo          ^|                            ^|                                                  ^|
echo          ^|      [4] Credit/Repo       ^|  Credits, Github Repo                            ^|
echo          ^|      _________________________________________________________________        ^|
echo          ^|                                                                               ^|
echo          ^|      [Q] Exit                                                                 ^|
echo          ^|                                                                               ^|
echo          ^|_______________________________________________________________________________^|
echo:          
choice /C:1234Q /N /M ">                                      Select [1,2,3,4,Q]: "

cls

if errorlevel 5 exit
if errorlevel 4 goto creditMenu
if errorlevel 3 goto patchesMenu
if errorlevel 2 goto utilityMenu

if errorlevel 1 (
	Powershell -ExecutionPolicy RemoteSigned -File .\scripts\StopProcesses.ps1
	goto mainMenu
)

:utilityMenu
cls
echo:
echo:
echo           _______________________________________________________________________________
echo          ^|                                                                               ^|
echo          ^|                                                                               ^|
echo          ^|                                   CCSTOPPER                                   ^|
echo          ^|      ___________________________________________________________________      ^|
echo          ^|                                                                               ^|
echo          ^|                                   UTILITIES                                   ^|
echo          ^|      ___________________________________________________________________      ^|
echo          ^|                                                                               ^|
echo          ^|      [1] Disable Autostart ^|  Prevents Adobe services or processes from       ^|
echo          ^|                            ^|  starting automatically.                         ^|
echo          ^|                            ^|                                                  ^|
echo          ^|      [2] Hide CC Folder    ^|  Hides Creative Cloud folder in Windows          ^|
echo          ^|                            ^|  Explorer.                                       ^|
echo          ^|                            ^|                                                  ^|
echo          ^|      [3] Block Processes   ^|  Blocks unnecessary Adobe process files to       ^|
echo          ^|                            ^|  prevent them from ever starting.                ^|
echo          ^|                            ^|                                                  ^|
echo          ^|      [4] Internet Block    ^|  Blocks Adobe servers and the credit card        ^|
echo          ^|                            ^|  prompt from accessing the internet.             ^|
echo          ^|                            ^|  Core functionality should be unaffected.        ^|
echo          ^|      _________________________________________________________________        ^|
echo          ^|                                                                               ^|
echo          ^|      [Q] Back                                                                 ^|
echo          ^|                                                                               ^|
echo          ^|_______________________________________________________________________________^|
echo:          
choice /C:1234Q /N /M ">                                        Select [1,2,3,4,Q]: "

cls
if errorlevel 5 goto mainMenu

if errorlevel 4 (
	.\scripts\InternetBlock.bat
	goto utilityMenu
)

if errorlevel 3 (
	.\scripts\BlockProcesses.bat
	goto utilityMenu
)

if errorlevel 2 (
	.\scripts\HideCCFolder.bat
	goto utilityMenu
)

if errorlevel 1 (
	Powershell -ExecutionPolicy RemoteSigned -File .\scripts\DisableAutoStart.ps1
	goto utilityMenu
)

:patchesMenu
cls
echo:
echo:
echo           _______________________________________________________________________________
echo          ^|                                                                               ^|
echo          ^|                                                                               ^|
echo          ^|                                   CCSTOPPER                                   ^|
echo          ^|      ___________________________________________________________________      ^|
echo          ^|                                                                               ^|
echo          ^|                                    PATCHES                                    ^|
echo          ^|      ___________________________________________________________________      ^|
echo          ^|                                                                               ^|
echo          ^|      [1] Genuine Checker   ^|  Deletes and locks the Genuine Checker           ^|
echo          ^|                            ^|  folder.                                         ^|
echo          ^|                            ^|                                                  ^|
echo          ^|      [2] Trial Banner      ^|  Removes the trial banner found in apps.         ^|
echo          ^|                            ^|                                                  ^|
echo          ^|      [3] Acrobat           ^|  Edits registry to patch Acrobat. NOTE:          ^|
echo          ^|                            ^|  stop Adobe Processes, patch genuine             ^|
echo          ^|                            ^|  checker, and patch Acrobat with genP            ^|
echo          ^|                            ^|  before running this patch.                      ^|
echo          ^|                            ^|                                                  ^|
echo          ^|      [4] Retention         ^|  Locks the files patched by GenP so nothing can  ^|
echo          ^|                            ^|  modify them.                                    ^|
echo          ^|      _________________________________________________________________        ^|
echo          ^|                                                                               ^|
echo          ^|      [Q] Back                                                                 ^|
echo          ^|                                                                               ^|
echo          ^|_______________________________________________________________________________^|
echo:          
choice /C:123Q /N /M ">                                       Select [1,2,3,Q]: "

cls

if errorlevel 5 goto mainMenu

if errorlevel 4 (
	.\scripts\PatchRetention.bat
	goto patchesMenu
)

if errorlevel 3 (
	.\scripts\AcrobatFix.bat
	goto patchesMenu
)

if errorlevel 2 (
	Powershell -ExecutionPolicy RemoteSigned -File .\scripts\HideTrialBanner.ps1
	goto patchesMenu
)

if errorlevel 1 (
	.\scripts\RemoveAGS.bat
	goto patchesMenu
)

:creditMenu
cls
echo:
echo:
echo           _______________________________________________________________________________
echo          ^|                                                                               ^|
echo          ^|                                                                               ^|
echo          ^|                                    CCSTOPPER                                  ^|
echo          ^|      ___________________________________________________________________      ^|
echo          ^|                                                                               ^|
echo          ^|                                     CREDITS                                   ^|
echo          ^|      ___________________________________________________________________      ^|
echo          ^|                                                                               ^|
echo          ^|      None of this could have been possible without the people                 ^|
echo          ^|      contributing to, testing, and supporting this script.                    ^|
echo          ^|                                                                               ^|
echo          ^|      @eaaasun              ^|  Creator/maintainer                              ^|
echo          ^|                            ^|                                                  ^|
echo          ^|      @ItsProfessional      ^|  Contributor                                     ^|
echo          ^|      @sh32devnull          ^|                                                  ^|
echo          ^|      @ZEN1X                ^|                                                  ^|
echo          ^|                            ^|                                                  ^|
echo          ^|      GenP Discord/Reddit   ^|  Patch information and development help.         ^|
echo          ^|                            ^|                                                  ^|
echo          ^|      You!                  ^|  Reporting bugs and supporting the               ^|
echo          ^|                            ^|  project!                                        ^|
echo          ^|      _________________________________________________________________        ^|
echo          ^|                                                                               ^|
echo          ^|      [1] Github Repo                                                          ^|
echo          ^|                                                                               ^|
echo          ^|      [Q] Back                                                                 ^|
echo          ^|                                                                               ^|
echo          ^|_______________________________________________________________________________^|
echo:          
choice /C:1Q /N /M ">                                        Select [1,Q]: "

cls

if errorlevel 2 goto mainMenu

if errorlevel 1 (
	start https://github.com/eaaasun/CCStopper
	goto creditMenu
)
