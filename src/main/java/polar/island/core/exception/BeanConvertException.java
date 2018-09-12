package polar.island.core.exception;

import polar.island.core.config.Constants;

import java.io.*;

/**
 * 实体转换异常。
 *
 * @author PolarLoves
 */
public class BeanConvertException extends FrameWorkException {
    private static final long serialVersionUID = 6649998389051775763L;

    public BeanConvertException(String message, Exception causeMessage) {
        super(Constants.CODE_BEAN_CONVERT, message, causeMessage);
    }

    public static void main(String args[]) throws Exception {
        String inPath = "D:\\CrtTableSpace.sql";
        String outPath = "D:\\test1.sql";

        InputStreamReader isr = new InputStreamReader(new FileInputStream(new File(inPath)), "UTF-8");
        BufferedReader reader = new BufferedReader(isr);

        File outFile = new File(outPath);
        if (!outFile.exists()) {
            outFile.createNewFile();
        }
        OutputStream outputStream = new FileOutputStream(outFile);
        String str = null;
        while ((str = reader.readLine()) != null) {
            if ((str.contains("tablespace") || str.contains("TABLESPACE")) && (str.contains("DATAFILE") || str.contains("DATAFILE".toLowerCase()))) {
                String m = str.substring((str.indexOf("tablespace") == -1 ? str.indexOf("TABLESPACE") : str.indexOf("tablespace")) + "tablespace".length(), str.length());
                m = m.trim();
                String tableName = m.substring(0, m.indexOf(" "));
                str = str.replace("DATAFILE", "DATAFILE '" + tableName + "' ");
                str = str.replace("DATAFILE".toLowerCase(), "DATAFILE '" + tableName + "' ");
                str=str.replace("256M","20M");
                str=str.replace("128M","10M");
                str=str.replace("1G","100M");
                str=str.replace("2G","200M");
                str=str.replace("4G","400M");
                outputStream.write((str + "\r\n").getBytes("UTF-8"));
            }else{
                outputStream.write((str + "\r\n").getBytes("UTF-8"));
            }
        }

    }
}
