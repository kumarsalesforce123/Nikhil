({
   onBoatClick : function(component, event, helper) {
       var boat = component.get('v.boat');
        //this is how you fire an application event
        var createEvent = $A.get("e.c:PlotMapMarker");
        createEvent.setParams({'sObjectId' : boat.id});
        createEvent.fire();
  }

})