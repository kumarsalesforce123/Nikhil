({ search: function(component, event, helper)




  {




      var params = event.getParam('arguments');




   component.set("v.boatTypeId", params.boatTypeId);




      component.get("c,doSearch"); },




 doSearch : function (component, event, helper)




  { component.get("v.boatTypeId"); helper.onSearch(component); },










 onBoatSelect : function(component, event, helper) {




        var boatId = event.getParam("boatId");




        console.log(boatId);




        component.set("v.selectedBoatId",boatId);




    }




 })