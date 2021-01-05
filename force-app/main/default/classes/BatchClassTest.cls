global class BatchClassTest implements database.Batchable<sobject>,database.stateful {
    global static database.QueryLocator start(database.BatchableContext bc){
        String query = 'select id , name from account';
        return database.getQueryLocator(query);        
    }
    global void execute(database.BatchableContext bc, List<Account> Scope){
        for(Account a : scope){
            
        }
    }
    global void finish(database.BatchableContext bc){
        
    }

}