@RestResource(urlMapping='/insertscan/*')
global with sharing class InsertScanitems {


 @HttpPost
    global static void doPost(string scans) {
    List<scan__c> scan= (List<scan__c>)JSON.Deserialize(scans,List<scan__c>.class);
       insert scan; 
    /*  string[] lstIds = (list<string>)JSON.deSerialize(parentprodid,list<string>.class);
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
        */
    }
    }