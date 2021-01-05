/* 
Type Name: opportunityTriggerHandler
Author: Nikhil Kumar Gurram
Created Date: 07/14/2020

Functionality: 
1. Handler Class for Opportunity trigger

Change History : 
SL No.  |   Date    |   ModifiedBy      |   Modified Reason 

*/

public without sharing class opportunityTriggerHandler extends TriggerHandler{
    protected override void beforeUpdate(){
        checkOpportunityContactRoles();
    }    
	// Method to check the Specific Opportunity Contact Roles for each stage to be selected.    
    public void checkOpportunityContactRoles(){  
        //Map to store the Opportunities whose stage name got changed
        Map<Id, Opportunity> opportunityMap = new Map<Id, Opportunity>();        
        for(Opportunity newOpp : (List<Opportunity>)Trigger.new){
            //checking if New stage and Old Stage are equal or not.
            Opportunity oldOpp = (Opportunity)trigger.oldMap.get(newOpp.Id) ;
            if(newOpp.StageName != oldOpp.StageName){
                opportunityMap.put(newOpp.Id, newOpp);
            }
        } 
        if(!opportunityMap.isEmpty()){
            // Set to Hold the Opportunity Ids.
            Set<Id> opportunityIds = new Set<Id>(); 
            //Quering the List of Opportunity Contact Roles for the Opportunities in the opportunityMap
            for(Opportunity opp : [SELECT Id,StageName,(SELECT ID,Role FROM opportunitycontactroles) FROM opportunity where ID IN: opportunityMap.keyset()]){
                //List to hold all the exisiting Contact Roles for the Particular Opportunity
                List<String> oppRoleList = new List<String>();
                for(opportunitycontactrole oppcontactRoles : opp.opportunitycontactroles){
                    oppRoleList.add(oppcontactRoles.Role);                      
                }
                // Getting the Contact Role that need to exist for the Particular Opportunity stage
                Opportunity_Contact_Roles_For_Stages__c ocr = Opportunity_Contact_Roles_For_Stages__c.getValues(opportunityMap.get(opp.Id).StageName);
                if(!oppRoleList.contains(ocr.Opportunity_Contact_Role__c)){
                    opportunityIds.add(opp.Id);
                }                
            }
            for(Opportunity newOpp : (List<Opportunity>)Trigger.new){
                if(opportunityIds.contains(newOpp.Id)){
                    newOpp.addError(system.Label.OpportunityStageContactRole);
                }
            }
        }
    }
}