@echo off
pushd %~dp0

echo --------------------
echo init bash
call .\init_script\bash.bat

echo --------------------
echo init git
call .\init_script\git.bat

echo --------------------
echo init vim
call .\init_script\vim.bat

popd
pause
