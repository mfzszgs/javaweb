package myweb.service;  
import javax.jws.WebService;  
import javax.jws.WebMethod;  
import javax.jws.soap.SOAPBinding;  
import javax.jws.soap.SOAPBinding.Style;  
@WebService  
@SOAPBinding(style=Style.RPC)  
public interface TimeServer {  
    @WebMethod  
    String getTimeAsString(String str);  
    @WebMethod  
    long getTimeAsElapsed();  
}  
