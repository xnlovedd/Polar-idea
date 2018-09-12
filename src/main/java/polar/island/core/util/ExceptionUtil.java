package polar.island.core.util;

import java.io.PrintWriter;
import java.io.StringWriter;

public class ExceptionUtil {
	private ExceptionUtil() {

	}

	public static String getExceptionAllinformation(Exception e) {
		if (e == null){
			return "";
		}
		StringWriter stringWriter = new StringWriter();
		e.printStackTrace(new PrintWriter(stringWriter));
		return stringWriter.toString();
	}
}
