# <span id="top">Playing with MySQL on Windows</span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;">
    <a href="https://dev.mysql.com/" rel="external"><img style="border:0;width:120px;" src="./docs/images/logo-mysql.png" alt="MySQL project"/></a>
  </td>
  <td style="border:0;padding:0;vertical-align:text-top;">
    This repository gathers <a href="https://dev.mysql.com/" rel="external">MySQL</a> code examples coming from various websites or written by ourself.<br/>
    In particular it includes several build scripts (<a href="https://www.gnu.org/software/bash/manual/bash.html" rel="external">bash scripts</a>, <a href="https://en.wikibooks.org/wiki/Windows_Batch_Scripting" rel="external">batch files</a>, <a href="https://makefiletutorial.com/" rel="external">Make scripts</a>) for experimenting with the <a href="https://dev.mysql.com/" rel="external">MySQL</a> system on a Windows machine.
  </td>
  </tr>
</table>

[Ada][ada_examples], [Akka][akka_examples], [C++][cpp_examples], [COBOL][cobol_examples], [Component Pascal][component_pascal_examples], [Dafny][dafny_examples], [Dart][dart_examples], [Deno][deno_examples], [Docker][docker_examples], [Erlang][erlang_examples], [Flix][flix_examples], [Go][golang_examples], [GraalVM][graalvm_examples], [Haskell][haskell_examples], [Kotlin][kotlin_examples], [LLVM][llvm_examples], [Modula-2][m2_examples], [Node.js][nodejs_examples], [Rust][rust_examples], [Scala 3][scala3_examples], [Spark][spark_examples], [Spring][spring_examples], [Standard ML][sml_examples], [TruffleSqueak][trufflesqueak_examples], [WiX Toolset][wix_examples] and [Zig][zig_examples] are other topics we are continuously monitoring.

> **&#9755;** Read the document <a href="https://www.oracle.com/mysql/what-is-mysql/" rel="external">"MySQL: Understanding What It Is and How It’s Used"</a> for an overview of the major features of the MySQL database management system.

## <span id="proj_deps">Project dependencies</span> [**&#x25B4;**](#top)

This project depends on the following external software for the **Microsoft Windows** platform:

- [Git 2.52][git_releases] ([*release notes*][git_relnotes])
- [MysQL 9.5][mysql_releases] ([*release notes*][mysql_relnotes])

Optionally one may also install the following software:

