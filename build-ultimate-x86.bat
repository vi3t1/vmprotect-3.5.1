echo build-ultimate.bat: generating VMProtect Ultimate x86

SET ROOT_DIR=%~dp0

if exist "%ROOT_DIR%\bin" rmdir /q /s "%ROOT_DIR%\bin"
if exist "%ROOT_DIR%\tmp" rmdir /q /s "%ROOT_DIR%\tmp"

msbuild vmprotect.sln /p:Configuration=Ultimate /p:Platform=Win32 /t:VMProtectSDK
msbuild vmprotect.sln /p:Configuration=Ultimate /p:Platform=x64 /t:VMProtectSDK
msbuild vmprotect.sln /p:Configuration=Ultimate /p:Platform=Win32 /t:VMProtectCon
msbuild vmprotect.sln /p:Configuration=Ultimate /p:Platform=Win32 /t:VMProtect

windeployqt "%ROOT_DIR%\bin\32\Ultimate\VMProtect.exe"

copy "%ROOT_DIR%\bin\32\Release\*" "%ROOT_DIR%\bin\32\Ultimate"
copy "%ROOT_DIR%\bin\64\Release\*" "%ROOT_DIR%\bin\32\Ultimate"
