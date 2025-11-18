@echo off

set _EXITCODE=0

if defined JAVA_HOME ( set "_JAVA_CMD=%JAVA_HOME%\bin\java.exe"
) else if defined JAVA_CMD ( set "_JAVA_CMD=%JAVA_CMD%"
) else ( set _JAVA_CMD=java.exe
)
if not exist "%_JAVA_CMD%" (
   echo Error: Java command not found 1>&2
   set _EXITCODE=1
   goto :eof
)

set _CJ_JAR=
if defined CJ_HOME (
   for /f %%f in ('dir /b /s "%CJ_HOME%\*.jar" 2^>NUL') do set "_CJ_JAR=%%f"
)
if not defined _CJ_JAR (
   echo Error: Connector/J library not found 1>&2
   set _EXITCODE=1
   goto :eof
)

set "_JAVA_MAIN=%~dp0\cj.java"
if not exist "%_JAVA_MAIN%" (
   echo Error: Java source "cj.java" not found in directory "%~dp0" 1>&2
   set _EXITCODE=1
   goto :eof
)
@rem echo "%_JAVA_CMD%" -cp "%_CJ_JAR%" "%%" 1>&2
call "%_JAVA_CMD%" -cp "%_CJ_JAR%" "%_JAVA_MAIN%"

:end
exit /b %_EXITCODE%
