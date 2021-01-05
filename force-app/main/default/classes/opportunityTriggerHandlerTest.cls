/* 
Type Name: opportunityTriggerHandlerTest
Author: Nikhil Kumar Gurram
Created Date: 07/14/2020

Functionality: 
1. Handler Class for Opportunity trigger

Change History : 
SL No.  |   Date    |   ModifiedBy      |   Modified Reason 

*/
@isTest(SeeAllData=True)
private class opportunityTriggerHandlerTest {
	static final Integer numberOfTestRecords = 20;    
    @isTest static void checkOpportunityContactRoles() {
        List<User> adminUser = TestDataUtil.createUsers(numberOfTestRecords, 'System Administrator');
        System.runAs(adminUser[0]){
            Test.StartTest();
            List<Account> AccountList = TestDataUtil.createAccts(numberOfTestRecords);
            List<contact> ContactList = TestDataUtil.createContacts(numberOfTestRecords, AccountList[0].Id);
            List<Opportunity> OpportunityList = TestDataUtil.createOpps(numberOfTestRecords); 
            List<OpportunityContactRole> OCRList = TestDataUtil.createOCR(numberOfTestRecords, OpportunityList[0].Id, ContactList[0].Id);
            Opportunity Opp = [select Id, stagename from Opportunity where Id = :OpportunityList[0].Id];
            opp.StageName='Closed Lost';
            Update opp;
            Test.StopTest();
        }
    }
}