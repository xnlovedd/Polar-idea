package polar.island.core.err;

import org.springframework.stereotype.Component;

import java.lang.annotation.*;


/**
 * 错误注解，用于将错误解析成数据,可解析成网页或者Json串。
 *
 * @author Polar
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@Documented
@Component
public @interface ErrorMsg {
    /**
     * 标签，用于记录Log日志
     *
     * @return 标签
     */
    public String tag();

    /**
     * 期望错误返回值类型，分为json和页面
     *
     * @return 期望错误返回类型
     */
    public ErrorType type() default ErrorType.BOTH;

    /**
     * 错误前缀，仅当出现已知错误时才有效。
     *
     * @return 错误前缀
     */
    public String prefix() default "";

    /**
     * 错误后缀，仅当出现已知错误时有效。
     *
     * @return 错误后缀
     */
    public String suffix() default "";

    /**
     * 出现已知错误时，重写的提示语。
     *
     * @return 重写的提示语
     */
    public String msg() default "";

    /**
     * 是否对所有信息进行重写。
     *
     * @return 如果其值为true, 且msg不为空，则会对其所有异常重写。如果其值为fasle，则只会对已知错误进行重写。
     */
    public boolean overrideAll() default false;

    /**
     * 获取错误重定向页面。
     *
     * @return 错误重定向的页面
     */
    public String mapper() default "";

    public boolean writeLogs() default true;
}
