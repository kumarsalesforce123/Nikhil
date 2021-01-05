({
    onInit : function(component, event, helper) {
        // Prepare a new record from template
        component.find("service").getNewRecord(
            "BoatReview__c",
            null,
            false,
            $A.getCallback(function() {
                var rec = component.get("v.boatReview");
                var error = component.get("v.recordError");
                console.log('hey', JSON.stringify(rec));
                
                if (error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                } else {
                    rec.Boat__c = component.get("v.boat").Id;
                    component.set("v.boatReview.Boat__c",component.get("v.boat").Id);
                    console.log("Record template initialized: " + rec.sobjectType);
                }
            })
        );
    }
})