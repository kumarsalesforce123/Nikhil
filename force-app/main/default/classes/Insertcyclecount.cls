@RestResource(urlMapping='/Restapiopencyclecount/*')
global class Insertcyclecount {

    @HttpPost
   
        global static String doPost(String name,String Location, date startdate) {
        cyclecount__c count = new cyclecount__c();
        count.Name = name;
        count.Location__c = Location;
        count.Start_date__c=startdate;
        count.Pickl__c='Open';
        insert count;
        return count.id;                                        //    string countid= count.id;
                                               //      countid = [SELECT Cycle_Count_ID__c FROM cyclecount__c where id =:countid];
                                                           
                                                    /*
                                                    {
                                        "name" : "123456789",
                                        "Location" : "a0541000000cXW0"
                                        }
                                        */         
}

}