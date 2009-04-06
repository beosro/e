@echo off

call :BUILD libtommath\libtommath.sln
echo %RET%
call :BUILD libtomcrypt\libtomcrypt.sln
echo %RET%
call :BUILD curl\lib\curllib.sln
echo %RET%
call :BUILD metakit\win\msvc90\mksrc.sln
echo %RET%
call :BUILD pcre\pcre.sln
echo %RET%
call :BUILD tinyxml\tinyxml.sln
echo %RET%

goto :EOF

REM Using a .sln might be faster, but don't want to keep all the .vcprojs up-to-date
pushd wxwidgets\build\msw
nmake -f makefile.vc BUILD=debug UNICODE=1
popd

goto :EOF


REM **** Subroutines start here ****

:BUILD
setlocal
REM Args are: path_to_sln, [config_to_build=DEBUG]
set CONFIG=%2
if {%CONFIG%}=={} set CONFIG="DEBUG"

echo Building %1...
devenv %1 /Build %CONFIG% > build_logs\%~n1.log
set RET=%ERRORLEVEL%
taskkill.exe /f /t /im mspdbsrv.exe > nul 2> nul
endlocal & set RET=%RET%
goto :EOF