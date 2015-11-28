@echo off
powershell -ExecutionPolicy unrestricted -Command "[Environment]::GetEnvironmentVariable('PATH','Machine')|sed -e 's/;/\n/g'"
