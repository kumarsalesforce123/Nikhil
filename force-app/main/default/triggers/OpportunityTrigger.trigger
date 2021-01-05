/* 
Type Name: opportunityTrigger
Author: Nikhil Kumar Gurram
Created Date: 07/14/2020

Functionality: 
1. Trigger on Opportunity

Change History : 
SL No.  |   Date    |   ModifiedBy      |   Modified Reason 

*/

trigger OpportunityTrigger on Opportunity (before insert, before update, after insert, after update, after delete, after undelete, before delete) {   
    new OpportunityTriggerHandler().run();
}