import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.Properties;

public class Main {

    public static void main(String[] args) {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        ResultSetMetaData rsmd = null;
        int columnsNumber;
        try {
            conn = DriverManager.getConnection(getConnectionString());

            printEnvironmentInfos(conn);
 
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT Host, User, Max_Connections, Password_Expired, Password_Last_Changed, Password_Lifetime FROM USER WHERE USER = 'root';");
            rsmd = rs.getMetaData();
            columnsNumber = rsmd.getColumnCount();

            while (rs.next()) {
                for (int i = 1; i <= columnsNumber; i++) {
                    System.out.println(rsmd.getColumnName(i)+"="+rs.getString(i));
                }
                System.out.println("");
            }

            // or alternatively, if you don't know ahead of time that
            // the query will be a SELECT...

            //if (stmt.execute("SELECT * FROM USER;")) {
            //    rs = stmt.getResultSet();
            //}
        } catch (IOException ex) {
            System.out.println("Exception: " + ex.getMessage());
        } catch (SQLException ex) {
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        } finally {
            // it is a good idea to release resources in a finally{} block
            // in reverse-order of their creation if they are no-longer needed.

            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException sqlEx) { } // ignore

                rs = null;
            }

            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException sqlEx) { } // ignore

                stmt = null;
            }
            System.out.println("Done.");
        }
    }

    private static String getConnectionString() throws IOException {
        Properties props = loadProperties();
        String host = props.getProperty("host");
        String port = props.getProperty("port");
        String dbName = props.getProperty("dbname");
        String user = props.getProperty("user");
        String password = props.getProperty("password");
        return "jdbc:mysql://"+host+":"+port+"/"+dbName+"?" + "user="+user+"&password="+password;
    }

    private static Properties loadProperties() throws IOException {
        String variableName = System.getenv("OS").matches(".*Windows.*") ? "USERPROFILE" : "user.home";
        String userHome = System.getenv(variableName);
        String filePath = userHome + File.separator + ".mysql" + File.separator + "mysql.properties";
        Properties props = new Properties();
        FileInputStream input = new FileInputStream(filePath);
        props.load(input);
        return props;        
    }

    private static void printEnvironmentInfos(Connection conn) throws SQLException {
        DatabaseMetaData dbmd = conn.getMetaData();
        System.out.println("Driver version : " + dbmd.getDriverVersion());
        System.out.println("MySQL version : " + dbmd.getDatabaseProductVersion());
        System.out.println();
    }

}
