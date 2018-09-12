package polar.island.core.util;

import org.apache.commons.io.IOUtils;

import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLDecoder;

public class FileUtil {
    private FileUtil() {

    }

    public static String getFileName(String path) throws Exception {
        path = URLDecoder.decode(path, "UTF-8");
        String name = path.substring(path.lastIndexOf(java.io.File.separator) + java.io.File.separator.length(), path.length());
        return name;
    }

    public static void writeFile(String title, String path, OutputStream outputStream) throws Exception {

        InputStream in = null;
        try {
            // 4.获取要下载的文件输入流
            in = new FileInputStream(path);
            int len = 0;
            // 5.创建数据缓冲区
            byte[] buffer = new byte[1024];
            // 6.通过response对象获取OutputStream流

            // 7.将FileInputStream流写入到buffer缓冲区
            while ((len = in.read(buffer)) > 0) {
                // 8.使用OutputStream将缓冲区的数据输出到客户端浏览器
                outputStream.write(buffer, 0, len);
            }
            IOUtils.closeQuietly(outputStream);
        } finally {
            IOUtils.closeQuietly(in);
        }
    }

}
