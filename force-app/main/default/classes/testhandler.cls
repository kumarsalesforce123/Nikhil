public without sharing class testhandler {
    
    public static boolean runonce = true;
    public static boolean run(){
        if(runonce){
            runonce = false;
            return true;
        }
        else{
            return runonce;
        }
        
    }
    @TestVisible
    public static void beforeinsert(List<Territory__c> newlist, List<Territory__c> oldlist, 
                                    Map<Id,Territory__c> newMap, Map<Id,Territory__c> oldMap){
                                        List<Territory__c> tlist = new List<Territory__c>();
        for(Territory__c t : newlist){
            Territory__c oldt = oldMap.get(t.Id);
            if(t.Name == oldt.Name){
                t.adderror('Error Message');                
            }            
        }  
                                        database.SaveResult[] st = database.insert(tlist, false);
                                         for(database.SaveResult s : st){
                                             if(s.issuccess()){
                                                 
                                             }
                                        
                                    }
                                    }
    
    public void afterinsert(List<Territory__c> newlist, List<Territory__c> oldlist){
        
    }

}