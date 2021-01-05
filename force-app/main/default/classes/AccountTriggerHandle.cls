public class AccountTriggerHandle {
    
    public Static Void BeforeUpdate(List<Account> NewAccList, Map<Id, Account> OldAccMap){       
        for(Account acc : NewAccList){
            Account OldAcc = OldAccMap.get(acc.ID);
            if(acc.billingcity != OldAcc.billingcity && acc.BillingStreet != OldAcc.BillingStreet){
                acc.Wells_Fargo_Check__c  = True;                 
            }            
        }        
    }
    public Static Void AfterUpdate(List<Account> NewAccList, Map<Id, Account> OldAccMap){
        Set<ID> AccountIds = new Set<ID>();
        List<Contact> ContactsToUpdate = new List<Contact>();
        for(Account acc : NewAccList){
            Account OldAcc = OldAccMap.get(acc.ID);
            if(acc.billingcity != OldAcc.billingcity && acc.BillingStreet != OldAcc.BillingStreet){
            	AccountIds.add(acc.Id);                  
            }            
        }
        for(Contact c : [Select Id, AccountId,Account.billingcity,Account.BillingStreet , MailingCity, MailingStreet From Contact Where AccountId IN: AccountIds]){            
            c.MailingCity = c.Account.billingcity;
            c.MailingStreet = c.Account.BillingStreet;
            ContactsToUpdate.add(c);
        }
        Update ContactsToUpdate;
      //  datebase.Update(ContactsToUpdate, False);
        
    }

}