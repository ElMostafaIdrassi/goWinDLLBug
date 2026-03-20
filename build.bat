@echo off
set PATH=C:\x86_64-15.2.0-release-posix-seh-msvcrt-rt_v13-rev0\mingw64\bin;%PATH%
set CGO_ENABLED=1

echo === This FAILS (no -o flag, trailing dot in LIBRARY directive) ===
go build -buildmode=c-shared ./cmd/mypackage
echo.

echo === Same failure, but preserving linker temp files in .\linktmp ===
if not exist linktmp mkdir linktmp
go build -buildmode=c-shared -ldflags="-tmpdir=%cd%\linktmp" ./cmd/mypackage
echo See linktmp\export_file.def for the broken .def file
echo.

echo === This WORKS (explicit -o with .dll extension) ===
go build -o mypackage.dll -buildmode=c-shared ./cmd/mypackage
echo.

if exist mypackage.dll echo SUCCESS: mypackage.dll created
if exist mypackage.dll del /f mypackage.dll
if exist mypackage.h del /f mypackage.h
