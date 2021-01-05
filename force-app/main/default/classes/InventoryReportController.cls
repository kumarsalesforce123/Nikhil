public class InventoryReportController 
{
    public list<selectoption> lstoptionlocation{get;set;}
    public list<selectoption> lstoptioncycle{get;set;}
    public string locationid{get;set;}
    public string cycleid{get;set;}
    public list<Inventory__c> lstinventory{get;set;}
    public InventoryReportController()
    {
        lstoptioncycle=new list<selectoption>();
        lstoptionlocation=new list<selectoption>();
        lstoptioncycle.add(new selectoption('--None--','--None--'));
        list<Location__c> locations=[select id,name from Location__c];
        lstoptionlocation.add(new selectoption('--None--','--None--'));
        for(Location__c l:locations)
        {
            lstoptionlocation.add(new selectoption(l.id,l.name));
        }
    }
    public void cycleCount()
    {
        lstoptioncycle.clear();
        if(locationid !='--None--' || locationid != '')
        {
            list<cyclecount__c> lstcycle=[select id,name,Location__c from cyclecount__c where Location__c=:locationid];
   //28 line added         
            
            lstoptioncycle.add(new selectoption('--None--','--None--'));
            for(cyclecount__c cycle: lstcycle)
            {
                lstoptioncycle.add(new selectoption(cycle.id,cycle.name));
            }
        }
    }
    
    public pagereference submit()
    { 
        lstinventory=new list<Inventory__c>();
        map<id,scan__c> mapscan=new map<id,scan__c>();
        list<scan__c> lstscan=[select id,name,EPC__c,Scan_time__c from scan__c where cyclecount__c=:cycleid];
        for(scan__c s :lstscan)
        {
            mapscan.put(s.EPC__c,s);
        }
        
        list<Inventory__c> invntory=[select id,Name,EPC__c,Product_number__c,Product_number__r.name,Product_number__r.Product_Description__c,LocationID__c from Inventory__c where LocationID__c=:locationid];
        for(Inventory__c inv: invntory)
        {
            if(!mapscan.containsKey(inv.id))
            {
                lstinventory.add(inv);
            }
        }
        return null;
    }
    public pagereference generatePDF()
    {
        
        pagereference ref=new pagereference('/apex/UnscanItemsPDF');
        ref.getParameters().put('cycle',cycleid);
        ref.getParameters().put('location',locationid);
        ref.setRedirect(true);
        return ref;
    }
    
}