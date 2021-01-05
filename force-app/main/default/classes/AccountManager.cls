@RestResource(urlMapping='/Accounts/*/contacts')
global class AccountManager {
    // Removing the comments
    @HttpGet
    global static Account getAccount() {
        RestRequest req = RestContext.request;
        String accId = req.requestURI.substringBetween('Accounts/', '/contacts');
        Account acc = [SELECT Id, Name, (SELECT Id FROM Contacts) 
                       FROM Account WHERE Id = :accId];
		return acc;
    }
}