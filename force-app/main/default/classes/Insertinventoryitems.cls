@RestResource(urlMapping='/fieldcommision/*')
global with sharing class Insertinventoryitems {


 @HttpPost
    global static void doPost(string inventory) {
    List<inventory__c> inven= (List<inventory__c>)JSON.Deserialize(inventory,List<inventory__c>.class);
       insert inven; 
       }
       }