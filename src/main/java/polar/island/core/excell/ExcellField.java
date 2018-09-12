package polar.island.core.excell;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
public @interface ExcellField {
	// 标题
	String title();

	// 排序号
	int orderNum() default 0;

	// 宽度
	int width() default 5000;
}
