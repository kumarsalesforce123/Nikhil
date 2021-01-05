public class c1{

list<account> acts = new list<account>();
public list<account> getmethod(){

acts = [select id, name, phone from account ];
Return acts;
}
    public pagereference method2(){
        
        acts = [select id, name, phone from account ];
        return null;
    }
        
         public pagereference method3(){
        
        acts = [select id, name, phone from account ];
        return null;
        
        
    }




}