- [Apache Maven 3.9][apache_maven] ([requires Java 8+][apache_maven_history])  ([*release notes*][apache_maven_relnotes])
- [Connector/J 9.5][connector_j_downloads] ([*release notes*][connector_j_relnotes]) &ndash; Java Driver
for MySQL
- [Connector/NET 9.5][connector_net_downloads] ([*release notes*][connector_net_relnotes]) &ndash; .NET Driver for MySQL.
- [Connector/ODBC 9.5][connector_odbc_downloads] ([*release notes*][connector_odbc_relnotes])
- [ConEmu 2023][conemu_downloads] ([*release notes*][conemu_relnotes])
- [MySQL Workbench 8.0][mysql_workbench_releases] <sup id="anchor_01">[1](#footnote_01)</sup> ([*release notes*][mysql_workbench_relnotes])
- [Temurin OpenJDK 17 LTS][temurin_openjdk17] ([*release notes*][temurin_openjdk17_relnotes], [*bug fixes*][temurin_openjdk17_bugfixes])
- [Visual Studio Code 1.106][vscode_downloads] ([*release notes*][vscode_relnotes])
- [Visual Studio Community 2022][vs2022_downloads] ([*release notes*][vs2022_relnotes])

> **&#9755;** ***Installation policy***<br/>
> When possible we install software from a [Zip archive][zip_archive] rather than via a [Windows installer][windows_installer]. In our case we defined **`C:\opt\`** as the installation directory for optional software tools (*in reference to* the [`/opt/`][unix_opt] directory on Unix).

For instance our development environment looks as follows (*November 2025*) <sup id="anchor_02">[2](#footnote_02)</sup>:

<pre style="font-size:80%;">
C:\opt\ConEmu\                     <i>( 26 MB)</i>
C:\opt\Git\                        <i>(387 MB)</i>
C:\opt\mysql\                      <i>(1.0 GB)</i>
C:\opt\mysql-connector-j\          <i>( 17 MB)</i>
C:\opt\mysql-connector-net\        <i>(  2 MB)</i>
C:\opt\mysql-connector-odbc\       <i>( 86 MB)</i>
C:\opt\mysql-workbench\            <i>(1.0 GB)</i>
C:\opt\VSCode\                     <i>(341 MB)</i>
</pre>
<!--
C:\opt\jdk-temurin-11.0.23_9\      <i>(302 MB)</i>
-->

> **:mag_right:** [Git for Windows][git_downloads] provides a BASH emulation used to run [**`git`**][git_cli] from the command line (as well as over 250 Unix commands like [**`awk`**][man1_awk], [**`diff`**][man1_diff], [**`file`**][man1_file], [**`grep`**][man1_grep], [**`more`**][man1_more], [**`mv`**][man1_mv], [**`rmdir`**][man1_rmdir], [**`sed`**][man1_sed] and [**`wc`**][man1_wc]).

## <span id="structure">Directory structure</span> [**&#x25B4;**](#top)

This project has following directory structure :

<pre style="font-size:80%;">
bin\
dba\{<a href="./dba/README.md">README.md</a>, <a href="./dba/my.ini">my.ini</a>}
docs\
examples\{<a href="examples/README.md">README.md</a>, <a href="examples/Tutorial1/">Tutorial1</a>, ..}
README.md
<a href="RESOURCES.md">RESOURCES.md</a>
<a href="setenv.bat">setenv.bat</a>
</pre>

where

- directory [**`bin\`**](bin/) contains utility batch files.
- directory [**`dba\`**](dba/) gathers admin information for managing our [MySQL] installation.
- directory [**`docs\`**](docs/) contains [MySQL] related papers/articles.
- directory [**`examples\`**](examples/) contains [MySQL] examples grabbed from various websites (see file [**`examples\README.md`**](examples/README.md)).
- file **`README.md`** is the [Markdown][github_markdown] document for this page.
- file [**`RESOURCES.md`**](RESOURCES.md) gathers [MySQL] related informations.
- file [**`setenv.bat`**](setenv.bat) is the batch command for setting up our environment.

We also define a virtual drive &ndash; e.g. drive **`T:`** &ndash; in our working environment in order to reduce/hide the real path of our project directory (see article ["Windows command prompt limitation"][windows_limitation] from Microsoft Support).
> **:mag_right:** We use the Windows external command [**`subst`**][windows_subst] to create virtual drives; for instance:
>
> <pre style="font-size:80%;">
> <b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/subst">subst</a> T: <a href="https://docs.microsoft.com/en-us/windows/deployment/usmt/usmt-recognized-environment-variables#bkmk-2">%USERPROFILE%</a>\workspace\mysql-examples</b>
> </pre>

In the next section we give a brief description of the [batch files][windows_batch_file] present in this project.

<!--=======================================================================-->

## <span id="commands">Batch commands</span> [**&#x25B4;**](#top)

### [**`setenv.bat`**](setenv.bat)

We execute command [**`setenv.bat`**](setenv.bat) once to setup our development environment; it makes external tools such as [**`git.exe`**][git_userguide], [**`mysqld.exe`**][mysqld_cli], [**`mysql.exe`**][mysql_cli] and [**`sh.exe`**][sh_cli] directly available from the Windows command prompt (see section [**Project dependencies**](#proj_deps)).

<pre style="font-size:80%;">
<b>&gt; <a href="./setenv.bat">setenv</a> -verbose</b>
Tool versions:
   mysql 9.5.0, java 17.0.17, cj 9.5.0, cnet 9.5.0.0,
   make 4.4.1, gcc 15.2.0,
   git 2.52.0, diff 3.12, bash 5.2.37(1)
Tool paths:
   C:\opt\mysql\bin\mysql.exe
   C:\opt\jdk-temurin-17.0.17_10\bin\java.exe
   C:\opt\msys64\usr\bin\make.exe
   C:\opt\msys64\mingw64\bin\gcc.exe
   C:\opt\Git\bin\git.exe
   C:\opt\Git\usr\bin\diff.exe
   C:\opt\Git\bin\bash.exe
Environment variables:
   "CJ_HOME=C:\opt\mysql-connector-j"
   "CNET_HOME=C:\opt\mysql-connector-net"
   "GIT_HOME=C:\opt\Git"
   "JAVA_HOME=C:\opt\jdk-temurin-17.0.17_10"
   "MSYS_HOME=C:\opt\msys64"
   "MYSQL_HOME=C:\opt\mysql"
&nbsp;
<b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/where">where</a> git mysql</b>
   C:\opt\Git\bin\git.exe
   C:\opt\mysql\bin\mysql.exe
</pre>

<!--=======================================================================-->

## <span id="footnotes">Footnotes</span> [**&#x25B4;**](#top)

<span id="footnote_01">[1]</span> ***MySQL WorkBench*** [↩](#anchor_01)

<dl><dd>
<a href="https://www.oracle.com/mysql/enterprise/">Oracle</a> provides only a <a href="https://www.ninjaone.com/blog/msi-vs-exe/" rel="external">MSI installer</a> for the <a href="https://dev.mysql.com/downloads/workbench/">Community Edition of the MySQL WorkBench</a>.

In our case we follow the steps below to extract the installation directory and copy it into our preferred location for development tools (e.g. <code>C:\opt\\</code>) :

<pre style="font-size:80%;">
<b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/dir">dir</a> /b %USERPROFILE%\Downloads\*.msi</b>
<a href="https://dev.mysql.com/downloads/workbench/">mysql-workbench-community-8.0.44-winx64.msi</a>       <i>(252 MB)</i>
&nbsp;
<b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/msiexec">msiexec</a> /a "%USERPROFILE%\Downloads\mysql-workbench-community-8.0.44-winx64.msi" /qb TARGETDIR=C:\temp\msql_workbench</b>
&nbsp;
<b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/xcopy">xcopy</a> /i /q /s /y "C:\temp\mysql_workbench\PFiles64\MySQL\MySQL Workbench 8.0 CE" C:\opt\MySQL_Workbench</b>
22508 File(s) copied
&nbsp;
<b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/rmdir">rmdir</a> /q /s C:\temp\msql_workbench</b>
&nbsp;
<b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/dir">dir</a> /b c:\opt\MySQL_Workbench\my*.exe</b>
mysql.exe
mysqldump.exe
MySQLWorkbench.exe
</pre>
</dd></dl>

<span id="footnote_02">[2]</span> ***Downloads*** [↩](#anchor_02)

<dl><dd>
In our case we downloaded the following installation files (<a href="#proj_deps">see section 1</a>):
</dd>
<dd>
<pre style="font-size:80%;">
<a href="https://dev.mysql.com/downloads/connector/j/" rel="external">mysql-connector-j-9.5.0.zip</a>                    <i>(  5 MB)</i>
<a href="https://dev.mysql.com/downloads/connector/net/" rel="external">mysql-connector-net-9.5.0.msi</a>                  <i>(  1 MB)</i>
<a href="https://github.com/Maximus5/ConEmu/releases/tag/v23.07.24" rel="external">ConEmuPack.230724.7z</a>                           <i>(  5 MB)</i>
<a href="https://downloads.mysql.com/archives/community/">mysql-9.5.0-winx64.zip</a>                         <i>(291 MB)</i>
<a href="https://dev.mysql.com/downloads/workbench/" rel="external">mysql-workbench-community-8.0.44-winx64.msi</a>    <i>(252 MB)</i>
<a href="https://git-scm.com/download/win" rel="external">PortableGit-2.52.0-64-bit.7z.exe</a>               <i>( 41 MB)</i>
<a href="https://code.visualstudio.com/Download#" rel="external">VSCode-win32-x64-1.106.0.zip</a>                   <i>(131 MB)</i>
</pre>
</dd></dl>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/November 2025* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[ada_examples]: https://github.com/michelou/ada-examples#top
[akka_examples]: https://github.com/michelou/akka-examples#top
[apache_maven]: https://maven.apache.org/download.cgi
[apache_maven_history]: https://maven.apache.org/docs/history.html
[apache_maven_relnotes]: https://maven.apache.org/docs/3.9.11/release-notes.html
[cobol_examples]: https://github.com/michelou/cobol-examples#top
[component_pascal_examples]: https://github.com/michelou/component-pascal-examples#top
[connector_j_downloads]: https://dev.mysql.com/downloads/connector/j/
[connector_j_relnotes]: https://dev.mysql.com/doc/relnotes/connector-j/en/
[connector_net_downloads]: https://dev.mysql.com/downloads/connector/net/
[connector_net_relnotes]: https://dev.mysql.com/doc/relnotes/connector-net/en/
[connector_odbc_downloads]: https://dev.mysql.com/downloads/connector/odbc/
[connector_odbc_relnotes]: https://dev.mysql.com/doc/relnotes/connector-odbc/en/
[conemu_downloads]: https://github.com/Maximus5/ConEmu/releases
[conemu_relnotes]: https://conemu.github.io/blog/2023/07/24/Build-230724.html
[cpp_examples]: https://github.com/michelou/cpp-examples#top
[dafny_examples]: https://github.com/michelou/dafny-examples#top
[dart_examples]: https://github.com/michelou/dart-examples#top
[deno_examples]: https://github.com/michelou/deno-examples#top
[docker_examples]: https://github.com/michelou/docker-examples#top
[erlang_examples]: https://github.com/michelou/erlang-examples#top
[flix_examples]: https://github.com/michelou/flix-examples#top
[git_bash]: https://www.atlassian.com/git/tutorials/git-bash
[git_cli]: https://git-scm.com/docs/git
[git_downloads]: https://git-scm.com/download/win
[git_releases]: https://git-scm.com/download/win
[git_relnotes]: https://raw.githubusercontent.com/git/git/master/Documentation/RelNotes/2.52.0.adoc
[git_userguide]: https://git-scm.com/docs/git
[github_markdown]: https://github.github.com/gfm/
[golang_examples]: https://github.com/michelou/golang-examples#top
[graalvm_examples]: https://github.com/michelou/graalvm-examples#top
[gradle_relnotes]: https://docs.gradle.org/8.12/release-notes.html
[haskell_examples]: https://github.com/michelou/haskell-examples#top
[kotlin_examples]: https://github.com/michelou/kotlin-examples#top
[llvm_examples]: https://github.com/michelou/llvm-examples#top
[m2_examples]: https://github.com/michelou/m2-examples#top
[man1_awk]: https://www.linux.org/docs/man1/awk.html
[man1_diff]: https://www.linux.org/docs/man1/diff.html
[man1_file]: https://www.linux.org/docs/man1/file.html
[man1_grep]: https://www.linux.org/docs/man1/grep.html
[man1_more]: https://www.linux.org/docs/man1/more.html
[man1_mv]: https://www.linux.org/docs/man1/mv.html
[man1_rmdir]: https://www.linux.org/docs/man1/rmdir.html
[man1_sed]: https://www.linux.org/docs/man1/sed.html
[man1_wc]: https://www.linux.org/docs/man1/wc.html
[mysql]: https://dev.mysql.com/
[mysql_cli]: https://dev.mysql.com/doc/refman/9.5/en/mysql.html
[mysql_releases]: https://dev.mysql.com/downloads/mysql/
[mysql_relnotes]: https://dev.mysql.com/doc/relnotes/mysql/9.5/en/
[mysql_workbench_releases]: https://dev.mysql.com/downloads/workbench/
[mysql_workbench_relnotes]: https://dev.mysql.com/doc/relnotes/workbench/en/
[mysqld_cli]: https://dev.mysql.com/doc/refman/9.5/en/mysqld.html
[nodejs_examples]: https://github.com/michelou/nodejs-examples#top
[oracle_openjdk21]: https://jdk.java.net/21/
[oracle_openjdk21_api]: https://download.java.net/java/early_access/jdk21/docs/api/
[oracle_openjdk21_relnotes]: https://jdk.java.net/21/release-notes
[rust_examples]: https://github.com/michelou/rust-examples#top
[scala_api]: https://www.scala-lang.org/files/archive/api/current/
[scala_releases]: https://www.scala-lang.org/files/archive/
[scala_relnotes]: https://github.com/scala/scala/releases/tag/v2.13.17
[scala3_examples]: https://github.com/michelou/dotty-examples#top
[sh_cli]: https://man7.org/linux/man-pages/man1/sh.1p.html
[sml_examples]: https://github.com/michelou/sml-examples#top
[spark_examples]: https://github.com/michelou/spark-examples#top
[spring_examples]: https://github.com/michelou/spring-examples#top
<!--
17.0.2  -> https://www.oracle.com/java/technologies/javase/17-0-2-bugfixes.html
17.0.3  -> https://www.oracle.com/java/technologies/javase/17-0-3-bugfixes.html
17.0.7  -> https://www.oracle.com/java/technologies/javase/17-0-7-relnotes.html
17.0.8  -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-September/025526.html
17.0.9  -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-October/026352.html
17.0.10 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2024-January/029089.html
17.0.11 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2024-April/032197.html
17.0.12 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2024-July/035798.html
17.0.13 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2024-October/038867.html
17.0.14 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2025-January/040827.html
17.0.15 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2025-April/043307.html
17.0.16 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2025-July/045614.html
17.0.17 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2025-October/049112.html
-->
[temurin_openjdk17]: https://adoptium.net/temurin/releases?version=17&os=windows&arch=x64
[temurin_openjdk17_bugfixes]: https://www.oracle.com/java/technologies/javase/17-0-9-relnotes.html
[temurin_openjdk17_relnotes]: https://mail.openjdk.org/pipermail/jdk-updates-dev/2025-July/045614.html
[trufflesqueak_examples]: https://github.com/michelou/trufflesqueak-examples#top
[unix_bash_script]: https://www.gnu.org/software/bash/manual/bash.html
[unix_opt]: https://tldp.org/LDP/Linux-Filesystem-Hierarchy/html/opt.html
[vscode_downloads]: https://code.visualstudio.com/#alt-downloads
[vscode_relnotes]: https://code.visualstudio.com/updates/
[vs2022_downloads]: https://visualstudio.microsoft.com/en/downloads/
[vs2022_relnotes]: https://docs.microsoft.com/en-us/visualstudio/releases/2022/release-notes
[windows_batch_file]: https://en.wikibooks.org/wiki/Windows_Batch_Scripting
[windows_installer]: https://docs.microsoft.com/en-us/windows/win32/msi/windows-installer-portal
[windows_limitation]: https://support.microsoft.com/en-gb/help/830473/command-prompt-cmd-exe-command-line-string-limitation
[windows_subst]: https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/subst
[wix_examples]: https://github.com/michelou/wix-examples#top
[zig_examples]: https://github.com/michelou/zig-examples#top
[zip_archive]: https://www.howtogeek.com/178146/htg-explains-everything-you-need-to-know-about-zipped-files/
