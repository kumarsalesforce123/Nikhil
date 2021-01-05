public class commision 
{
    public string locationname{get;set;}
    public string barcode{set;get;}
    public list<product__c> prod{get;set;}
    public string upn{get;set;}
    public string expiry{get;set;}
    public string lotno{get;set;}
    public list<selectoption> lstoptionlocation{get;set;}
    public boolean flag{get;set;}
    public string obj{get;set;}
    public string hexepc{get;set;}
    public commision()
    {
        String message = '' + ApexPages.CurrentPage().GetParameters().Get('message');
        String pageHeaderReferer = ApexPages.currentPage().getHeaders().get('Referer'); 

        // Use the referrer parameter to only show the message when coming from Page 1
        if(pageHeaderReferer != null && pageHeaderReferer.containsIgnoreCase('commision') && message != 'null')
        {
               ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, message)); 
        }
        flag=false;
        prod = new list<product__c>();
        lstoptionlocation=new list<selectoption>();
        list<Location__c> locations=[select id,name from Location__c];
        lstoptionlocation.add(new selectoption('','--None--'));
        for(Location__c l:locations)
        {
            lstoptionlocation.add(new selectoption(l.id,l.name));
        } 
    }
    
    public pagereference validateCommision()
    {   
        if(barcode==null || barcode=='')
        {
           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Scan Box is required')); 
           return null;
        }
        else
        {
            upn= barcode.substring(10, 15);
            expiry=barcode.substring(18,24);
            lotno=barcode.substring(26);
            string header='00110000';
            string filter='001';
            string partition='100';
            string productbar;
            string productbarcode='';
            string binarystr;
            
            try
            {
                Product__c lstproduct =[select id,name,Product_Increment__c from Product__c where GTIN__c=:barcode.substring(2, 16)];
                if(lstproduct.id != null)
                {
                    lstproduct.Product_Increment__c +=1;
                }
                update lstproduct;
                productbar=commision.hextobinary(string.valueof(lstproduct.Product_Increment__c));
                if(productbar.length() != null)
                {
                    for(integer i=productbar.length();i<34;i++)
                    {
                        productbarcode+=0;
                    }
                    productbarcode+=productbar;
                }
                binarystr=header+filter+partition+commision.hextobinary(barcode.substring(3, 10))+commision.hextobinary(barcode.substring(10, 15))+productbarcode;/*+commision.hextobinary(string.valueof(lstproduct.Product_Increment__c));*/
                hexepc=commision.binarytohex(binarystr);
            }
            catch(Exception e)
            {
            }
            
            flag=true;
        }
        return null;
    }
    public static string hextobinary(String hex) 
    {
        Map<string, string>  binary= new map<string, string>{'0'=>'0000','1'=>'0001','2'=>'0010','3'=>'0011','4'=>'0100','5'=>'0101','6'=>'0110','7'=>'0111','8'=>'1000',
                                                             '9'=>'1001','A'=>'1010','B'=>'1011','C'=>'1100','D'=>'1101','E'=>'1110','F'=>'1111','a'=>'1010','b'=>'1011',
                                                             'c'=>'1100','d'=>'1101','e'=>'1110','f'=>'1111'};
        
        string retVal='';
        for(Integer i=0;i<hex.length();i++) 
        {
            retval+= binary.get(hex.substring(i,i+1));
        }
        return retVal;
    }
    
    public static string binarytohex(string h)
    {
        Map<string, string>  binary= new map<string, string>{'0000'=>'0','0001'=>'1','0010'=>'2','0011'=>'3','0100'=>'4','0101'=>'5','0110'=>'6','0111'=>'7','1000'=>'8',
                                                             '1001'=>'9','1010'=>'A','1011'=>'B','1100'=>'C','1101'=>'D','1110'=>'E','1111'=>'F'};
        
        string binaryval='';
        Integer i;
        for(i=0; i<h.length();i+4)
        {
            binaryval+= binary.get(h.substring(i,i+4));
            i+=4;       
        }    
        
        return binaryval;                                                  
    }
    
    public pagereference calCommision()
    {
        pagereference saveref;
     //   try
        {
            inventory__c inven = new inventory__c();
            inven.UPN__c=upn;
            inven.LOT__c=lotno;
            system.debug('-----------locationname----------'+locationname);
            if(locationname!='--None--' || locationname!='')
            {
                inven.LocationID__c=locationname;
            }
            
            date expdate=date.valueof(date.parse(expiry.substring(2,4)+'/'+expiry.substring(4,6)+'/'+20+expiry.substring(0,2)));
            inven.Expiry__c=expdate;
            inven.EPC__c=hexepc;
            insert inven;
            obj=JSON.serializePretty(inven.EPC__c);
          }
      //    catch (exception e)
          {
          }  
          //  saveref=new pagereference('/'+inven.id);
         //   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Successfully inventory created..')); 
         
         
            saveref=new pagereference('/apex/commision');
            saveref.getParameters().put('message', 'Successfully inventory created..');
            saveref.setRedirect(true);
       return saveref;
      //  return null;
    }
}