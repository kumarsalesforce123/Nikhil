@RestResource(urlMapping='/cyclecount/*')
global class CyclecountUpdate{

    @HttpPost 
    global static String cyclepost(String cid) 
    {
        cyclecount__c cyclecount=[select id,cycle_count_ID__c,Pickl__c from cyclecount__c where cycle_count_ID__c=:cid];
        if(cyclecount.cycle_count_ID__c !=null && cid==cyclecount.cycle_count_ID__c)
        {    
            cyclecount.Pickl__c='Close';
            update cyclecount; 
        }     
        return cyclecount.id;                        
    }
}