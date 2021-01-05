public class shippingcomponent 
{
    public string EPC{set;get;}
    public string location{set;get;}
    public list<selectoption> lstoptionlocation{get;set;}
    list<location__c> loc = new list<location__c>();
 
    public shippingcomponent ()
    {
        String message = '' + ApexPages.CurrentPage().GetParameters().Get('message');
        String pageHeaderReferer = ApexPages.currentPage().getHeaders().get('Referer'); 

        if(pageHeaderReferer != null && pageHeaderReferer.containsIgnoreCase('shipping') && message != 'null')
        {
               ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, message)); 
        }
        lstoptionlocation=new list<selectoption>();
        list<Location__c> locations=[select id,name from Location__c];
        lstoptionlocation.add(new selectoption('--None--','--None--'));
        for(Location__c l:locations)
        {
            lstoptionlocation.add(new selectoption(l.id,l.name));
        }
    }
    public pagereference ship()
    {
        pagereference pg;
        if(EPC==null || EPC=='')
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'EPC is required. ')); 
        }
        else
        {
            list<inventory__c> inven = [select id,name, EPC__c from inventory__c where epc__c=:EPC];
            loc =[select id,name from location__c where name=:location];
            if(!inven.isEmpty())
            {
                if(location == '--None--' || location ==null  )
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Location is required. '));
                    return null;
                    
                }
                else
                {
                    inven[0].Shipping__c= location; 
                }
                inven[0].user__c=userinfo.getuserId() ;
                inven[0].Shipping_Date_Time__c=DateTime.now();
                update inven;
            }
            else
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'EPC doesnot match. ')); 
            }
          //  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Product Shipped Successfully '));
            pg=new pagereference('/apex/CustomTab?SelectedTab=Shipping');
           // pg.getParameters().put('message', 'Product Shipped Successfully');
            pg.setRedirect(true); 
        }    
        return pg;
    }     
}