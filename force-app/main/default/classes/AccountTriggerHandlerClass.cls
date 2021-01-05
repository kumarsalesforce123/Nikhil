public class AccountTriggerHandlerClass {
    
    public static void AfterInsertOperation(List<Account> AccList){
        List<Contact> ListOfContacts = new List<Contact>();
        List<Account> ListOfAccounts = new List<Account>();
        Set<Id> AccId = new set<Id>();
        Map<Id,Id> AccountContactMap = new map<Id,Id>();
        Contact con ;
        for(Account acc : AccList){
            AccId.add(acc.Id);
            con = new contact();
            con.FirstName = acc.Name;
            con.LastName = acc.Name;
            con.AccountId = acc.Id;
            ListOfContacts.add(con);
        }
        insert ListOfContacts; 
        for(Contact cont : ListOfContacts){
            ListOfAccounts.add(new account (Id = cont.accountId, Description = cont.ID));
        }
    /*    for(Contact cont : [SELECT ID, ACCOUNTID FROM CONTACT WHERE ACCOUNTID IN: AccId]){
            AccountContactMap.Put(cont.AccountId, cont.Id);
        } 
        Account account ;
        for(Account acct : AccList){
            account = new account();
            account.Id = acct.ID;
            account.Description = AccountContactMap.get(acct.Id);
            ListOfAccounts.add(account);
        } */
        update ListOfAccounts;        
    }

}