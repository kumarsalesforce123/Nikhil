public class alertclass {
    
    public static void test(){
        List<user> users = [select id, email from user where email = 'nkr6838@gmail.com'];
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        List<String> sentToList = new List<String>();
        for(User u : users){
            sentToList.add(u.Email);
        }
        message.toAddresses = sentToList;
        message.subject = 'Opt Out Test Message';
        message.plainTextBody = 'This is the message body';          
        message.setSaveAsActivity(false);
        
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
    }
    
    public static void test2(){
        List<csuf__C> users = [select id, user__c, user__r.Email  from csuf__C where id =: 'a0P1C00000PFws7'];
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'gurramnikhil.sfdc@gmail.com'];
        
        //     EmailTemplate emailTemplate = [select Id, Subject, HtmlValue, Body from EmailTemplate where Id =: '00X1C000001yaZl'];
        
        List<Messaging.SingleEmailMessage> message = new List<Messaging.SingleEmailMessage>();
        for(csuf__C u : users){
            
            Messaging.SingleEmailMessage Mail = new Messaging.SingleEmailMessage();
            if ( owea.size() > 0 ) {
                mail.setOrgWideEmailAddressId(owea.get(0).Id);
            }
            
            //    String subject = emailTemplate.Subject;
            
            //    String plainTextBody = emailTemplate.HtmlValue;
            //	  plainTextBody = plainTextBody.replace('{!csuf__c.Id}', u.ID);
            
            //  Mail.setSubject(subject);
            //   Mail.setHtmlBody(plainTextBody);
            
            Mail.setTargetObjectId(u.user__c);             
            Mail.subject = 'Re : Pending Approval';
            Mail.plainTextBody = 'Hi, ' + ' This is to Inform that you have a pending Approval. To View this in salesforce Please visit:' + '\r\n\r\n' + URL.getSalesforceBaseUrl().toExternalForm()+'/0011C00002W0Vx2';      
            Mail.setSaveAsActivity(false);
            message.add(Mail);
        }
        Messaging.SendEmailResult[] results = Messaging.sendEmail(message);
    }
    
    public static void test3(){
        
        List<csuf__C> users = [select id, user__c, user__r.Name,user__r.Email  from csuf__C where id =: 'a0P1C00000PFws7'];
        
        String sentEmail;        
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address =: sentEmail];                
        EmailTemplate emailTemplate = [SELECT Id FROM EmailTemplate WHERE Name = 'Multiple Sales Proposal Submission' Limit 1];
        
        List<Messaging.SingleEmailMessage> message = new List<Messaging.SingleEmailMessage>();
        for(csuf__C u : users){
            
            Messaging.SingleEmailMessage Mail = new Messaging.SingleEmailMessage();
            if ( owea.size() > 0 ) {
                mail.setOrgWideEmailAddressId(owea.get(0).Id);
            }
            
            String subject = emailTemplate.Subject;
            
            String plainTextBody = emailTemplate.HtmlValue;
            plainTextBody = plainTextBody.replace('{!Receiving_User.FirstName},', u.user__r.Name);
            plainTextBody = plainTextBody.replace('{!csuf__c.Link}', URL.getSalesforceBaseUrl().toExternalForm()+'/' + u.Id);
            
            Mail.setSubject(subject);
            Mail.setHtmlBody(plainTextBody);            
            Mail.setTargetObjectId(u.user__c);             
            Mail.setSaveAsActivity(false);
            message.add(Mail);
        }
        Messaging.SendEmailResult[] results = Messaging.sendEmail(message);
    }
}