call :MAIN
exit /b

rem ------------------------------
:MAIN
  rem mklink file
  for %%i in (.\vim\*vimrc.vim) do (
    call :MKLINK %%i
  )

  rem mklink dir
  for /F "usebackq" %%i in (`dir /AD /B /S .\vim\.vim\*`) do (
    call :MKLINK_DIR %%i
  )
exit /b

rem ------------------------------
:MKLINK
  set f_link=%USERPROFILE%\_%~n1
  set f_file=%~dpnx1

  if exist "%f_link%" ( del "%f_link%" )
  mklink "%f_link%" "%f_file%"

  set f_link=
  set f_file=
exit /b

rem ------------------------------
:MKLINK_DIR
  set f_link=%USERPROFILE%\.vim\%~n1
  set f_dir=%~f1

  if exist "%f_link%" ( rmdir "%f_link%" )
  mklink /D "%f_link%" "%f_dir%"

  set f_link=
  set f_dir=
exit /b
