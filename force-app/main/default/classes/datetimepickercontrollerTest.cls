@isTest
public class datetimepickercontrollerTest
{
    public static testmethod void datepickerUnit()
    {
        test.startTest();
        Inven__c inv=new Inven__c(name='testinv',EPC__c='ABCDEFGH00000001',Expiry__c=system.today()+1,Lot__c='B2As',UPN__c='testupn');
        insert inv;
        Sca__c scan=new sca__c(EPC__c='ABCDEFGH00000001',Scanned__Latitude__s=40.55,Scanned__Longitude__s=108.3);
        insert scan;
        Apexpages.currentpage().getparameters().put('sd',(system.now()-1).format());
        Apexpages.currentpage().getparameters().put('ed',(system.now()+2).format());
        datetimepickercontroller dpc=new datetimepickercontroller();
        datetimepickercontroller.wrapper datewrap=new datetimepickercontroller.wrapper();
        dpc.fetchDetails();
        
        
        Inven__c inv1=new Inven__c(name='testinv',EPC__c='ABCDEFGH00000004',Expiry__c=system.today()+1,Lot__c='B2As',UPN__c='testupn');
        insert inv1;
        Sca__c scan1=new sca__c(EPC__c='ABCDEFGH00000010',Scanned__Latitude__s=40.55,Scanned__Longitude__s=108.3);
        insert scan1;
        Apexpages.currentpage().getparameters().put('sd',(system.now()-1).format());
        Apexpages.currentpage().getparameters().put('ed',(system.now()+2).format());
        datetimepickercontroller dpc1=new datetimepickercontroller();
        datetimepickercontroller.wrapper datewrap1=new datetimepickercontroller.wrapper();
        dpc1.fetchDetails();
        
        test.stopTest();
    }
}