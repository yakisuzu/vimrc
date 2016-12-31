call :MAIN
exit /b

rem ------------------------------
:MAIN
  for %%i in (.\lint\*) do (
    call :MKLINK %%i
  )
exit /b

rem ------------------------------
:MKLINK
  set f_link=%USERPROFILE%\%~nx1
  set f_file=%~dpnx1

  if exist %f_link% ( del %f_link% )
  mklink %f_link% %f_file%

  set f_link=
  set f_file=
exit /b
