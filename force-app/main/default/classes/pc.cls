public class pc {
    
    private Static Map<String, String> getParagonLogindetails(){
        String paragonCredentails = System.label.Paragan_Credentials;
        APC_Paragon_Credentials__mdt  pcobj = [SELECT ID, User_Name__c,Password__c FROM APC_Paragon_Credentials__mdt WHERE MasterLabel =: paragonCredentails];
        Map<String,String> loginCredentailsMap = new Map <String ,String >();
        loginCredentailsMap.put('UserId', pcobj.User_Name__c);
        loginCredentailsMap.put('UserPswd', pcobj.Password__c);
        return loginCredentailsMap;
    } 
    
}