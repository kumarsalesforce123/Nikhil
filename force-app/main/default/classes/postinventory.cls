@RestResource(urlMapping='/Restapipostinventory/*')
global with sharing class postinventory {

@HttpPost
    global static string doPost(string scans) {
    List<scan__c> scan= (List<scan__c>)JSON.Deserialize(scans,List<scan__c>.class);
       insert scan;
     
           return 'Records inserted Successfully';
           }
           }