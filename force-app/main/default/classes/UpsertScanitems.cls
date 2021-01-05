@RestResource(urlMapping='/scanupdate/*')
global with sharing class UpsertScanitems {
    
    
    @HttpPost
    global static void doPost(string scans) {
    List<scan__c> scanLst = (List<scan__c>)JSON.Deserialize(scans,List<scan__c>.class);
    // **** List to insert / upsert records based on EPC        
    List<scan__c> upsertScanLst = new list<scan__c>();
    // **** to Map Scan records with EPC 
    Map<string,scan__c> mapScanWithEpc = new Map<string,scan__c>();      
    // **** to Add unique EPC values
    set<string> scanEPC = new set<string>();
     
      for(integer i=0;i<scanLst.size();i++)
      {         
          scanEPC.add(scanLst[i].EPC__c);         
      }      
      for(scan__c Scan: [SELECT id,name,EPC__c from scan__c where EPC__c  IN:scanEPC]){
          mapScanWithEpc.put(Scan.EPC__c, Scan);
      }      
      for(integer i=0;i<scanLst.size();i++)
      {         
          if(!mapScanWithEpc.isEmpty() && mapScanWithEpc.containskey(scanLst[i].EPC__c)){
              upsertScanLst.add(new scan__c(id=mapScanWithEpc.get(scanLst[i].EPC__c).id,Name=scanLst[i].Name));
          }
          else
           upsertScanLst.add(scanLst[i]);  
      }
      // *** DML to upsert records
      if(!upsertScanLst.isEmpty() && upsertScanLst!=null){ 
      try{
          upsert upsertScanLst;
          }
          catch(exception e){
              system.debug('--------Exception found----:'+e.getmessage());
          }
      }
      
    }
 }