trigger AccountTrigger on Account (before update, after Update) {

  // Nikhil Modied this trigger in vs code
    
    if(Trigger.IsBefore && Trigger.IsUpdate){
        AccountTriggerHandle.BeforeUpdate(Trigger.New , Trigger.OldMap);
    }
    else if(Trigger.IsAfter && Trigger.IsUpdate){
      //  AccountTriggerHandle.BeforeUpdate(Trigger.New , Trigger.OldMap);
    }
    
    

}