public class ContractTriggerHandler {
    
    public void triggerclassNonStaticMethod(List<Contract> NewContractList, List<Contract> OldContractList, 
                                    Map<Id,Contract> newContractMap, Map<Id,Contract> OldContractMap){
                                    }
    
    public static void triggerclassStaticMethod(List<Contract> NewContractList, List<Contract> OldContractList, 
                                    Map<Id,Contract> newContractMap, Map<Id,Contract> OldContractMap){
        if(Trigger.isbefore && Trigger.isInsert){
            // Both the lines 11 and 12 are callling beforeinsert method, both the statements are correct
            ContractTriggerHandler.beforeInsert();
            beforeInsert();
        }
        if(Trigger.isbefore && Trigger.isUpdate){
            beforeUpdate();
        }
        if(Trigger.isbefore && Trigger.isDelete){
            beforeDelete();
        }
        if(Trigger.isAfter && Trigger.isInsert){
            afterInsert();
        }
        if(Trigger.isAfter && Trigger.isUpdate){
            afterUpdate();
        }
        if(Trigger.isAfter && Trigger.isDelete){
            afterDelete();
        }
        if(Trigger.isAfter && Trigger.isundelete){
            afterundelete();
        }
    }
    public Static void beforeInsert(){
        
    }
    public Static void beforeUpdate(){
        
    }
    public Static void beforeDelete(){
        
    }
    public Static void AfterInsert(){
        
    }
    public Static void AfterUpdate(){
        
    }
    public Static void AfterDelete(){
        
    }
    public Static void AfterUndelete(){
        
    }            
}