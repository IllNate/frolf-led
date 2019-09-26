@ECHO OFF
::get project name
for /r %%i in (*.GTO) DO (SET proj=%%~ni)
::get version number
set /p ver="Enter version number: " %=%

::set contact info
set cname=Nathan Illerbrun
set email=nathan@echoflexsolutions.com
set tnum=778-733-0111 ext 749

::set board specs
set bmat=FR4
set blayer=2
set bthick=62mil
set bfcopper=1 oz
set bicopper=0.5oz
set bfinish=Lead Free HASL
set bsmask=Green
set bsilk=White

:CONFIRM

echo Project name:     %proj%
echo Version number:   %ver%
echo Contact name:     %cname%
echo Contact email:    %email%
echo Contact number:   %tnum%
echo --------------------------------
echo Material:         %bmat%
echo # of Layers:      %blayer%
echo Thickness:        %bthick%
echo Finish Copper:    %bfcopper%
echo Internal Copper:  %bicopper%
echo Board Finish:     %bfinish%
echo Soldermask Color: %bsmask%
echo Silkscreen Color: %bsilk%
echo
if %blayer% EQ 2(
echo Stackup (~%bthick%):
echo      Top Silk
echo      Top Soldermask
echo      Top Layer    (%bfcopper%)
echo      ----Core----
echo      Bottom Layer (%bfcopper%)
echo      Bottom Soldermask
echo      Bottom Silkscreen
)
if %blayer% EQ 4(
echo Stackup (~%bthick%):
echo      Top Silk
echo      Top Soldermask
echo      Top Layer    (%bfcopper%)
echo      --PrePreg---
echo      Middle Layer (%bicopper%)
echo      ----Core----
echo      Middle Layer (%bicopper%)
echo      --PrePreg---
echo      Bottom Layer (%bfcopper%)
echo      Bottom Soldermask
echo      Bottom Silkscreen
) else (
echo Stackup (~%bthick%):
echo      Top Silk
echo      Top Soldermask
echo      Top Layer    (%bfcopper%)
echo      --PrePreg---
echo      Middle Layer (%bicopper%)
echo          ...
echo      ----Core----
echo      Middle Layer (%bicopper%)
echo      --PrePreg---
echo      Bottom Layer (%bfcopper%)
echo      Bottom Soldermask
echo      Bottom Silkscreen
)
set accept=n
set /p accept="Is this correct (y/[n])? " %=%
IF /I %accept% EQU y GOTO ACCEPTED

::echo Enter new options or press enter to leave as is:
set /p proj="Enter project name: " %=%
set /p ver="Enter version number: " %=%
set /p cname="Enter contact name: " %=%
set /p email="Enter email: " %=%
set /p tnum="Enter contact number: " %=%
set /p bmat="Enter PCB Material: " %=%
set /p blayer="Enter PCB Layers (1-4): " %=%
set /p bthick="Enter PCB Thickness: " %=%
set /p bfcopper="Enter Finish Copper: " %=%
set /p bicopper="Enter Internal Copper: " %=%
set /p bfinish="Enter Board Finish: " %=%
set /p bsmask="Enter Soldermask Color: " %=%
set /p bsilk="Enter Silkscreen Color: " %=%

GOTO CONFIRM

:ACCEPTED

set readmefile=%proj%_V%ver%_README.txt

