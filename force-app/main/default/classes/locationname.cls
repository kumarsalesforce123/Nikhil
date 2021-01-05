@RestResource(urlMapping='/listlocation/*')
global with sharing class locationname
{
    @HttpGet
    global static list<Location__c> getlocations() 
    {
        set<string> lstempid =new set<string>();
        set<string> territorsid=new set<string>();
        set<string> locationassignid=new set<string>();
        list<Location__c> lstlocations=new list<Location__c>();
        list<Employee__c> lstemploy=[select id,name,User__c from Employee__c where User__c=:userinfo.getuserId()];
        for(Employee__c e: lstemploy)
        {
            lstempid.add(e.id); 
        }
        list<Assign_user__c> lstassignuser=[select id,name,Location__c,Employee__c,Territory__c from Assign_user__c where Employee__c IN :lstempid];
        for(Assign_user__c terr:lstassignuser)
        {
            locationassignid.add(terr.Location__c);
            territorsid.add(terr.Territory__c);
        }
        list<Territory__c> lstterritory=[select id,name,(select id,name from Locations__r)TerritoryID__c from Territory__c 
                                             where id IN:territorsid];
                                             
        list<Location__c> lstlocation=[select id,name from Location__c where id IN:locationassignid];
        for(Location__c loc:lstlocation)
        {
            lstlocations.add(loc);
        }
                                 
        for(Territory__c t:lstterritory) 
        {
            for(Location__c loc:t.Locations__r)
            {
               lstlocations.add(loc);
            }
        }        
        return lstlocations;
    } 
}