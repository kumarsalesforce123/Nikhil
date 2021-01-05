@isTest
public class TotalHistotyReportControllerTest
{
    public static testmethod void report()
    {
        Location__c location=new Location__c(name='chicago',location_ID__c=10);
        insert location;
        Product__c product=new Product__c(GTIN__c='Test gtin',Product_Description__c='Test description');
        insert product;
        
        Inventory__c inventory =new Inventory__c(LocationID__c=location.id,Product_number__c=product.id,LOT__c='Mac123');
        insert inventory;
        
        scan__c scan=new scan__c(EPC__c=inventory.id,LocationID__c=location.id,Scan_time__c=system.now());
        insert scan;
        
        
        apexpages.currentpage().getparameters().put('sd','12/29/2016');
        apexpages.currentpage().getparameters().put('ed','12/31/2016');
     //   apexpages.currentpage().getparameters().put('lo','location.id');
        TotalHistotyReportController totalreport=new TotalHistotyReportController();
        totalreport.fetchDetails();
        
    }
}