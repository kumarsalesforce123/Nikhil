({

    onSearch : function(component) {

        var action = component.get("c.getBoats");

        action.setParam({"boatTypeId":""});

        action.setCallback(this, function(response){

        var status = response.getState();

            if(status === "SUCCESS"){

             if(! $A.util.isEmpty(response.getReturnValue())){

                    component.set("v.boatTypeId",response.getReturnValue()); 

                } else {

                     component.set("v.recordError","No boats found");

                }

            }

        });

        $A.enqueueAction(action);

    }

})