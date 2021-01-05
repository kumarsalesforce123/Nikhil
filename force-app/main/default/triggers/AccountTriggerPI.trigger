trigger AccountTriggerPI on Account (after insert) {
    
    AccountTriggerHandlerClass.AfterInsertOperation(Trigger.New);

}