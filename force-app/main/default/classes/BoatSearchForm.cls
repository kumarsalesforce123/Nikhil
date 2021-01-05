public with sharing class BoatSearchForm
{
        @AuraEnabled
        public static List<BoatType__c> getBoatTypes() 
        {
                List<BoatType__c> boatTypes = [SELECT Id, Name FROM BoatType__c order by Name];
                return boatTypes;
        }
}