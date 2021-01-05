public class shipping 
{
    public string EPC{set;get;}
    public string location{set;get;}
    public integer locid{get;set;}
    public list<selectoption> lstoptionlocation{get;set;}
    public list<location__c> loc;
    public string strError{get;set;}
    public shipping()
    {
        String message = '' + ApexPages.CurrentPage().GetParameters().Get('message');
        String pageHeaderReferer = ApexPages.currentPage().getHeaders().get('Referer'); 

        if(pageHeaderReferer != null && pageHeaderReferer.containsIgnoreCase('shipping') && message != 'null')
        {
               ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, message)); 
        }   
        lstoptionlocation=new list<selectoption>();
        loc=new list<location__c>();
        list<Location__c> locations=[select id,name from Location__c];
        lstoptionlocation.add(new selectoption('','--None--'));
        for(Location__c l:locations)
        {
            lstoptionlocation.add(new selectoption(l.id,l.name));
        }
    }
    public pagereference ship()
    {
        system.debug('-----------epc------'+EPC);
        list<inventory__c> inven = [select id,name, EPC__c from inventory__c where epc__c=:EPC];
        loc =[select id,name,location_ID__c from location__c where location_ID__c=:locid];
        system.debug('---------inven-------'+inven);
        if(!inven.isEmpty())
        {
            if(string.isNotBlank(location) && location != '')
            {
                inven[0].Shipping__c= location;
            }
            else if(!loc.isEmpty())
            {
                inven[0].Shipping__c= loc[0].id;
            }
            inven[0].user__c=userinfo.getuserId() ;
            inven[0].Shipping_Date_Time__c=DateTime.now();
            update inven;
        }
        else
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'EPC doesnot match. ')); 
        }
     
     pagereference pg=new pagereference('/apex/shipping');  
            
        pg.getParameters().put('message', 'Product Shipped Successfully');
         pg.setRedirect(true);
       
        return pg;
           
    }     
}