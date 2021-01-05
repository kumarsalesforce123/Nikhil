({
	 loadBoatTypes: function (component) {
         console.log('loading boatypes in helper');
         var action=component.get("c.getBoatTypes");
         action.setCallback(this,function(response){
             var state=response.getState();
             if(state=== "SUCCESS")
             {
                 component.set("v.BoatTypes",response.getReturnValue());
                 console.log(response.getReturnValue());
             }
             else
             {
                 console.log('failed with state'+state);
             }
         });
    	$A.enqueueAction(action);
     }
})