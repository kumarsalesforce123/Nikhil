public class apcomm {
    
    public list<account> arecs{set;get;}
    
    public void item(){
        arecs = [select id,name,billingcity from account ];
        
    }   
}