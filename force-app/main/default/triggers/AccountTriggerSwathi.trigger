trigger AccountTriggerSwathi on Account (before insert, after insert, Before Update, After Update, before Delete, after delete, after Undelete ) {
    
    if(trigger.isBefore && trigger.Isinsert){
        Swathi_Test.insertReddy(Trigger.New);
    }
    if(trigger.isBefore && trigger.IsUpdate){
        
    }
    if(trigger.isBefore && trigger.IsDelete){
        
    }
    if(trigger.isafter && trigger.Isinsert){
       
    }
    if(trigger.isafter && trigger.IsUpdate){
        
    }
    if(trigger.isafter && trigger.IsDelete){
        
    }
}