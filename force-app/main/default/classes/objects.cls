public class objects {
    
    @AuraEnabled
    public Static DataTableResponse listofRecords(String objectName, String fieldNames){ 
        // Split the selected fields
        List<String> ListOfFields = fieldNames.split('\\,');
        // List of fields to be queryed
        List<String> listOfFieldsToQuery = new List<String>();
        // List to hold the table hearders 
        List<String> listDataLabel = new List<String>();
        // The final wrapper response to return to Lightning component
        DataTableResponse response = new DataTableResponse();
        
        // Get the API names of the selected fields
        Map<String, Schema.SObjectType> globalDescribeMap = Schema.getGlobalDescribe();
        Schema.Describesobjectresult desctibeSobjectResult = globalDescribeMap.get(objectName).getDescribe();
        Map<String, Schema.SObjectField> fieldSchema = desctibeSobjectResult.fields.getMap();
        
        for(String fs : fieldSchema.KeySet())
        {
            if(ListOfFields.contains(fieldSchema.get(fs).getDescribe().getLabel())){                                                                
                listDataLabel.add(String.valueOf(fieldSchema.get(fs).getDescribe().getLabel()));
                listOfFieldsToQuery.add(String.valueOf(fieldSchema.get(fs).getDescribe().getName()));
            }    
        }                   
        //Create an SOQL to fetch the data and Set the wrapper instance and return as response
        String query = 'SELECT ' + String.join(listOfFieldsToQuery, ',') + ' FROM ' + objectName;
        response.listDataTableLabel = listDataLabel;
        response.listDataTableNames = listOfFieldsToQuery;
        response.listDataTableData = Database.query(query);
        system.debug('response . '+ response);
        return response;        
    }
    
    //Wrapper calss to hold response - This response is used in the lightning:datatable component
    public class DataTableResponse {
        @AuraEnabled
        public List<String> listDataTableNames {get;set;}
        @AuraEnabled
        public List<sObject> listDataTableData {get;set;}    
        @AuraEnabled
        public List<String> listDataTableLabel {get;set;}
        
        public DataTableResponse(){
            listDataTableNames = new List<String>();
            listDataTableData = new List<sObject>();
            listDataTableLabel = new List<String>();
        }
    }
    @AuraEnabled
    public static List <String> deleteRecords(List <String> lstRecordId, String SobjectName) { 
        List <String> oErrorMsg = new List < String > ();
        system.debug('query .  '+ lstRecordId);
        String query =  'SELECT ID FROM ' + SobjectName + ' WHERE ID IN ' + lstRecordId ;
        system.debug('query .  '+ query);
        List<sObject> sObjectList = Database.query(query);
        system.debug('sObjectList .  '+ sObjectList);
        Database.DeleteResult[] DR_Dels = Database.delete(sObjectList, false);
        for (Database.DeleteResult dr: DR_Dels) {
            if (dr.isSuccess()) {
            } 
            else { 
                oErrorMsg.add('');
                for (Database.Error err: dr.getErrors()) {
                    oErrorMsg.add(err.getStatusCode() + ': ' + err.getMessage());
                }
            }
        }
        return oErrorMsg;        
    }
}