@echo %proj% %ver%>%readmefile%
@echo ECHOFLEX SOLUTIONS>>%readmefile%
@echo Date (DD/MM/YYYY):%date%>>%readmefile%
@echo.>>%readmefile%
@echo Specifications for the board:>>%readmefile%
@echo.>>%readmefile%
@echo    %blayer%-layer>>%readmefile%
@echo    %bmat%>>%readmefile%
@echo    %bfinish%>>%readmefile%
@echo    %bsmask% solder mask>>%readmefile%
@echo    %bsilk% silkscreen on TOP and BOTTOM>>%readmefile%
@echo    %bmasktype%>>%readmefile%
@echo.>>%readmefile%
@echo The Gerber files included in this zip:>>%readmefile%
@echo.>>%readmefile%
@echo    File Name (description):>>%readmefile%
@echo    %proj%_V%ver%.apr (Layer 2 Aperture Information)>>%readmefile%
@echo    %proj%_V%ver%.DRL (NC Drill Binary Data)>>%readmefile%
@echo    %proj%_V%ver%.DRR (NC Drill Report File)>>%readmefile%
if %blayer% GEQ 3 echo    %proj%_V%ver%.G1  (top-middle layer)>>%readmefile%
if %blayer% GEQ 4 echo    %proj%_V%ver%.G1  (bottom-middle layer)>>%readmefile%
@echo    %proj%_V%ver%.GBL (Bottom Layer (solder side)>>%readmefile%
@echo    %proj%_V%ver%.GBO (Top Layer Silkscreen/Nomenclature)>>%readmefile%
@echo    %proj%_V%ver%.GBP (Bottom Layer Paste)>>%readmefile%
@echo    %proj%_V%ver%.GBS (Bottom Layer Solder Mask)>>%readmefile%
@echo    %proj%_V%ver%.GD1 (Drill Drawing Layer Pair)>>%readmefile%
@echo    %proj%_V%ver%.GM1 (Board Outline, Mechanical Layer)>>%readmefile%
@echo    %proj%_V%ver%.GG1 (Drill Guide Layer Pair)>>%readmefile%
@echo    %proj%_V%ver%.GTL (Top Layer (component side)>>%readmefile%
@echo    %proj%_V%ver%.GTO (Top Layer Silkscreen/Nomenclature)>>%readmefile%
@echo    %proj%_V%ver%.GTP (Top Layer Paste)>>%readmefile%
@echo    %proj%_V%ver%.GTS (Top Layer Solder Mask)>>%readmefile%
@echo    %proj%_V%ver%.TXT (Drill Tool Information)>>%readmefile%
@echo.>>%readmefile%
@echo Any technical questions can be referred to:>>%readmefile%
@echo %cname%>>%readmefile%
@echo %email%>>%readmefile%
@echo %tnum%>>%readmefile%

mkdir tempfolder

xcopy %proj%.apr tempfolder\%proj%_V%ver%.apr* /Q /Y
xcopy %proj%.DRL tempfolder\%proj%_V%ver%.DRL* /Q /Y
xcopy %proj%.DRR tempfolder\%proj%_V%ver%.DRR* /Q /Y
xcopy %proj%.GBL tempfolder\%proj%_V%ver%.GBL* /Q /Y
xcopy %proj%.GBO tempfolder\%proj%_V%ver%.GBO* /Q /Y
xcopy %proj%.GBP tempfolder\%proj%_V%ver%.GBP* /Q /Y
xcopy %proj%.GBS tempfolder\%proj%_V%ver%.GBS* /Q /Y
xcopy %proj%.GD1 tempfolder\%proj%_V%ver%.GD1* /Q /Y
xcopy %proj%.GM1 tempfolder\%proj%_V%ver%.GM1* /Q /Y
xcopy %proj%.GG1 tempfolder\%proj%_V%ver%.GG1* /Q /Y
xcopy %proj%.GTL tempfolder\%proj%_V%ver%.GTL* /Q /Y
xcopy %proj%.GTO tempfolder\%proj%_V%ver%.GTO* /Q /Y
xcopy %proj%.GTP tempfolder\%proj%_V%ver%.GTP* /Q /Y
xcopy %proj%.GTS tempfolder\%proj%_V%ver%.GTS* /Q /Y
xcopy %proj%.TXT tempfolder\%proj%_V%ver%_NCDrill.TXT* /Q /Y
xcopy %readmefile% tempfolder\%readmefile%* /Q /Y
if %blayer% GEQ 3 xcopy %proj%.G1 tempfolder\%proj%_V%ver%.G1* /Q /Y
if %blayer% GEQ 4 xcopy %proj%.G2 tempfolder\%proj%_V%ver%.G2* /Q /Y

cd tempfolder

7z a -tzip %proj%_V%ver%.zip *.* > nul

cd ..

xcopy tempfolder\%proj%_V%ver%.zip > nul

rd /S /Q tempfolder

PAUSE
