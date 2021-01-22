public with sharing class AccountHelper {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList() {
        return [SELECT Id, Name, Type, Rating,
                Phone, Website, AnnualRevenue
            FROM Account];
    }
    
    @AuraEnabled(cacheable=true)
    public static Account getAccounts(String ID) {
        return [SELECT Id, Name, Type, Rating,
                Phone, Website, AnnualRevenue
                FROM Account where id =: ID];
    }

    @AuraEnabled(cacheable=true)
    public static Map<string,object> getAccountWithId(String Id) {
        Map<string,object> accountFieldSetsConfig = AccountHelper.getAccountFieldSets();
        //Map<string,object> respose = new Map<string,object>();
        if(!accountFieldSetsConfig.isEmpty() && String.isNotEmpty(Id))
        {
            set<string> fields = (set<string>)accountFieldSetsConfig.get('fieldApis');
            if(!fields.isEmpty())
            {
                fields.add('Id');   
                fields.add('Name');            
                string Fieldstring = String.join(new List<String>(fields),',');
                System.debug('Fieldstring'+' '+Id);
                System.debug('SELECT '+Fieldstring+' FROM Account where id =: Id');
                //return Database.query('SELECT '+Fieldstring+' FROM Account where id =: ID');
                //return Security.stripInaccessible(AccessType.READABLE, Database.query('SELECT '+Fieldstring+' FROM Account where id =: ID')).getRecords()[0];
                /*return new Map<string,object>{
                    'Record' => Security.stripInaccessible(AccessType.READABLE, Database.query('SELECT '+Fieldstring+' FROM Account where id =: Id')).getRecords()[0],
                    'Config' => accountFieldSetsConfig
                }; */
                Account acc = Database.query('SELECT '+Fieldstring+' FROM Account where id =: Id limit 1');
                return new Map<string,object>{
                    'Record' => acc,
                    'Config' => accountFieldSetsConfig
                };
            }             
        }
        //return null;
        return new Map<string,object>{
            'Config' => accountFieldSetsConfig
        };    
    }    

    @AuraEnabled(cacheable = true)
    public static Map<string,object> getAccountFieldSets()
    {
        List<string> FieldSetNames= new List<string>{'Field_set_1','Field_set_2','Field_set_3','Field_set_4'}; 
        Map<string,object> AccountFieldSetSchema = new Map<string,object>();
        Map<string,object> AccountFieldSets = new Map<string,object>();
        Map<string,object> AccountFieldApiInfo = new Map<string,object>();
        set<string> fieldApis = new set<string>();
        for(integer i=0; i < FieldSetNames.size(); i++){
            List<Schema.FieldSetMember> fieldSetMembers = ((SObject)Type.forName('account').newInstance()).getSObjectType().getDescribe().FieldSets.getMap().get(FieldSetNames[i]).getFields();
            List<FieldSetField> fields = new List<FieldSetField>();
            set<string> fieldApiNames = new set<string>();
            for (Schema.FieldSetMember fieldSetMember : fieldSetMembers)
            {
                FieldSetField fieldSetField = new FieldSetField(fieldSetMember);
                fields.add(fieldSetField);
                fieldApiNames.add(fieldSetField.apiName);
                fieldApis.add(fieldSetField.apiName);
                AccountFieldApiInfo.put(fieldSetField.apiName,fieldSetField);
            }
            AccountFieldSetSchema.put(FieldSetNames[i], fields);
            AccountFieldSets.put(FieldSetNames[i], fieldApiNames);
        }   
        return new Map<string,object>{
            'AccountFieldSetSchema' => AccountFieldSetSchema,
            'AccountFieldSets' => AccountFieldSets,
            'fieldApis' => fieldApis,
            'AccountFieldApiInfo' => AccountFieldApiInfo
        };     
    }
    
}