package myweb.service;  
import javax.xml.ws.Endpoint;  
public class TimeServerPublisher {  
    public static void main(String[] args){  
        // 第一个参数是发布的URL  
        // 第二个参数是SIB实现  
        Endpoint.publish("http://127.0.0.1:10100/myweb", new TimeServerImpl());  
    }  
}  
