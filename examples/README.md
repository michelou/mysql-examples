# <span id="top">MySQL code examples</span> <span style="font-size:90%;">[⬆](../README.md#top)</span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:25%;"><a href="https://dev.mysql.com/"><img src="../docs/logo-mysql.png" width="100" alt="MySQL project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This repository gathers <a href="https://dev.mysql.com/" rel="external">MySQL</a> code examples coming from various websites and books.<br/>
  It also includes several build scripts (<a href="https://en.wikibooks.org/wiki/Windows_Batch_Scripting">batch files</a>, <a href="https://makefiletutorial.com/" rel="external">Make scripts</a>) for experimenting with <a href="https://dev.mysql.com//" rel="external">MySQL</a> on a Windows machine.
  </td>
  </tr>
</table>

## <span id="tutorial1_java">Tutorial1 - Java</span>

This code example is written in Java and depends on [MySQL Connector/J][connector_j] to interact with [our MySQL Database](../dba/README.md). The project has the following directory structure :

<pre style="font-size:80%;">
<b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/tree">tree</a> /a /f . | <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/findstr">findstr</a> /b /v [A-Z]</b>
|   <a href="./Tutorial1-Java/build.bat">build.bat</a> <sup><b>a)</b></sup>
\---<b>src</b>
    \---<b>main</b>
        \---<b>java</b>
                <a href="./Tutorial1-Java/src/main/java/Main.java">Main.java</a>
</pre>
<div style="margin:0 0 12px 4px; font-size:80%;">
<sup><b>a)</b></sup> This batch file calls <a href="./cpath.bat"><code>cpath.bat</code></a> to manage project dependencies such as the <a href="https://mvnrepository.com/artifact/com.mysql/mysql-connector-j/">MySQL Connector/J</a> library.
</div>

Batch file [**`build.bat`**](./Tutorial1-Java/build.bat)`clean run` generates and executes the Java program `target\classes\Main.class` :

<pre style="font-size:80%;">
<b>&gt; <a href="./Tutorial1-Java/build.bat">build</a> -verbose clean run</b>
Compile 1 Java source file to directory "target\classes"
Execute Java main class "Main"
Driver version : mysql-connector-j-9.5.0 (Revision: a7b3c94f50efbddb9f0dd69b3e0d1aaa25305cd6)
MySQL version : 9.5.0

Host=localhost
User=root
max_connections=0
password_expired=N
password_last_changed=2025-11-01 22:25:20
password_lifetime=null
Done.
</pre>

<!--=======================================================================-->

## <span id="tutorial1_csharp">Tutorial1 - C#</span>

This code example in written in C# and depends on [MySQL Connector/NET][connector_net] to interact with [our MySQL Database](../dba/README.md). The project has the following directory structure :

<pre style="font-size:80%;">
<b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/tree">tree</a> /a /f . | <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/findstr">findstr</a> /b /v [A-Z]</b>
|   <a href="./Tutorial1/00download.txt">00download.txt</a>
|   <a href="./Tutorial1/build.bat">build.bat</a>
|   <a href="./Tutorial1/Tutorial1.sln">Tutorial1.sln</a>
\---<b>Tutorial1</b>
        <a href="./Tutorial1/Tutorial1/Tutorial1.cs">Tutorial1.cs</a>
        <a href="./Tutorial1/Tutorial1/Tutorial1.csproj">Tutorial1.csproj</a> <sup><b>a)</b></sup>
</pre>
<div style="margin:0 0 12px 4px; font-size:80%;">
<sup><b>a)</b></sup> Project dependencies are listed in this XML file; in our case we depend on the <a href="https://dev.mysql.com/doc/connector-net/en/">MySQL Connector/Net</a> library (written as <code>$(CNET_HOME)\MySql.Data.dll</code>).
</div>

Batch file [**`build.bat`**](./Tutorial1/build.bat)`clean run` generates and executes the C# program `bin\Debug\net8.0-...\Tutorial1.exe` :

<pre style="font-size:80%;">
<b>&gt; <a href="./Tutorial1/build.bat">build</a> -verbose clean run</b>
Clean solution

Delete directory "Tutorial1\Obj"
Run a NuGet package restore

  Determining projects to restore...
  Restored H:\examples\Tutorial1\Tutorial1\Tutorial1.csproj (in 3.57 sec).
Generate solution

  Tutorial1 -> H:\examples\Tutorial1\Tutorial1\bin\Debug\net8.0-windows10.0.26100.0\Tutorial1.dll
Execute application "Tutorial1\bin\Debug\net8.0-windows10.0.26100.0\Tutorial1.exe"
Connecting to MySQL...
Driver location : H:\examples\Tutorial1\Tutorial1\bin\Debug\net8.0-windows10.0.26100.0\MySql.Data.dll
Driver name : MySql.Data
Driver version : 9.5.0.0
MySQL version : 9.5.0

Host=localhost
User=root
Max_Connections=0
Password_Expired=N
Password_Last_Changed=11/1/2025 10:25:20 PM
Password_Lifetime=
Done.
</pre>

<!--=======================================================================-->

## <span id="footnotes">Footnotes</span> [**&#x25B4;**](#top)

<span id="footnote_01">[1]</span> ***DLL file path*** [↩](#anchor_01)

<dl><dd>
WIP
<pre style="font-size:80%;">
AssemblyName.GetAssemblyName(@".\MySQL.Data.dll")
Could not find file 'H:\examples\Tutorial1\MySQL.Data.dll'.
</pre>
</dd></dl>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/November 2025* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[connector_j]: https://dev.mysql.com/doc/connector-j/en/ "MySQL Connector/J Developer Guide"
[connector_net]: https://dev.mysql.com/doc/connector-net/en/ MySQL Connector/NET Developer Guide"
