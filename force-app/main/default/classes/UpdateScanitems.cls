@RestResource(urlMapping='/srtest/*')
global with sharing class UpdateScanitems {
    /*
    @HttpPost
    global static void doPost(string childProdInfos,string parentprodid) {
    List<invenscan__c> temp = (List<invenscan__c>)JSON.Deserialize(childProdInfos,List<invenscan__c>.class);
        
      string[] lstIds = (list<string>)JSON.deSerialize(parentprodid,list<string>.class);
      List<invenscan__c> ordlist = new List<invenscan__c>();
      List<invenscan__c> ordlistupd = new List<invenscan__c>();
      
       map<id,invenscan__c>mapsi = new map<id,invenscan__c>();
      for(integer i=0;i<temp.size();i++)
      {
          mapsi.put(lstIds[i],temp[i] );
          system.debug('id,value'+mapsi);
      }
      
      ordlist= [SELECT id,name from invenscan__c where id IN:lstIds];
      for(invenscan__c it :ordlist)
      {
          if(mapsi.containskey(it.id))
          {
             it.name=mapsi.get(it.id).name;
             ordlistupd.add(it);
          }
      }
        update ordlistupd;  
    }
    */
    @HttpPost
    global static void doPost(string scanInfo) {
    List<invenscan__c> scanLst = (List<invenscan__c>)JSON.Deserialize(scanInfo,List<invenscan__c>.class);
    // **** List to insert / upsert records based on EPC        
    List<invenscan__c> upsertScanLst = new list<invenscan__c>();
    // **** to Map Scan records with EPC 
    Map<string,invenscan__c> mapScanWithEpc = new Map<string,invenscan__c>();      
    // **** to Add unique EPC values
    set<string> scanEPC = new set<string>();
     
      for(integer i=0;i<scanLst.size();i++)
      {         
          scanEPC.add(scanLst[i].EPC__c);         
      }      
      for(invenscan__c invScan: [SELECT id,name,EPC__c from invenscan__c where EPC__c  IN:scanEPC]){
          mapScanWithEpc.put(invScan.EPC__c, invScan);
      }      
      for(integer i=0;i<scanLst.size();i++)
      {         
          if(!mapScanWithEpc.isEmpty() && mapScanWithEpc.containskey(scanLst[i].EPC__c)){
              upsertScanLst.add(new invenscan__c(id=mapScanWithEpc.get(scanLst[i].EPC__c).id,Name=scanLst[i].Name));
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