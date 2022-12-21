@echo off

:START
rem Prompt the user for the URL and store the input in the 'url' variable
echo "Please Enter URL:"
set /p url=""

rem Check if the 'url' variable is empty
if "%url%" == "" (
  echo "Error: No URL was provided."
  pause
  GOTO START
)

rem Prompt the user for the name of the executable and the silent switch and store the input in the 'name_and_switch' variable
echo "Please Enter the name of the executable and the silent switch (e.g. 'setup.exe /silent'):"
set /p name_and_switch=""

rem Check if the 'name_and_switch' variable is empty
if "%name_and_switch%" == "" (
  echo "Error: No executable name and silent switch were provided."
  pause
  exit
)

rem Split the 'name_and_switch' variable into two separate variables: 'name' and 'switch'
for /f "tokens=1* delims= " %%a in ("%name_and_switch%") do (
  set "name=%%a"
  set "switch=%%b"
)

rem Change the current directory to the directory you want install from
cd INSTALL_DIRECTORY

rem Download the file from the URL and save it with the specified name
powershell -Command "Invoke-webrequest %url% -outfile  %name%"

rem Check if the file was downloaded successfully
if not exist "%name%" (
  echo "Error: Failed to download file from the URL."
  pause
  exit
)

rem Run the executable with the specified switch
start %name% %switch%