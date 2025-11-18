@echo off
setlocal enabledelayedexpansion

@rem only for interactive debugging !
set _DEBUG=0

@rem #########################################################################
@rem ## Environment setup

set _EXITCODE=0

call :env
if not %_EXITCODE%==0 goto end

call :args %*
if not %_EXITCODE%==0 goto end

@rem #########################################################################
@rem ## Main

if %_HELP%==1 (
    call :help
    exit /b !_EXITCODE!
)
if %_CLEAN%==1 (
    call :clean
    if not !_EXITCODE!==0 goto end
)
if %_BUILD%==1 (
    call :build
    if not !_EXITCODE!==0 goto end
)
if %_RUN%==1 (
    call :run%_INSTRUMENTED%
    if not !_EXITCODE!==0 goto end
)
goto end

@rem #########################################################################
@rem ## Subroutines

@rem output parameters: _DEBUG_LABEL, _ERROR_LABEL, _WARNING_LABEL
@rem                    _CLASSES_DIR, _TARGET_DIR
:env
set _BASENAME=%~n0
set "_ROOT_DIR=%~dp0"

call :env_colors
set _DEBUG_LABEL=%_NORMAL_BG_CYAN%[%_BASENAME%]%_RESET%
set _ERROR_LABEL=%_STRONG_FG_RED%Error%_RESET%:
set _WARNING_LABEL=%_STRONG_FG_YELLOW%Warning%_RESET%:

set "_MSVS_HOME=C:\Program Files\Microsoft Visual Studio\2022\Community"

if not exist "%_MSVS_HOME%\MSBuild\Current\Bin\amd64\MSBuild.exe" (
    echo %_ERROR_LABEL% Failed 1>&2
    set _EXITCODE=1
    goto :eof
)
set "_MSBUILD_CMD=%_MSVS_HOME%\MSBuild\Current\Bin\amd64\MSBuild.exe"

