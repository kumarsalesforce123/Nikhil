public class TotalHistotyReportController {
  
    public list<selectoption> lstoptionlocation{get;set;}
    public list<selectoption> lstoptionterritories{get;set;}
    public list<selectoption> lstoptioncyclecount{get;set;}
    public list<scan__c> auditedscanitems{get;set;}
    public list<scan__c> Extraneousitems{get;set;}
    public list<Inventory__c> misseditems{get;set;}
    public TotalHistotyReportController()
    {
        misseditems=new list<Inventory__c>();
        auditedscanitems=new list<scan__c>();
        Extraneousitems=new list<scan__c>();
        lstoptionlocation=new list<selectoption>();
        lstoptionterritories=new list<selectoption>();
        lstoptioncyclecount=new list<selectoption>();
        list<Location__c> locations=[select id,name from Location__c];
        lstoptionlocation.add(new selectoption('','--None--'));
        for(Location__c l:locations)
        {
            lstoptionlocation.add(new selectoption(l.id,l.name));
        }
        list<Territory__c> lstterritory=[select id,name from Territory__c];
        lstoptionterritories.add(new selectoption('','--None--'));
        for(Territory__c t:lstterritory)
        {
            lstoptionterritories.add(new selectoption(t.id,t.name));
        }
        list<cyclecount__c> lstcycle=[select id,name from cyclecount__c];
        lstoptioncyclecount.add(new selectoption('','--None--'));
        for(cyclecount__c c:lstcycle)
        {
            lstoptioncyclecount.add(new selectoption(c.id,c.name));
        }
    }
    public pagereference fetchDetails()
    {
        auditedscanitems.clear();
        Extraneousitems.clear();
        misseditems.clear();
        
        set<string> inventoryid=new set<string>();
        date srdate = date.valueof(date.parse(Apexpages.currentPage().getParameters().get('sd')));
        date eddate = date.valueof(date.parse(Apexpages.currentPage().getParameters().get('ed')));
        string loc= Apexpages.currentPage().getParameters().get('lo');
        string ter=Apexpages.currentPage().getParameters().get('terri');
        string cyc=Apexpages.currentPage().getParameters().get('cycl');
      
        list<Location__c> locationlst=[select id,name from Location__c where Territory__c=:ter and Territory__c!=null];
     
        list<cyclecount__c> cyclecountlst=[select id,name, Location__c from cyclecount__c where id=:cyc ];
        set<string> lociid=new set<string>();
        lociid.clear();
        
        if(loc!=null)
        {
            lociid.add(loc);
        }
        for(Location__c l: locationlst)
        {
            lociid.add(l.id);
        }
        for(cyclecount__c c:cyclecountlst)
        {
            if(c.Location__c !=null)
            lociid.add(c.Location__c);
        }
        
        list<scan__c> lstscan=[select id,name,Scanned_By__c,LocationID__c,Scan_time__c,EPC__c,EPC__r.name,EPC__r.Product_number__r.name,EPC__r.Product_number__r.Product_Description__c,
                                EPC__r.Product_number__r.GTIN__c,LocationID__r.name,LocationID__r.location_ID__c from scan__c where DAY_ONLY(createddate) >=:srdate and
                                   DAY_ONLY(createddate) <=:eddate and LocationID__c IN :lociid];
                                   
        set<id> epcid=new set<id>();
        map<id,Inventory__c> invmap=new map<id,Inventory__c>();
        for(scan__c s:lstscan)
        {
            if(s.EPC__c !=null)
            epcid.add(s.EPC__c);
        }  
        
        list<Inventory__c> linv=[select id,name,LocationID__c from Inventory__c where id IN :epcid];
        for(Inventory__c i:linv)
        {
            invmap.put(i.id,i);
        }
        for(scan__c scan: lstscan) 
        {
            if(!lociid.isEmpty() && invmap.containskey(scan.EPC__C) && lociid.contains(invmap.get(scan.EPC__C).LocationID__c))
            {
                auditedscanitems.add(scan);
            }
            else if(!lociid.isEmpty() && invmap.containskey(scan.EPC__C) && !lociid.contains(invmap.get(scan.EPC__C).LocationID__c))
            {
                Extraneousitems.add(scan);
            } 
        } list<Inventory__c> lstinv=[select id,name,Shipping__c,Product_number__c,Product_number__r.Name,Product_number__r.GTIN__c,Product_number__r.Product_Description__c, 
                                    Shipping__r.Name,Shipping__r.location_ID__c from Inventory__c where DAY_ONLY(createddate) >=:srdate and
                                      DAY_ONLY(createddate) <=:eddate and LocationID__c IN :lociid and id !=:epcid];                         
        
        for(Inventory__c inv:lstinv)
        {
            misseditems.add(inv);
        }                            
        
    return null;
    }
}