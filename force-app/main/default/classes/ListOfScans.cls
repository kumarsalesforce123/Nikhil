public class ListOfScans 
{
    public list<wrapper> lstwrapper{get;set;}
    public integer rowIndex{get;set;}
    public list<sca__c> lstscan{get;set;}
    public ListOfScans()
    {
        map<string, wrapper> mapReport = new  map<string, wrapper>();
        lstwrapper =new list<wrapper>();
        Map<String,Inven__c > InvMap = new Map<String,Inven__c >();
        List<Inven__c> inven=[SELECT ID,Name,EPC__c, UPN__c, Lot__c,Expiry__c from Inven__c where EPC__c!=null];
        for(Inven__c inv:inven){
            InvMap.put(inv.EPC__c,inv);
        }
        List<Sca__c> scan= [SELECT EPC__c,Scanned__Latitude__s,Scanned__Longitude__s, Scanned_Date__c,Map_Link__c from Sca__c where EPC__c!=null];
        Map<String,Sca__c > scanMap = new Map<String,Sca__c >();        
        for(Sca__c sc:scan){
            if(!scanMap.containskey(sc.epc__c))
            scanMap.put(sc.epc__C,sc);
            else if(scanMap.containskey(sc.epc__c) && sc.Scanned_Date__c > scanMap.get(sc.epc__c).Scanned_Date__c ){
            scanMap.put(sc.epc__C,sc);   
            }
        }
        for(integer i=0; i<scanMap.values().size();i++)
        {
        
          //  if(InvMap.containskey(scan[i].EPC__c))
            {
            wrapper objWrap = new wrapper();
            objwrap.epc = scanMap.values()[i].EPC__c;
            objwrap.Scanneddate= scanMap.values()[i].Scanned_Date__c ;
            objwrap.scannedLatitude= scanMap.values()[i].Scanned__Latitude__s;
            objwrap.scannedLongitude= scanMap.values()[i].Scanned__Longitude__s;           
            objwrap.name= (InvMap.containskey(scanMap.values()[i].EPC__c)?InvMap.get(scanMap.values()[i].EPC__c).name:'');
            objwrap.upn= (InvMap.containskey(scanMap.values()[i].EPC__c)?InvMap.get(scanMap.values()[i].EPC__c).UPN__c:'');
            objwrap.expiry= (InvMap.containskey(scanMap.values()[i].EPC__c)?InvMap.get(scanMap.values()[i].EPC__c).Expiry__c:null);
            objwrap.lot= (InvMap.containskey(scanMap.values()[i].EPC__c)?InvMap.get(scanMap.values()[i].EPC__c).Lot__c:'');
            objwrap.gmap = scanMap.values()[i].Map_Link__c ;
            lstwrapper.add(objwrap);
            }
        }
    }
    public boolean displayPopup {get; set;}    
   
    public void closePopup()
    {       
        displayPopup = false;   
    }    
    public void showPopup()
    {       
        lstscan=[select id,name,map__c from sca__c where Map_Link__c =:lstwrapper[rowIndex].gmap];
        displayPopup = true;   
    }   
    
    
    public class wrapper
    {
        public string name{get;set;}  
        public string epc{get;set;}  
        public string upn{get;set;}  
        public date expiry{get;set;}
        public string lot{get;set;}  
        public datetime Scanneddate{get;set;}  
        public Decimal scannedLatitude{get;set;}  
        public Decimal scannedLongitude{get;set;}
        public string gmap{get;set;}  
    }
}