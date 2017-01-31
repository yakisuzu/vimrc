call :MAIN
exit /b

rem ------------------------------
:MAIN
  for %%i in (.\git\.gitconfig) do (
    call :MKLINK %%i
  )
  for %%i in (.\git\.gitattributes) do (
    call :MKLINK %%i
  )

  for %%i in (.\git\.gitconfig_*) do (
    call :MKCP %%i
  )
exit /b

rem ------------------------------
:MKLINK
  set f_link=%USERPROFILE%\%~x1
  set f_file=%~dpnx1

  if exist %f_link% ( del %f_link% )
  mklink %f_link% %f_file%

  set f_link=
  set f_file=
exit /b

rem ------------------------------
:MKCP
  set f_link=%USERPROFILE%\%~x1
  set f_file=%~dpnx1

  if exist %f_link% (
    echo exits %f_link%
  ) ELSE (
    echo copy %f_link%
    copy %f_file% %f_link%
  )

  set f_link=
  set f_file=
exit /b
