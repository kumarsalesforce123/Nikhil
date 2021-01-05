public class UnscanItemsPDFController 
{
    public string cycleid{get;set;}
    public string locationid{get;set;}
    public list<Inventory__c> lstinventory{get;set;}
    public UnscanItemsPDFController()
    {
        lstinventory=new list<Inventory__c>();
        cycleid=Apexpages.currentpage().getparameters().get('cycle');
        locationid=Apexpages.currentpage().getparameters().get('location');
        
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
        
    }
}