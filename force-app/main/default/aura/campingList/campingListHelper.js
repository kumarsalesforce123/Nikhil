({
    createItem : function(component,campaign) {
        
        this.saveItem(component, campaign, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                var campaigns = component.get("v.items");
                var retcamp = response.getReturnValue();
                campaigns.push(retcamp);
                component.set("v.items",campaigns);   
            }
        });        
    },

    saveItem : function(component,campaign,callback) {
        var action = component.get("c.saveItem");
        action.setParams ({
            "campaign": campaign
        });

        if (callback) {
            action.setCallback(this, callback);
        }
        $A.enqueueAction(action);        
    }

})