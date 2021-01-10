public class Wrpapper {
    
    public class AccountWrapper{
        @AuraEnabled
        public String fieldName;
        @AuraEnabled
        public String accountValue;
        @AuraEnabled
        public String fieldSetName;
        @AuraEnabled
        public String fieldLabel;
    }
    
    @AuraEnabled(cacheable = true)
    public static List<AccountWrapper> wrpapper(String Id){
        List<AccountWrapper> accWrapperList = new List<AccountWrapper>();
        List<string> FieldSetNames = new List<string>{'Field_set_1','Field_set_2'}; 
        Map<String, String> accountMap = new Map<String, String>();
        String query = 'SELECT Id';
        for(integer i=0; i < FieldSetNames.size(); i++){
            List<Schema.FieldSetMember> fieldSetMembers = ((SObject)Type.forName('Account').newInstance()).getSObjectType().getDescribe().FieldSets.getMap().get(FieldSetNames[i]).getFields();
            for(Schema.FieldSetMember fieldSetMember : fieldSetMembers){
                query += ', ' + fieldSetMember.fieldPath;
                accountMap.put(fieldSetMember.fieldPath, FieldSetNames[i] + ':' + fieldSetMember.label);              
            }
        } 
        query += ' FROM Account WHERE Id =: Id';
        Account acc = database.query(query);
        for(String s : accountMap.keySet()){
            for(SObjectField field: Account.sobjectType.getDescribe().fields.getMap().values()) {
                if(string.valueof(field) == s) {
                    List<String> strSplit = accountMap.get(s).split('\\:');
                    AccountWrapper accWrapper = new AccountWrapper();
                    accWrapper.fieldName = s;
                    // Add the field value dynamically
                    //   accWrapper.accountValue = acc.field.getDescribe().getLabel();
                    accWrapper.fieldSetName = strSplit[0];
                    accWrapper.fieldLabel = strSplit[1];
                    accWrapperList.add(accWrapper);
                } 
            }                        
        }     
        system.debug('accWrapper    ' + accWrapperList);
        return accWrapperList;        
    }    
}