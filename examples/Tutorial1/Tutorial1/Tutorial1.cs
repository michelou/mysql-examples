using MySql.Data;
using MySql.Data.MySqlClient;

using System;
using System.Data;
using System.Reflection;
using System.Text.RegularExpressions;  // Regex

public class Tutorial1
{
    public static void Main()
    {
        string connStr = GetConnectionString();
        MySqlConnection conn = new MySqlConnection(connStr);
        try
        {
            Console.WriteLine("Connecting to MySQL...");
            conn.Open();

            WriteEnvironmentInfos(conn);

            string sql = "SELECT Host, User, Max_Connections, Password_Expired, Password_Last_Changed, Password_Lifetime FROM USER WHERE USER = 'root';";
            MySqlCommand cmd = new MySqlCommand(sql, conn);
            MySqlDataReader reader = cmd.ExecuteReader();

            int fieldCount = reader.FieldCount;
            while (reader.Read())
            {
                for (int i = 0; i < fieldCount; i++)
                {
                    Console.WriteLine(reader.GetName(i) + "=" + reader[i].ToString());
                }
            }
            reader.Close();
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.ToString());
        }
        conn.Close();
        Console.WriteLine("Done.");
    }

    private static String GetConnectionString()
    {
        var props = LoadProperties();
        var host = props["host"];
        var port = props["port"];
        var dbName = props["dbname"];
        var user = props["user"];
        var password = props["password"];
        return "server=" + host + ";port=" + port + ";database=" + dbName+ ";user=" + user + ";password=" + password;
    }

    /**
     * https://stackoverflow.com/questions/485659/can-net-load-and-parse-a-properties-file-equivalent-to-java-properties-class
     */
    private static Dictionary<string, string> LoadProperties()
    {
        var value = Environment.GetEnvironmentVariable("OS");
        var regex = new Regex(@".*Windows.*");
        var isWin = regex.Matches(String.IsNullOrEmpty(value) ? "" : value).Count > 0;
        var variableName = isWin ? "USERPROFILE" : "user.home";
        var userHome = Environment.GetEnvironmentVariable(variableName);
        var filePath = userHome + Path.DirectorySeparatorChar + ".mysql" + Path.DirectorySeparatorChar + "mysql.properties";
        var data = new Dictionary<string, string>();
        foreach (var row in File.ReadAllLines(filePath))
            data.Add(row.Split('=')[0], string.Join("=", row.Split('=').Skip(1).ToArray()));
        return data;
    }

    private static void WriteEnvironmentInfos(MySqlConnection conn)
    {
        // here we use the bang character ('!') twice to avoid the message
        // "warning CS8600: Converting null literal or possible null value to non-nullable type."
        Assembly driverAssembly = Assembly.GetAssembly(conn.GetType())!;
        AssemblyName driverName = driverAssembly!.GetName();
        Console.WriteLine($"Driver location : {driverAssembly.Location}");
        Console.WriteLine($"Driver name : {driverName.Name}");
        Console.WriteLine($"Driver version : {driverName.Version}");
        Console.WriteLine($"MySQL version : {conn.ServerVersion}");
        Console.WriteLine();
    }

}
