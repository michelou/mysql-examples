# <span id="top">MySQL Database Administration</span> <span style="font-size:90%;">[↩](./README.md)</span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:100px;"><a href="https://dev.mysql.com/" rel="external"><img style="border:0;" src="../docs/images/logo-mysql.png" width="100" alt="MySQL project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This document gathers some notes about setting up our <a href="https://dev.mysql.com/" rel="external">MySQL</a> development environment.
  </td>
  </tr>
</table>

## <span id="init">Initialization of the MySQL database</span>

We perform this operation once to initialize our database; it will fail if the data directory is not empty.
> **Note** : We save the temporary password (highlighted below) for `root@localhost` generated during the database initialization and ***do not forget*** to change it in the next step.

<pre style="font-size:80%;">
<b>&gt; <a href="https://dev.mysql.com/doc/refman/9.4/en/mysqld.html" rel="external">mysqld</a> --defaults-file=dba\<a href="./my.ini">my.ini</a> --initialize --console --user=root</b>
2025-11-01T21:09:57.878147Z 0 [System] [MY-015017] [Server] MySQL Server Initialization - start.
2025-11-01T21:09:57.886455Z 0 [System] [MY-013169] [Server] C:\opt\mysql\bin\mysqld.exe (mysqld 9.4.0) initializing of server in progress as process 29296
2025-11-01T21:09:57.920187Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
2025-11-01T21:09:58.282001Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
2025-11-01T21:10:00.230178Z 6 [Note] [MY-010454] [Server] A temporary password is generated for <b>root@localhost</b>: <span style="color:darkviolet;"><b>OiCg8sf4e-q0</b></span>
2025-11-01T21:10:02.902194Z 0 [System] [MY-015018] [Server] MySQL Server Initialization - end.
</pre>

> **Note**: Configuration file [`my.ini`](./my.ini) provides a minimal setup for initializing the MySQL Server. In particular we take care to define the data directory ***outside*** the installation directory.
>
><pre style="font-size:80%;">
> <b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/type" rel="external">type</a> dba\<a href="./my.ini">my.ini</a></b>
> <span style="color:darkviolet;">[mysqld]</span>
> <span style="color:green;"># set basedir to your installation path</span>
> basedir=C:\\opt\\mysql
> <span style="color:green;"># set datadir to the location of your data directory</span>
> datadir=C:\\data\\mysql
>
> # https://dev.mysql.com/doc/refman/9.5/en/caching-sha2-pluggable-authentication.html
> caching_sha2_password_private_key_path=C:\\data\\mysql\\private_key.pem
> caching_sha2_password_public_key_path=C:\\data\\mysql\\public_key.pem
>
> <span style="color:green;"># default: 3306</span>
> <span style="color:green;"># port=3306</span>
> </pre>

## <span id="start_server">Start of the MySQL Server</span>

We execute the [`start`][windows_start] command to launch the MySQL Server in a separate Windows console :

<pre style="font-size:80%;">
<b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/start" rel="external">start</a> "mysqld" <a href="https://dev.mysql.com/doc/refman/9.4/en/mysqld.html" rel="external">mysqld</a> --defaults-file=dba\my.ini --console</b>
</pre>

We get the following output in the Windows console:

<pre style="font-size:80%;">
2025-11-02T14:47:32.694898Z 0 [System] [MY-015015] [Server] MySQL Server - start.
2025-11-02T14:47:32.918463Z 0 [System] [MY-010116] [Server] C:\opt\mysql\bin\mysqld.exe (mysqld 9.4.0) starting as process 11352
2025-11-02T14:47:32.918483Z 0 [System] [MY-015590] [Server] MySQL Server has access to 8 logical CPUs.
2025-11-02T14:47:32.918497Z 0 [System] [MY-015590] [Server] MySQL Server has access to 17065795584 bytes of physical memory.
2025-11-02T14:47:32.950133Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
2025-11-02T14:47:33.268269Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
2025-11-02T14:47:33.633392Z 0 [Warning] [MY-010068] [Server] CA certificate ca.pem is self signed.
2025-11-02T14:47:33.633549Z 0 [System] [MY-013602] [Server] Channel mysql_main configured to support TLS. Encrypted connections are now supported for this channel.
2025-11-02T14:47:33.692486Z 0 [System] [MY-011323] [Server] X Plugin ready for connections. Bind-address: '::' port: 33060
2025-11-02T14:47:33.692754Z 0 [System] [MY-010931] [Server] C:\opt\mysql\bin\mysqld.exe: ready for connections. Version: '9.4.0'  socket: ''  port: 3306  MySQL Community Server - GPL.
</pre>

