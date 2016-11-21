@echo off
powershell -ExecutionPolicy unrestricted -Command "[Environment]::GetEnvironmentVariable('PATH','Machine').Replace(';',\"`n\")"
