({

    // load camping list items on initiation
    doInit: function(component,event,helper) {

        var action = component.get("c.getItems");
        action.setCallback(this,function(response) {
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS") {
                component.set("v.items",response.getReturnValue());
                console.log("doInit: "+response.getReturnValue());
            }
        });

        $A.enqueueAction(action);
    },
	
    // handle adding items to camping list
    handleAddItem: function(component, event, helper) {     
        var item = event.getParam("item");

        var action = component.get("c.saveItem");
        action.setParams({
            "item": item
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {       
               var items = component.get("v.items");
               items.push(response.getReturnValue());
               component.set("v.items",items);
            }
        });
        $A.enqueueAction(action);
    }

})