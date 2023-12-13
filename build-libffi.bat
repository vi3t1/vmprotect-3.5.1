echo build-libffi.bat: generating libffi-x86

SET ROOT_DIR=%~dp0
set LIBFFI_ROOT=%ROOT_DIR%\third-party\libffi
set LIBFFI_BUILD=%LIBFFI_ROOT%\build

if exist "%LIBFFI_BUILD%" rmdir /q /s "%LIBFFI_BUILD%"
if exist "%LIBFFI_ROOT%\win32\vs16_x86\Debug" rmdir /q /s "%LIBFFI_ROOT%\win32\vs16_x86\Debug"
if exist "%LIBFFI_ROOT%\win32\vs16_x86\Release" rmdir /q /s "%LIBFFI_ROOT%\win32\vs16_x86\Release"
if exist "%LIBFFI_ROOT%\win32\vs16_x64\x64\Debug" rmdir /q /s "%LIBFFI_ROOT%\win32\vs16_x64\x64\Debug"
if exist "%LIBFFI_ROOT%\win32\vs16_x64\x64\Release" rmdir /q /s "%LIBFFI_ROOT%\win32\vs16_x64\x64\Release"

mkdir "%LIBFFI_BUILD%"

msbuild "%LIBFFI_ROOT%\win32\vs16_x86\libffi-msvc.sln" /p:Configuration=Debug /p:Platform=Win32
msbuild "%LIBFFI_ROOT%\win32\vs16_x86\libffi-msvc.sln" /p:Configuration=Release /p:Platform=Win32

msbuild "%LIBFFI_ROOT%\win32\vs16_x64\libffi-msvc.sln" /p:Configuration=Debug /p:Platform=x64
msbuild "%LIBFFI_ROOT%\win32\vs16_x64\libffi-msvc.sln" /p:Configuration=Release /p:Platform=x64

copy "%LIBFFI_ROOT%\include\ffi.h" "%LIBFFI_BUILD%"
copy "%LIBFFI_ROOT%\src\x86\ffitarget.h" "%LIBFFI_BUILD%"

powershell -Command "(gc -Encoding ASCII '%LIBFFI_BUILD%\ffi.h') -replace '#include <ffitarget.h>', '#include \"ffitarget.h\"' | Out-File -Encoding ASCII '%LIBFFI_BUILD%\ffi.h'"

copy "%LIBFFI_ROOT%\win32\vs16_x86\Debug\libffi.lib" "%LIBFFI_BUILD%\libffi32d.lib"
copy "%LIBFFI_ROOT%\win32\vs16_x86\Release\libffi.lib" "%LIBFFI_BUILD%\libffi32.lib"
copy "%LIBFFI_ROOT%\win32\vs16_x64\x64\Debug\libffi.lib" "%LIBFFI_BUILD%\libffi64d.lib"
copy "%LIBFFI_ROOT%\win32\vs16_x64\x64\Release\libffi.lib" "%LIBFFI_BUILD%\libffi64.lib"