> **Note** : We can display the list of processes with name "mysqld" running on our local machine :
> <pre style="font-size:80%;">
> <b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/tasklist">tasklist</a> | <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/findstr">findstr</a> mysqld</b>
> mysqld.exe                   44216 Console                    1     29,380 K
> mysqld.exe                   41516 Console                    1    463,616 K
> </pre>

## <span id="start_client">Start of the MySQL Client</span>

We now start the MySQL Client to connect to our MySQL database. In particular we perform the following two tasks :
- we change the root password with command `ALTER USER`.
- we display global variables with `'%version%'` and `'%data%'` as patterns to check our development environment.

<pre style="font-size:80%;">
<b>&gt; <a href="https://dev.mysql.com/doc/refman/9.4/en/mysql-command-options.html" rel="external">mysql.exe</a> -u root -p</b>
Enter password: *****
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 15
Server version: 9.5.0 MySQL Community Server - GPL

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

<b><span style="color:darkgreen;">mysql&gt;</span> ALTER USER <span style="color:darkred;">'root'@'localhost'</span> IDENTIFIED BY <span style="color:darkred;">'new_password'</span>;</b>

<b><span style="color:darkgreen;">mysql&gt;</span> <a href="https://dev.mysql.com/doc/refman/9.5/en/show-variables.html" rel="external">SHOW GLOBAL VARIABLES</a> LIKE <span style="color:darkred;">'%version%'</span>;</b>
+-----------------------------+------------------------------+
| Variable_name               | Value                        |
+-----------------------------+------------------------------+
| admin_tls_version           | TLSv1.2,TLSv1.3              |
| explain_json_format_version | 2                            |
| innodb_version              | 9.5.0                        |
| protocol_version            | 10                           |
| replica_type_conversions    |                              |
| slave_type_conversions      |                              |
| tls_version                 | TLSv1.2,TLSv1.3              |
| version                     | 9.5.0                        |
| version_comment             | MySQL Community Server - GPL |
| version_compile_machine     | x86_64                       |
| version_compile_os          | Win64                        |
| version_compile_zlib        | 1.3.1                        |
+-----------------------------+------------------------------+
12 rows in set (0.016 sec)
&nbsp;
<b><span style="color:darkgreen;">mysql&gt;</span> <a href="https://dev.mysql.com/doc/refman/9.5/en/show-variables.html" rel="external">SHOW GLOBAL VARIABLES</a> LIKE <span style="color:darkred;">'%data%'</span>;</b>
+---------------------------------------+------------------------+
| Variable_name                         | Value                  |
+---------------------------------------+------------------------+
| binlog_row_metadata                   | MINIMAL                |
| character_set_database                | utf8mb4                |
| collation_database                    | utf8mb4_0900_ai_ci     |
| datadir                               | C:\data\mysql\         |
| innodb_data_file_path                 | ibdata1:12M:autoextend |
| innodb_data_home_dir                  |                        |
| innodb_stats_on_metadata              | OFF                    |
| innodb_temp_data_file_path            | ibtmp1:12M:autoextend  |
| innodb_use_fdatasync                  | ON                     |
| max_length_for_sort_data              | 4096                   |
| myisam_data_pointer_size              | 6                      |
| performance_schema_max_metadata_locks | -1                     |
| skip_show_database                    | OFF                    |
| updatable_views_with_limit            | YES                    |
+---------------------------------------+------------------------+
14 rows in set (0.016 sec)
&nbsp;
<b><span style="color:darkgreen;">mysql&gt;</span> EXIT</b>
Bye
</pre>

## <span id="stop_server">Shutdown of the MySQL Server</span>

We execute the following command to shutdown the MySQL Server :

<pre style="font-size:80%;">
<b>&gt; <a href="https://dev.mysql.com/doc/refman/9.4/en/mysqladmin.html" rel="external">mysqladmin</a> shutdown -u root -p</b>
Enter password: *****
&nbsp;
<b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/tasklist">tasklist</a> | <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/findstr" rel="external">findstr</a> mysql</b>
</pre>

<!--=======================================================================-->
## <span id="footnotes">Footnotes</span> [**&#x25B4;**](#top)

<span id="footnote_01">[1]</span> ***Starting MySQL Server as a Windows Service*** [↩](#anchor_01)

<dl><dd>

<!-- https://dev.mysql.com/doc/refman/8.4/en/windows-start-service.html -->
<pre style="font-size:80%;">
<b>&gt; <a href="https://dev.mysql.com/doc/refman/9.4/en/mysqld.html" rel="external">mysqld</a> --install MySQL --defaults-file=dba\my.ini</b>
</pre>
</dd></dl>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/November 2025* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[windows_start]: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/start
