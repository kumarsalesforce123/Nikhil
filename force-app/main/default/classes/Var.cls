public class Var 
{

        public List<Sca__c> audited{get;set;}
        public List<Inven__c > missed{get;set;}
        public List<Sca__c> extra{get;set;}
        
    public Var()
    {
        missed=new List<Inven__c >();
        audited=new List<sca__c>();
        extra= new List<sca__c>();
    }
        
    public pagereference fetchDetails()
    {
        audited.clear();
        missed.clear();
        extra.clear();
          
        set<string> sepc=new set<string>();
        set<string> iepc=new set<string>();      

        date srdate = date.valueof(date.parse(Apexpages.currentPage().getParameters().get('sd')));
        date eddate = date.valueof(date.parse(Apexpages.currentPage().getParameters().get('ed')));       
        
        List<Sca__c> lstscan=[SELECT ID,EPC__c,Scanned_Date__c,Scanned__Latitude__s,Scanned__Longitude__s FROM Sca__c WHERE DAY_ONLY(createddate) >=:srdate and
                                   DAY_ONLY(createddate) <=:eddate];
                                  
        for(Sca__c s:lstscan)
        {
            sepc.add(s.EPC__c);
        }   
        
             
        List<Inven__c > linv=[SELECT ID,Name,EPC__c,Expiry__c,LOT__c,UPN__c, Createddate FROM Inven__c ];
        for(Inven__c i:linv)
        {
            iepc.add(i.EPC__c);
        }   
                        
        for (Sca__c scan:lstscan)
        {
           if(iepc.contains(scan.epc__c))   
           {
           audited.add(scan);          
           }
           else 
           {
           extra.add(scan);
           }       
        }
       
        for(Inven__c i: linv)
        {
            if(!sepc.contains(i.epc__c))
            {
                missed.add(i);
            }          
        }                
        return null;      
        }
}