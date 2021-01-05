({
    packItem : function(component, event, helper) {
        
        var a=component.get(v.item);
        a.Packed__c=True;
        component.set("v.item",a);
        
        var btn1=event.getSource();
        document.getElementById(btn1.id).disabled=true;
        
    }
})