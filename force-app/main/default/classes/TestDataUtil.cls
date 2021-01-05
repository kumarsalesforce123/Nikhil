@isTest
public Class TestDataUtil {
    public static List<User> createUsers(Integer numberOfTestUsers, String profile) {
        List<User> Users = new List<User>();
        Profile userProfile = [SELECT Id FROM Profile WHERE Name =: profile];        
        for (Integer i = 0; i < numberOfTestUsers; i++) {
            User u = new User();
            u.Email = 'testUser'+ i + '@' + 'test' + i + 'test.com';
            u.LastName = 'TestUserLastName' + i;
            u.Username = 'testUser'+ i + '@test.com'+ i;
            u.CommunityNickname = 'ng' + i ;
            u.Alias = 'ng' + i + 'r';
            u.ProfileId = userProfile.Id;
            u.EmailEncodingKey = 'UTF-8';
            u.LanguageLocaleKey = 'en_US';
            u.TimeZoneSidKey = 'America/Los_Angeles';
            u.LocaleSidKey = 'en_US';
            u.IsActive = true;
            Users.add(u);
        }
        insert Users;
        return Users;
    }
    public static List<Account> createAccts(Integer numberOfTestAcc) {
        List<Account> Accounts = new List<Account>();      
        for (Integer i = 0; i < numberOfTestAcc; i++) {
            Account acc = new Account();
            acc.Name = 'Test ' + i;
            Accounts.add(acc);
        }
        insert Accounts;
        return Accounts;
    }
    public static List<Contact> createContacts(Integer numberOfTestcon, Id AccountId) {
        List<Contact> Contacts = new List<Contact>();      
        for (Integer i = 0; i < numberOfTestcon; i++) {
            Contact con = new Contact();
            con.LastName = 'Test ' + i;
            con.AccountId = AccountId;
     		Contacts.add(con);
        }
        insert Contacts;
        return Contacts;
    }
    public static List<Opportunity> createOpps(Integer numberOfTestOpps) {
        List<Opportunity> Opportunities = new List<Opportunity>();      
        for (Integer i = 0; i < numberOfTestOpps; i++) {
            Opportunity opp = new Opportunity();
            opp.Name = 'Test ' + i;
            opp.stageName = 'Prospecting';
            opp.CloseDate = date.Today();
     		Opportunities.add(opp);
        }
        insert Opportunities;
        return Opportunities;
    }
    public static List<OpportunityContactRole> createOCR(Integer numberOfTestocr, Id OppId, Id ContactId) {
        List<OpportunityContactRole> OpportunityContactRoleList = new List<OpportunityContactRole>();      
        for (Integer i = 0; i < numberOfTestocr; i++) {
            OpportunityContactRole ocr = new OpportunityContactRole();
            ocr.OpportunityId = OppId;
            ocr.ContactId = ContactId;
            ocr.role = 'Executive sponsor';
     		OpportunityContactRoleList.add(ocr);
        }
        insert OpportunityContactRoleList;
        return OpportunityContactRoleList;
    }
}