set _SLN_FILE=
set _PROJECT_NAME=
for /f "delims=" %%f in ('dir /b /s *.sln') do (
    set "_SLN_FILE=%%f"
    set "_PROJECT_NAME=%%~nf"
)
if not defined _SLN_FILE (
    echo %_ERROR_LABEL% Solution file not found 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

:env_colors
@rem ANSI colors in standard Windows 10 shell
@rem see https://gist.github.com/mlocati/#file-win10colors-cmd

@rem normal foreground colors
set _NORMAL_FG_BLACK=[30m
set _NORMAL_FG_RED=[31m
set _NORMAL_FG_GREEN=[32m
set _NORMAL_FG_YELLOW=[33m
set _NORMAL_FG_BLUE=[34m
set _NORMAL_FG_MAGENTA=[35m
set _NORMAL_FG_CYAN=[36m
set _NORMAL_FG_WHITE=[37m

@rem normal background colors
set _NORMAL_BG_BLACK=[40m
set _NORMAL_BG_RED=[41m
set _NORMAL_BG_GREEN=[42m
set _NORMAL_BG_YELLOW=[43m
set _NORMAL_BG_BLUE=[44m
set _NORMAL_BG_MAGENTA=[45m
set _NORMAL_BG_CYAN=[46m
set _NORMAL_BG_WHITE=[47m

@rem strong foreground colors
set _STRONG_FG_BLACK=[90m
set _STRONG_FG_RED=[91m
set _STRONG_FG_GREEN=[92m
set _STRONG_FG_YELLOW=[93m
set _STRONG_FG_BLUE=[94m
set _STRONG_FG_MAGENTA=[95m
set _STRONG_FG_CYAN=[96m
set _STRONG_FG_WHITE=[97m

@rem strong background colors
set _STRONG_BG_BLACK=[100m
set _STRONG_BG_RED=[101m
set _STRONG_BG_GREEN=[102m
set _STRONG_BG_YELLOW=[103m
set _STRONG_BG_BLUE=[104m

@rem we define _RESET in last position to avoid crazy console output with type command
set _BOLD=[1m
set _UNDERSCORE=[4m
set _INVERSE=[7m
set _RESET=[0m
goto :eof

@rem input parameter: %*
:args
set _CLEAN=0
set _BUILD=0
set _HELP=0
set _RUN=0
set _VERBOSE=0
set __N=0
:args_loop
set "__ARG=%~1"
if not defined __ARG (
    if !__N!==0 set _HELP=1
    goto args_done
)
if "%__ARG:~0,1%"=="-" (
    @rem option
    if "%__ARG%"=="-debug" ( set _DEBUG=1
    ) else if "%__ARG%"=="-help" ( set _HELP=1
    ) else if "%__ARG%"=="-verbose" ( set _VERBOSE=1
    ) else (
        echo %_ERROR_LABEL% Unknown option "%__ARG%" 1>&2
        set _EXITCODE=1
        goto args_done
    )
) else (
    @rem subcommand
    if "%__ARG%"=="clean" ( set _CLEAN=1
    ) else if "%__ARG%"=="build" ( set _BUILD=1
    ) else if "%__ARG%"=="help" ( set _HELP=1
    ) else if "%__ARG%"=="run" ( set _BUILD=1& set _RUN=1
    ) else (
        echo %_ERROR_LABEL% Unknown subcommand "%__ARG%" 1>&2
        set _EXITCODE=1
        goto args_done
    )
    set /a __N+=1
)
shift
goto args_loop
:args_done
set _STDERR_REDIRECT=2^>NUL
if %_DEBUG%==1 set _STDERR_REDIRECT=

if %_DEBUG%==1 ( set _VERBOSITY=normal
) else if %_VERBOSE%==1 ( set _VERBOSITY=minimal
) else ( set _VERBOSITY=quiet
)
set _MSBUILD_OPTS=-nologo -verbosity:%_VERBOSITY%

if %_DEBUG%==1 (
    echo %_DEBUG_LABEL% Options    : _VERBOSE=%_VERBOSE% 1>&2
    echo %_DEBUG_LABEL% Subcommands: _CLEAN=%_CLEAN% _BUILD=%_BUILD% _RUN=%_RUN% 1>&2
    echo %_DEBUG_LABEL% Variables  : "_MSVS_HOME=%_MSVS_HOME%" 1>&2
)
goto :eof

:help
if %_VERBOSE%==1 (
    set __BEG_P=%_STRONG_FG_CYAN%
    set __BEG_O=%_STRONG_FG_GREEN%
    set __BEG_N=%_NORMAL_FG_YELLOW%
    set __END=%_RESET%
) else (
    set __BEG_P=
    set __BEG_O=
    set __BEG_N=
    set __END=
)
echo Usage: %__BEG_O%%_BASENAME% { ^<option^> ^| ^<subcommand^> }%__END%
echo.
echo   %__BEG_P%Options:%__END%
echo     %__BEG_O%-debug%__END%           print commands executed by this script
echo     %__BEG_O%-verbose%__END%         print progress messages
echo.
echo   %__BEG_P%Subcommands:%__END%
echo     %__BEG_O%clean%__END%            delete generated files
echo     %__BEG_O%build%__END%            compile C# source files
echo     %__BEG_O%help%__END%             print this help message
echo     %__BEG_O%run%__END%              execute application "%_PROJECT_NAME%"
goto :eof

:clean
set __MSBUILD_OPTS=%_MSBUILD_OPTS% -t:Clean

if %_DEBUG%==1 ( echo %_DEBUG_LABEL% "!_MSBUILD_CMD:%_MSVS_HOME%=%%_MSVS_HOME%%!" %__MSBUILD_OPTS% "%_SLN_FILE%" 1>&2
) else if %_VERBOSE%==1 ( echo Clean solution 1>&2
)
call "%_MSBUILD_CMD%" %__MSBUILD_OPTS% "%_SLN_FILE%"
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to execute target "Clean" 1>&2
    set _EXITCODE=1
    goto :eof
)
@rem we must run "msbuild -t:Restore" if we remove these 2 directories.
call :rmdir "%_ROOT_DIR%%_PROJECT_NAME%\Bin"
call :rmdir "%_ROOT_DIR%%_PROJECT_NAME%\Obj"
goto :eof

@rem input parameter: %1=directory path
:rmdir
set "__DIR=%~1"
if not exist "%__DIR%\" goto :eof
if %_DEBUG%==1 ( echo %_DEBUG_LABEL% rmdir /s /q "%__DIR%" 1>&2
) else if %_VERBOSE%==1 ( echo Delete directory "!__DIR:%_ROOT_DIR%=!" 1>&2
)
rmdir /s /q "%__DIR%"
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to delete directory "!__DIR:%_ROOT_DIR%=!" 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

:build
if %_DEBUG%==1 ( echo %_DEBUG_LABEL% "!_MSBUILD_CMD:%_MSVS_HOME%=%%_MSVS_HOME%%!" -nologo -t:Restore 1>&2
) else if %_VERBOSE%==1 ( echo Run a NuGet package restore 1>&2
)
call "%_MSBUILD_CMD%" %_MSBUILD_OPTS% -t:Restore

@rem https://learn.microsoft.com/en-us/visualstudio/msbuild/common-msbuild-project-properties
@rem e.g. -property:Configuration=Debug;Platform=AnyCPU;WarningLevel=2;OutDir=bin\Debug\
set __MSBUILD_PROPERTIES=-p:Configuration=Debug -p:Platform="Any CPU"

set __MSBUILD_OPTS=%_MSBUILD_OPTS% -t:Build %__MSBUILD_PROPERTIES%

if %_DEBUG%==1 ( echo %_DEBUG_LABEL% call "!_MSBUILD_CMD:%_MSVS_HOME%=%%_MSVS_HOME%%!" %__MSBUILD_OPTS% "%_SLN_FILE%" 1>&2
) else if %_VERBOSE%==1 ( echo Generate solution 1>&2
)
call "%_MSBUILD_CMD%" %__MSBUILD_OPTS% "%_SLN_FILE%"

goto :eof

:run
set __EXE_FILE=
for /f "delims=" %%f in ('dir /b /s "%_ROOT_DIR%%_PROJECT_NAME%\bin\*.exe" 2^>NUL') do set "__EXE_FILE=%%f"

if not defined __EXE_FILE (
    echo %_ERROR_LABEL% Executable "%_PROJECT_NAME%.exe" not found 1>&2
    set _EXITCODE=1
    goto :eof
)
if %_DEBUG%==1 ( echo %_DEBUG_LABEL% Execute application "!__EXE_FILE:%_ROOT_DIR%=!" 1>&2
) else if %_VERBOSE%==1 ( echo Execute application "!__EXE_FILE:%_ROOT_DIR%=!" 1>&2
)
call "%__EXE_FILE%"
goto :eof

@rem #########################################################################
@rem ## Cleanups

:end
if %_DEBUG%==1 echo %_DEBUG_LABEL% _EXITCODE=%_EXITCODE% 1>&2
exit /b %_EXITCODE%
