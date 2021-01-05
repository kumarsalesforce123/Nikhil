trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    
    List<task> task = new List<task>();
    for (Opportunity o: Trigger.new)    
    {
        
        if(o.StageName == 'closed won')
        {           
            task t = new task();
            t.whatId = o.Id;
            t.subject = 'Follow Up Test Task';
            task.add(t);                    
        }
    }
    insert task;

}