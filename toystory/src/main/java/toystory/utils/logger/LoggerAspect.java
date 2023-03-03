package toystory.utils.logger;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;


@Aspect
@Component
public class LoggerAspect {
	protected Log log = LogFactory.getLog(LoggerAspect.class);
	static String name="";
	static String type="";
	
	@Around( "execution(* toystory..controller.*Controller.*(..)) or execution(* toystory..service.*Impl.*(..)) or execution(* toystory..mapper.*Mapper.*(..))")
	public Object logPrint(ProceedingJoinPoint joinPoint) throws Throwable{
		
		type = joinPoint.getSignature().getDeclaringTypeName();
		
		if(type.indexOf("Controller") > -1) {
			name = "Controller \t:  ";
			
		} else if(type.indexOf("Service") > -1) {
			name = "Service \t:  ";
			
		} else if(type.indexOf("Mapper") > -1) {
			name = "Mapper   \t:  ";
			
		}
		
		
		log.debug(name + type + "." + joinPoint.getSignature().getName() + "()");
		
		return joinPoint.proceed();
		
	}
}
