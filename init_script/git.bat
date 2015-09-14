for %%i in (.\git\*) do (
  call :MKLINK %%i
)
exit /b

:MKLINK
  set f_link=%HOMEPATH%\%~x1
  set f_file=%~dpnx1

  if exist %f_link% ( del %f_link% )
  mklink %f_link% %f_file%

  set f_link=
  set f_file=
exit /b
