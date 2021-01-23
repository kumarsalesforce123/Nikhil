public with sharing class exportToCSVTool {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList(string objectApi, string fields, string condetions, string recordslimit) {
        string soqlstring = '';
        
        if(string.isNotEmpty(objectApi) && string.isNotEmpty(fields))
            soqlstring = 'select '+fields+' from '+objectApi; 
        if(string.isNotEmpty(condetions))
            soqlstring += ' where '+condetions;
        if(string.isNotEmpty(recordslimit))
            soqlstring += ' limit '+recordslimit;
        System.debug(soqlstring);
        if(string.isNotEmpty(soqlstring))    
            return Database.query(soqlstring);
        return null;
    }
}