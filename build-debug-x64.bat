echo build-ultimate.bat: generating VMProtect Debug x64

SET ROOT_DIR=%~dp0

if exist "%ROOT_DIR%\bin" rmdir /q /s "%ROOT_DIR%\bin"
if exist "%ROOT_DIR%\tmp" rmdir /q /s "%ROOT_DIR%\tmp"

msbuild vmprotect.sln /p:Configuration=Debug /p:Platform=Win32 /t:VMProtectSDK
msbuild vmprotect.sln /p:Configuration=Debug /p:Platform=x64 /t:VMProtectSDK
msbuild vmprotect.sln /p:Configuration=Debug /p:Platform=x64 /t:VMProtectCon
msbuild vmprotect.sln /p:Configuration=Debug /p:Platform=x64 /t:VMProtect

windeployqt "%ROOT_DIR%\bin\64\Debug\VMProtect.exe"

copy "%ROOT_DIR%\bin\32\Debug\*" "%ROOT_DIR%\bin\64\Debug"
