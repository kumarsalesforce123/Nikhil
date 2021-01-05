public class siri {
    public string username{set;get;}
    public string password{set;get;}
    public string status{set;get;}
    public void m1(){
        
        if(username == 'nikhil' && password == 'gurram')
            status= 'valid';
        else
            status = 'invalid' ;
    }
    
}