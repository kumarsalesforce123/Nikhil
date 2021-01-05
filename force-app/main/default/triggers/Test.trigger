trigger Test on Territory__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
   //  if(testhandler.run()){
        if(trigger.isbefore && trigger.isinsert){
        	// testhandler.beforeinsert(trigger.New, Trigger.Old, trigger.newmap, trigger.oldmap);
        }
        else if(trigger.isbefore && trigger.isupdate){
            
        }
        if(trigger.isexecuting){
            
        }
        if(trigger.size < 1){
            
        }
  //  }
}