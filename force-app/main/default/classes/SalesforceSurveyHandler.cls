public class SalesforceSurveyHandler {   
    public static void SalesSurveyFromPB(List<Id> recordIds){
        system.debug('recordIds  ' + recordIds);
        String sobjectType = recordIds[0].getSObjectType().getDescribe().getName();
        Map<Id, String> recordInfo = new Map<Id,String>();
        string recid = recordIds[0];
        String query =  'Select Id,createdbyId FROM ' + sobjectType + ' WHERE Id IN: recordIds ' ;
        system.debug('query. '+ query);
        List<Sobject> ListofSobjectRecords = Database.query(query);
        system.debug('ListofSobjectRecords' + ListofSobjectRecords);
        Map<Id, Id> recordIdandUserId = new Map<Id, Id>(); 
        /* 
         string sobjectType = 'account';
List<ID> accid = new List<ID>{'0011C00002W1BPE', '0011C00002W1BPE'} ;
String query =  'Select Id,createdbyId FROM '+ sobjectType +' WHERE Id IN: accid ' ;
system.debug('query. '+ query);
List<Sobject> ListofSobjectRecords = Database.query(query);
System.debug('ListofSobjectRecords' + ListofSobjectRecords); */
    }
    Public static void salesForcesurvey(Map<Id,Id> recordIdandUserId){
        Map<Id, String> UserIdEmail = new Map<Id, String>();
        List<User> LstofUsers = [SELECT ID, Email FROM User WHERE ID IN: recordIdandUserId.values()];
        for(User u : LstofUsers){
            UserIdEmail.put(u.Id, u.Email);
        }
        set<Id> recsId = new set<Id>();
        List<SurveyInvitation> ListOfSurveyInvitation = new List<SurveyInvitation>();
        List<SurveySubject> ListOfSurveySubject = new List<SurveySubject>();
        
        for(Id recId : recordIdandUserId.keyset()){
            recsId.add(recId);                   
            string contactorUserEmail = UserIdEmail.get(recordIdandUserId.get(recId));                       
            string communityId = [select Id from Network where Name='nikhil'].Id; // put in custom label
            string SurveyId = [Select Id from Survey where Name='Nikhil Demo'].Id; // put in custom label
            
            SurveyInvitation SInv = New SurveyInvitation(); 
            
            SInv.Email__c = contactorUserEmail;
            SInv.Record_Id__c = recId;
            Sinv.CommunityId = communityId;
            SInv.Name = recId;
            SInv.OptionsCollectAnonymousResponse = true;
            SInv.OptionsAllowGuestUserResponse =true;
            SInv.SurveyId = SurveyId;
            ListOfSurveyInvitation.add(SInv);
        }
        Database.SaveResult[] srList = Database.insert(ListOfSurveyInvitation, false);
        for (Database.SaveResult sr : srList) {
            if (sr.isSuccess()) {
                for(Id r : recsId){
                    SurveySubject SS = new SurveySubject();            
                    SS.SubjectId = r;
                    SS.ParentId = sr.Id;
                    SS.Name = r;
                    ListOfSurveySubject.add(ss);
                }                               
            }
        }
        insert ListOfSurveySubject;
    }
}