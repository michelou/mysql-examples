import com.mysql.cj.Constants;

public class CJ {

    public static void main(String[] args) {
        // javap -cp c:\opt\mysql-connector-j\mysql-connector-j-9.5.0.jar com.mysql.cj.Constants

        System.out.println("JVM_VENDOR="+Constants.JVM_VENDOR);
        System.out.println("JVM_VERSION="+Constants.JVM_VERSION);

        System.out.println("OS_NAME="+Constants.OS_NAME);
        System.out.println("OS_ARCH="+Constants.OS_ARCH);
        System.out.println("OS_VERSION="+Constants.OS_VERSION);

        System.out.println("CJ_NAME="+Constants.CJ_NAME);
        System.out.println("CJ_FULL_NAME="+Constants.CJ_FULL_NAME);
        //System.out.println("CJ_REVISION="+Constants.CJ_REVISION);
        //System.out.println("CJ_MAJOR_VERSION="+Constants.CJ_MAJOR_VERSION);
        //System.out.println("CJ_MINOR_VERSION="+Constants.CJ_MINOR_VERSION);
        System.out.println("CJ_VERSION="+Constants.CJ_VERSION);
        System.out.println("CJ_LICENSE="+Constants.CJ_LICENSE);
    }

}
