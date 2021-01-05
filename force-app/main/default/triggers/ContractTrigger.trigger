trigger ContractTrigger on Contract (before insert) { 
    
    // Creating an instance for Non static Method
    ContractTriggerHandler triggerHandlerItCanBeanyName = new ContractTriggerHandler();
    triggerHandlerItCanBeanyName.triggerclassNonStaticMethod(Trigger.New, Trigger.Old, Trigger.NewMap, Trigger.oldMap);
    
    // Not creating an instance because it is a static method 
	ContractTriggerHandler.triggerclassStaticMethod(Trigger.New, Trigger.Old, Trigger.NewMap, Trigger.oldMap);
}