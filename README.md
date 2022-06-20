# CCStopper <!-- omit in toc --> 

Stops Adobe's pesky background apps and more!

## THIS IS THE DEVELOPMENT VERSION! <!-- omit in toc -->

Please don't run any code here, unless you know *exactly* what you're doing. If you do, please consider contributing.

## Table of Contents <!-- omit in toc -->
- [v1.2.0 Changelog](#v120-changelog)
- [Installation](#installation)
- [Menu Options](#menu-options)
- [FAQ](#faq)
- [Future Features](#future-features)
- [Known Issues](#known-issues)
- [Disclaimer/Notice](#disclaimernotice)

**Current Version (stable):** v1.1.3

**Current Version (development):** v1.2.0-dev

## v1.2.0 Changelog

- UI Change
  - Added submenus and changed inputs
- Combined Credit Card Stop module and ServiceBlock module
  - Thanks to [@sh32devnull](https://github.com/sh32devnull) for ServiceBlock module
  - Adds Adobe IPs to hosts file and blocks Adobe Desktop Service in firewall
- Added DisableAutoStart, HideCCFolder, BlockProcesses, and HideTrialBanner modules
  - Thanks to [@ItsProfessional](https://github.com/ItsProfessional) for all these modules
- Bug Fixes and Improvements
  - Again, big thanks to contributors mentioned above for helping!
- Documentation Update
###### Read previous changelogs from [the releases](https://github.com/eaaasun/CCStopper/releases) <!-- omit in toc -->


## Installation

1. Get the latest [release](https://github.com/eaaasun/CCStopper/releases/latest)
2. Extract the ZIP file (This is important, CCStopper will not work without the additional scripts in the additional folders)
3. Run CCStopper.bat
4. Select an option
5. Prevent profit (for Adobe)

## Menu Options

<details>
<summary>[1] Stop Processes</summary>
&nbsp;&nbsp;&nbsp;&nbsp;Does what it says, all Adobe processes will be stopped.
</details>
<details>
<summary>[2] Utilities Menu</summary>

- [1] Disable Autostart - Prevents Adobe services/processes from starting automatically.
- [2] Hide CC Folder - Hides Creative Cloud folder in Windows Explorer.
- [3] Block Processes - Blocks unnecessary Adobe process files to prevent them from ever starting.
</details>

<details>
<summary>[3] Patches Menu</summary>

- [1] Genuine Checker - Deletes and locks the Genuine Checker folder.
- [2] Service Block - Blocks Adobe servers and the credit card prompt from accessing the internet.
- [3] Trial Banner - Removes the trial banner found in apps.
- [4] Acrobat - Edits registry to patch Acrobat. NOTE: please stop Adobe Processes, patch genuine checker, and patch Acrobat with GenP before running this patch.
- [5] Retention - Locks the files patched by GenP so nothing can modify them.
</details>

<details>
<summary>[4] Credits/Repo Menu</summary>

- [1] Github Repo
</details>

## FAQ
<details>
<summary>Q: It asks for administrator permissions?</summary>

A: This script needs those permissions to modify files and settings. The full source code of this script is available in this repository for auditing.</details>

<details>
<summary>Q: Is this a virus?</summary>

A: Windows might say that it is a virus, but that is a false positive. As stated above, the full source code for this script is available for auditing.
</details>

<details>
<summary>Q: I found a bug/issue! What do I do?</summary>

A: Update to the latest version. If the issue persists, check the open issues and [the known issues](https://github.com/eaaasun/CCStopper/blob/main/README.md#known-issues) for any issues that I am aware of. If it's not there, open up an issue describing your problem and how to reproduce it. I'll work on it as soon as I can.

</details>

<details>
<summary>Q: Is this available for MacOS?</summary>

A: It is not currently available for MacOS, and I don't intend on porting it to MacOS. Community ports are welcome, but please credit accordingly.
</details>

<details>
<summary>Q: Will more features be added?</summary>

A: Yes! They are all in the Future Features section below. Any help with the future features is greatly appreciated!
</details>

<details>
<summary>Q: Will this affect Adobe apps in any negative way?</summary>

A: No, it won't. If you do have Adobe apps (Photoshop, After Effects, etc.) open, it will close them if you decide to end Adobe processes. If you decide to block adobe processes some functionality of adobe apps might be lost, however 95% of functionality will remain. Other than that, everything should work normally. Please open an issue if this is not the case.
</details>

<details>
<summary>Q: Is there any way to support the project?</summary>

A: Please donate your time! If you have batch scripting knowledge, please look through the Future Features section below and see what you can contribute. Financial donations are not accepted at the moment.
</details>

## Future Features
> These are features that I'd like to implement in the future. If you can help, please open a thread in the discussions tab, under the "Development" category, or if you have code already, open a pull request! 

- [ ] Patch Retention
  - Locks the patched file from GenP so that nothing can modify/delete it
  - I'm stuck at setting a list of filepaths that the script can read off and patch. 
- [ ] Backup documentation/scripts
## Known Issues
> There are more issues in the [issues](https://github.com/eaaasun/CCStopper/issues) section; these are just the most common ones.

**Issue:** Error message: `The execution of scripts is disabled on this system. Please see "Get-Help about_signing" for more details.` or selecting the "Genuine Checker" patch gives no results.

Fix: Run `Set-ExecutionPolicy RemoteSigned` in an administrator powershell window, or manually execute the `StopProcesses.ps1` script in the scripts folder once (you can use CCStopper running the script for the first time manually). [Credit to /u/getblownaparte on Reddit for bringing this issue up](https://www.reddit.com/user/getblownaparte/)

---

**Issue:** Error message: `The argument '.\scripts\StopProcesses.ps1' to the -File parameter does not exist. Provide the path to an existing file as an argument to the -File parameter.` and no apps are closed.

**Fix:** Update to the latest version of the script.

---

**Issue:** Error message: `The target registry key cannot be found. Cannot proceed with Acrobat fix.`

**Fix:** Create a DWORD value (in the registry) called `IsAMTEnforced` with a value of 1. You will not need to patch Acrobat with the script after this.

## Disclaimer/Notice

**Disclaimer:** This script is in an early stage, and offered as-is. There will be bugs. I am not responsible for any damage or loss of data caused by these scripts. I am not affiliated with Adobe.

**Notice:** Don't use this tool for piracy. It's illegal, and multi-billion dollar companies like Adobe _needs_ to profit off unreliable and overpriced software. Piracy _helps_ Adobe by increasing their market dominance. If you want to dethrone Adobe, use [alternatives](https://ass.easun.me).

<h6 align="center">Made with &lt;3, and &lt;/3 for Adobe</h6>