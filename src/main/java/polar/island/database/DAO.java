package polar.island.database;

import org.springframework.stereotype.Component;

import java.lang.annotation.*;

/**
 * MyBatis Dao层注解。
 * 
 * @author PolarLoves
 *
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
@Documented
@Component
public @interface DAO {
	/**
	 * The value may indicate a suggestion for a logical component name, to be
	 * turned into a Spring bean in case of an autodetected component.
	 * 
	 * @return the suggested component name, if any
	 */
	String value() default "";
}
