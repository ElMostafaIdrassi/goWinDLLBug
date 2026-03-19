@echo off
set PATH=C:\x86_64-15.2.0-release-posix-seh-msvcrt-rt_v13-rev0\mingw64\bin;%PATH%
set CGO_ENABLED=1

echo === This FAILS (no -o flag, trailing dot in LIBRARY directive) ===
go build -buildmode=c-shared .
echo.

echo === This WORKS (explicit -o with .dll extension) ===
go build -o godllbug.dll -buildmode=c-shared .
echo.

if exist godllbug.dll echo SUCCESS: godllbug.dll created
if exist godllbug.dll del /f godllbug.dll
if exist godllbug.h del /f godllbug.h
