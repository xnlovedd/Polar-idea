package polar.island.core.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;

import javax.validation.ConstraintViolation;
import java.util.Set;

/**
 * 实体校验器
 * 
 * @author PolarLoves
 *
 */
public class Validator extends LocalValidatorFactoryBean {
	@Override
	public void validate(Object target, Errors errors) {
		super.validate(target, errors);

//		try {
//			for(Field field:target.getClass().getDeclaredFields()){
//				RequireValidate requireValidate=field.getAnnotation(RequireValidate.class);
//				if(requireValidate!=null){
//					if(requireValidate.style().equalsIgnoreCase("list")){
//						field.setAccessible(true);
//						List values= (List) field.get(target);
//						for(Object value:values){
//							super.validate(value, errors);
//						}
//					}
//				}
//			}
//		}catch (Exception e){
//			e.printStackTrace();
//		}
	}

	protected void processConstraintViolations(Set<ConstraintViolation<Object>> violations, Errors errors) {
		super.processConstraintViolations(violations, errors);
	}
}
