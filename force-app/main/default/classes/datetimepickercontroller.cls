public class datetimepickercontroller 
{
    public list<wrapper> auditedwrap{get;set;}
    public list<wrapper> missedwrap{get;set;}
    public list<wrapper> extrenimouswrap{get;set;}     
    public datetimepickercontroller ()
    {
       auditedwrap=new list<wrapper>();
       missedwrap=new list<wrapper>();
       extrenimouswrap=new list<wrapper>();
    }
        
    public pagereference fetchDetails()
    {
        auditedwrap.clear();
        missedwrap.clear();
        extrenimouswrap.clear();
        set<ID> scanID = new set<ID>();        
        datetime srdate = datetime.valueof(datetime.parse(Apexpages.currentPage().getParameters().get('sd')));
        datetime eddate = datetime.valueof(datetime.parse(Apexpages.currentPage().getParameters().get('ed')));       
        
        List<Inven__c> linv=[SELECT ID,Name,EPC__c,Expiry__c,LOT__c,UPN__c, Createddate FROM Inven__c WHERE createddate >=:srdate and createddate <=:eddate];
        List<Sca__c> lstscan=[SELECT ID,EPC__c,Scanned_Date__c,Scanned__Latitude__s,Scanned__Longitude__s FROM Sca__c WHERE createddate >=:srdate and createddate <=:eddate];  
        Map<String,Inven__c > InvMap = new Map<String,Inven__c >();
        Map<String,Sca__c > scanMap = new Map<String,Sca__c >();
        
        for(Sca__c sc:lstscan){
            if(!scanMap.containskey(sc.epc__c))
            scanMap.put(sc.epc__C,sc);
            else if(scanMap.containskey(sc.epc__c) && sc.Scanned_Date__c > scanMap.get(sc.epc__c).Scanned_Date__c ){
            scanMap.put(sc.epc__C,sc);   
            }
        }
        for(Inven__c inv:linv)
        {
            InvMap.put(inv.EPC__c,inv);
            if(!scanmap.containskey(inv.EPC__c)){
                wrapper objWrap = new wrapper();
                objwrap.epc = inv.EPC__c;                           
                objwrap.ProductDescription= inv.name;
                objwrap.upn= inv.UPN__c;
                objwrap.expiry= inv.Expiry__c;
                objwrap.lot= inv.Lot__c;            
                missedwrap.add(objwrap); 
            }
        }                              
        
                                                      
        for(integer i=0; i<scanMap.values().size();i++)
        {
            if(InvMap.containskey(scanMap.values()[i].EPC__c))
            {
                wrapper objWrap = new wrapper();
                objwrap.epc = scanMap.values()[i].EPC__c;
                objwrap.ScannedTime= scanMap.values()[i].Scanned_Date__c ;
                objwrap.scannedLat= scanMap.values()[i].Scanned__Latitude__s;
                objwrap.scannedLng= scanMap.values()[i].Scanned__Longitude__s;           
                objwrap.ProductDescription= (InvMap.containskey(scanMap.values()[i].EPC__c)?InvMap.get(scanMap.values()[i].EPC__c).name:'');
                objwrap.upn= (InvMap.containskey(scanMap.values()[i].EPC__c)?InvMap.get(scanMap.values()[i].EPC__c).UPN__c:'');
                objwrap.expiry= (InvMap.containskey(scanMap.values()[i].EPC__c)?InvMap.get(scanMap.values()[i].EPC__c).Expiry__c:null);
                objwrap.lot= (InvMap.containskey(scanMap.values()[i].EPC__c)?InvMap.get(scanMap.values()[i].EPC__c).Lot__c:'');            
                auditedwrap.add(objwrap);
                scanID.add(scanMap.values()[i].id);
            }
           
            if(!scanID.contains(scanMap.values()[i].id))
            {
                 wrapper objWrap = new wrapper();
                objwrap.epc = scanMap.values()[i].EPC__c;
                objwrap.ScannedTime= scanMap.values()[i].Scanned_Date__c ;
                objwrap.scannedLat= scanMap.values()[i].Scanned__Latitude__s;
                objwrap.scannedLng= scanMap.values()[i].Scanned__Longitude__s;                      
                extrenimouswrap.add(objwrap);
                scanID.add(scanMap.values()[i].id);          
            
            }            
                 
        }      
        return null;      
    }
        
    public class wrapper
    {
        public string ProductDescription{get;set;} 
        public string EPC{get;set;}  
        public string UPN{get;set;}
        public string lot{get;set;}   
        public datetime ScannedTime{get;set;}
        public Date expiry{get;set;}
        public Decimal scannedLat{get;set;}
        Public Decimal scannedLng{get;set;}
    }        
        
}