package polar.island.core.util;

import javax.servlet.http.HttpServletResponse;

public class ResponseUtil {

    public static void  renderResponseFileHeader(String fileName, HttpServletResponse response) throws Exception {
        response.setHeader("Content-Disposition",
                "attachment; filename=" + java.net.URLEncoder.encode(fileName, "UTF-8"));
    }
}
