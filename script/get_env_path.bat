@echo off
powershell -ExecutionPolicy unrestricted -Command "[Environment]::GetEnvironmentVariable('PATH','Machine')|grep -e 's/;/\n/g'"
