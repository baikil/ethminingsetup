@echo off
set "_cd=%cd%"
:0
cls
title Eth Mining Setup
echo Eth Mining Setup
echo.
echo Setup :
echo 1. Create a Metamask wallet
echo 2. Set up the Polygon mainnet
echo 3. Change the Ethermine settings
echo 4. Create the miner file
echo.
echo Tools :
echo 5. Consult your Ethermine dashboard
echo 6. Change your wallet address (only for this program)
echo 7. Consult the [Eth Mining Setup] github page
choice /c 12345678 /n
goto %errorlevel%
:1
cls
title Eth Mining Setup - Create a Metamask wallet
echo Create a Metamask wallet (1/2)
echo.
echo The first step to mine ETH is to have a wallet.
echo We are going to use Metamask for our wallet.
echo First, go to the Matamask website and download the extension.
echo.
echo (Press any key to open the website)
pause>nul
start https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn
echo.
echo (Press 1 to show the next step)
choice /c 1 /n
cls
echo Create a Metamask wallet (2/3)
echo.
echo Once you have downloaded it, create a wallet and make sure to note your password.
echo What is also really important is to store your secret recovery phrase somewhere safe.
echo After doing this, your wallet is now functionnal.
echo.
echo (Press 1 to show the next step)
choice /c 1 /n
:00
cls
echo Create a Metamask wallet (3/3)
echo.
echo Now, click on [Account 1] to copy your wallet address and then paste it below.
set /p "address=Wallet address : "
call :strlen address lenght
if %lenght% neq 42 (echo Please enter a valid address&echo.&pause&goto 00)
md %public%\.ethminingsetup
echo %address%>%public%\.ethminingsetup\address.txt
echo.
echo 1. Go back to the menu
echo 2. Proceed to the next step
choice /c 12 /n
if %errorlevel% == 2 goto 2
goto 0
:2
cls
title Eth Mining Setup - Set up the Polygon mainnet
echo Set up the Polygon mainnet (1/7)
echo.
echo Then we have to set up the Polygon mainnet.
echo To do it, click on [Etherium mainnet] in the top right corner of the Metamask interface
echo and then click on [Add network]
echo.
echo All the text required to input in the next steps will automatically be put into your
echo clipboard so you only need to click the field and paste (Ctrl+V)
echo.
echo (Press 1 to show the next step)
choice /c 1 /n
cls
echo Set up the Polygon mainnet (2/7)
echo.
echo In the [Network Name] field, put "Polygon mainnet"
echo Or simply paste (Ctrl+V)
echo Polygon mainnet|clip
echo.
echo (Press 1 to show the next step)
choice /c 1 /n
cls
echo Set up the Polygon mainnet (3/7)
echo.
echo In the [New RPC URL] field, put "https://polygon-rpc.com/"
echo Or simply paste (Ctrl+V)
echo https://polygon-rpc.com/|clip
echo.
echo (Press 1 to show the next step)
choice /c 1 /n
cls
echo Set up the Polygon mainnet (4/7)
echo.
echo In the [Chain ID] field, put "137"
echo Or simply paste (Ctrl+V)
echo 137|clip
echo.
echo (Press 1 to show the next step)
choice /c 1 /n
cls
echo Set up the Polygon mainnet (5/7)
echo.
echo In the [Currency Symbol] field, put "MATIC"
echo Or simply paste (Ctrl+V)
echo MATIC|clip
echo.
echo (Press 1 to show the next step)
choice /c 1 /n
cls
echo Set up the Polygon mainnet (6/7)
echo.
echo In the [Block Explorer URL] field, put "https://polygonscan.com/"
echo Or simply paste (Ctrl+V)
echo https://polygonscan.com/|clip
echo.
echo (Press 1 to show the next step)
choice /c 1 /n
cls
echo Set up the Polygon mainnet (7/7)
echo.
echo If you completed the steps above correctly, you should now have the Polygon mainnet
echo linked to your wallet.
echo.
echo 1. Go back to the menu
echo 2. Proceed to the next step
choice /c 12 /n
if %errorlevel% == 2 goto 3
goto 0
:3
cls
title Eth Mining Setup - Change the Ethermine settings
echo Change the Ethermine settings
if exist "%public%\.ethminingsetup\address.txt" (set /p address=<"%public%\.ethminingsetup\address.txt")
if "%address%" == "" (call :address 3)
echo.
echo Now you will need to change some settings on the Ethermine website.
echo.
echo (Press any key to open the website)
pause>nul
start https://ethermine.org/miners/%address%/settings#payment-method
echo.
echo (Press 1 to show the next step)
choice /c 1 /n
cls
echo Change the Ethermine settings
echo.
echo Then select the [L2 Polygon (Matic)] option and save.
echo The Ethermine settings are now correct
echo.
echo 1. Go back to the menu
echo 2. Proceed to the next step
choice /c 12 /n
if %errorlevel% == 2 goto 4
goto 0
:4
cls
title Eth Mining Setup - Create the miner file
echo Create the miner file
if exist "%public%\.ethminingsetup\address.txt" (set /p address=<"%public%\.ethminingsetup\address.txt")
if "%address%" == "" (call :address 4)
echo.
echo Creating the miner file...
echo (This should not take too long)
echo.
md %public%\.ethminingsetup
powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://github.com/baikil/ethminingsetup/raw/main/t-rex.7z','%public%\.ethminingsetup\t-rex.7z')"
%_cd%\data\7za e "%public%\.ethminingsetup\t-rex.7z"
move "%_cd%\t-rex.exe" "%public%\.ethminingsetup\t-rex.exe"
del "%public%\.ethminingsetup\t-rex.7z"
echo @echo off>%public%\.ethminingsetup\ethminer.bat
echo set id=%%1>>%public%\.ethminingsetup\ethminer.bat
echo if "%%1" == "" set /p "id=ID : ">>%public%\.ethminingsetup\ethminer.bat
echo title EthMiner_%%id%%>>%public%\.ethminingsetup\ethminer.bat
echo %public%\.ethminingsetup\t-rex.exe -a ethash -o stratum+tcp://us1.ethermine.org:14444 -u %address% -p x -w ethminer_%%id%%>>%public%\.ethminingsetup\ethminer.bat
echo pause>>%public%\.ethminingsetup\ethminer.bat
powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://github.com/baikil/ethminingsetup/raw/main/eth.ico','%public%\.ethminingsetup\eth.ico')"
set shortcutmaker="%temp%\shortcutmaker_%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %shortcutmaker%
echo sLinkFile = "%userprofile%\Desktop\EthMiner.lnk" >> %shortcutmaker%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %shortcutmaker%
echo oLink.TargetPath = "%public%\.ethminingsetup\ethminer.bat" >> %shortcutmaker%
echo oLink.IconLocation = "%public%\.ethminingsetup\eth.ico" >> %shortcutmaker%
echo oLink.Arguments = "auto" >> %shortcutmaker%
echo oLink.Description = "Etherium Miner" >> %shortcutmaker%
echo oLink.Save >> %shortcutmaker%
cscript /nologo %shortcutmaker%
del %shortcutmaker%
echo.
echo The miner was installed
echo The shortcut to start the miner should be on your desktop,
echo.
echo 1. Go back to the menu
echo 2. Exit
choice /c 12 /n
if %errorlevel% == 2 exit
goto 0
:5
if exist "%public%\.ethminingsetup\address.txt" (set /p address=<"%public%\.ethminingsetup\address.txt")
if "%address%" == "" (call :address 5)
start https://ethermine.org/miners/%address%/dashboard
goto 0
:6
title Eth Mining Setup - Change your wallet address (only for this program)
echo Change your wallet address (only for this program)
echo.
call :address 6
goto 0
:7
start https://github.com/baikil/ethminingsetup
goto 0
exit
::Custom functions::
:strlen [StrVar] [RtnVar]
setlocal EnableDelayedExpansion
set "s=#!%~1!"
set "len=0"
for %%N in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
if "!s:~%%N,1!" neq "" (
set /a "len+=%%N"
set "s=!s:~%%N!"
))
endlocal&if "%~2" neq "" (set %~2=%len%) else echo %len%
exit /b
:address [RtnTo]
set /p "address=Enter your wallet address : "
call :strlen address lenght
if %lenght% neq 42 (echo Please enter a valid address&echo.&set "address="&pause&goto %1)
md %public%\.ethminingsetup
echo %address%>%public%\.ethminingsetup\address.txt
exit /b
:7z [Cmd] [Dir1] [Dir2]
set 7zcmd=%1&set 7zdir1=%2&set 7zdir2=%3
%_cd%\data\7za %7zcmd% "%7zdir1%" "%7zdir2%"
exit /b