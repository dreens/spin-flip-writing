:: Export all the Figures from inkscape to PNG for latex to compile
:: To run this, double click it or navigate to the folder in CMD and type the filename.

:: This does something useful according to http://steve-jansen.github.io/guides/windows-batch-scripting/part-2-variables.html:
SETLOCAL ENABLEEXTENSIONS

:: Save the name of this script (referenced here as the name of the 0th command line argument) to the variable "me":
SET me=%~n0

:: Save the path to the file where the script lives in the variable "parent":
SET parent=%~dp0

:: Turn off script output:
@echo off

:: execute inkscape shortcut:
SET ink="%ProgramFiles(x86)%\Inkscape\inkscape"

%ink% -f "%parent%\Blocking\figmakeblocking.svg" -e "%parent%\Blocking\blocking_out.png"
%ink% -f "%parent%\Geometry\Geometry_panels.svg" -e "%parent%\Geometry\geometry_out.png"
%ink% -f "%parent%\LossSurfaces\Loss_Surfaces_Pins.svg" -e "%parent%\LossSurfaces\losssurfaces_out.png"
%ink% -f "%parent%\VWFig\tim-style-by-dave-1hz.svg" -e "%parent%\VWFig\vwfig_out.png"
%ink% -f "%parent%\MWSpec\Spec_prep_Inkscape.svg" -e "%parent%\MWSpec\mwspec_out.png"






:: Notes on DOS scripting:
::
:: "::" is a sort-of comment. The "REM" command is more official.
REM I can put things with impunity because I began this line with REM.
::
:: Type "/?" after an operator to learn about it. e.x. "echo /?" or "set /?"
:: 
:: Set /? has a useful list of sort-of variables like %cd% and %time% and %random%.