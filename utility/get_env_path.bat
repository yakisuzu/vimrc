@echo off
echo ====================
echo Machine setting
powershell -ExecutionPolicy unrestricted -Command "[Environment]::GetEnvironmentVariable('PATH', [EnvironmentVariableTarget]::Machine).Replace(';',\"`n\")"
echo.
echo ====================
echo User setting
powershell -ExecutionPolicy unrestricted -Command "[Environment]::GetEnvironmentVariable('PATH', [EnvironmentVariableTarget]::User).Replace(';',\"`n\")"

