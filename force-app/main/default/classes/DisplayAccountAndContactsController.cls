public class DisplayAccountAndContactsController {
    
    public list<Account> getAccounts{get;set;}
    
    public DisplayAccountAndContactsController(){
        getAccounts = [SELECT ID,Name,(Select Id, Name, Email from Contacts) FROM Account];
    }

}