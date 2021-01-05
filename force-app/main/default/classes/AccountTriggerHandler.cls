public class AccountTriggerHandler {    
    public static void invokeMethod(List<Account> AccountList){
        Map<Id, Id> recordIdandUserId= new Map<Id, Id>();
        List<Id> accId = new List<Id>();
        for(Account a : AccountList){ 
            recordIdandUserId.put(a.Id, a.CreatedById);
            accId.add(a.Id);
        }
        system.debug('accId ' + accId);
    //    SalesforceSurveyHandler.salesForcesurvey(recordIdandUserId);
        SalesforceSurveyHandler.SalesSurveyFromPB(accId);
        
       /*     String sobjectType = a.Id.getSObjectType().getDescribe().getName();
            string aId;
            
            string communityId ;
            string SurveyId;
            string AccountEmail;
           
            string surveyInvd;
            
            User u = [select id, email from user where id =: a.CreatedById];
            AccountEmail = u.Email;
			aId = a.Id;
           
            
            communityId = [select Id from Network where Name='nikhil'].Id;
            SurveyId = [Select Id from Survey where Name='Nikhil Demo'].Id;
            
            SurveyInvitation SInv = New SurveyInvitation();
            
            SInv.Email__c = AccountEmail;
            SInv.Record_Id__c = a.Id;
            Sinv.CommunityId = communityId;
            SInv.Name = a.Name;
            SInv.OptionsCollectAnonymousResponse = true;
            SInv.OptionsAllowGuestUserResponse =true;
            SInv.SurveyId = SurveyId;
            
            insert SInv;
            
            SurveySubject SS = new SurveySubject();
            
            SS.SubjectId = aId;
            SS.ParentId = SInv.Id;
            SS.Name = a.Name;
            
            insert SS;
        } */
     //   a.addError(sobjectType);
    }       
}