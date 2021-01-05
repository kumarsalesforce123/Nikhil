public with sharing class HomePageController {
    @AuraEnabled
    public static List<Account> method1(String RecordIDofAccount, String TestingtheClass){
        List<Account> accList = [select id,name from account];
        return accList;

    }
}