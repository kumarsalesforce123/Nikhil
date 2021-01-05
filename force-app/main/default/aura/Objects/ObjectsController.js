({
    doInit : function(component, event, helper) {
        helper.lstofRecords(component, event,component.get("v.SObjectName"),component.get("v.SObjectFields"));
      /*  var action = component.get("c.listofRecords");
        action.setParams({ 
            "objectName" : component.get("v.SObjectName"), 
            "fieldNames" : component.get("v.SObjectFields")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.Objectdata", response.getReturnValue().listDataTableData); 
                component.set("v.FieldLabel", response.getReturnValue().listDataTableLabel);
                component.set("v.FieldName", response.getReturnValue().listDataTableNames);                
            }
            else if (state === "INCOMPLETE") {
                alert('incomplete');
            }
                else if (state === "ERROR") {
                    alert('error');
                }
        });        
        $A.enqueueAction(action); */
    },
    selectAll: function(component, event, helper) {
        var selectedHeaderCheck = event.getSource().get("v.value"); 
        var getAllId = component.find("allrows"); 
        if(! Array.isArray(getAllId)){
            if(selectedHeaderCheck == true){ 
                component.find("allrows").set("v.value", true);
                component.set("v.selectedCount", 1);
            }else{
                component.find("allrows").set("v.value", false);
                component.set("v.selectedCount", 0);
            }
        }else{
            if (selectedHeaderCheck == true) {
                for (var i = 0; i < getAllId.length; i++) {
                    component.find("allrows")[i].set("v.value", true);
                    component.set("v.selectedCount", getAllId.length);
                }
            } else {
                for (var i = 0; i < getAllId.length; i++) {
                    component.find("allrows")[i].set("v.value", false);
                    component.set("v.selectedCount", 0);
                }
            } 
        }  
    },
    deleteSelected: function(component, event, helper) {  
        var deleleId = [];
        var getAllId = component.find("allrows");
        if(! Array.isArray(getAllId)){
            if (getAllId.get("v.value") == true) {
                deleleId.push(getAllId.get("v.text"));
            }
        }else{
            for (var i = 0; i < getAllId.length; i++) {
                if (getAllId[i].get("v.value") == true) {
                    deleleId.push(getAllId[i].get("v.text"));
                }
            }
        }  
        helper.deleteSelectedHelper(component, event, deleleId,component.get("v.SObjectName"),component.get("v.SObjectFields"));        
    },
    checkboxSelect: function(component, event, helper) {  
        var selectedRec = event.getSource().get("v.value"); 
        var getSelectedNumber = component.get("v.selectedCount");     
        if (selectedRec == true) {
            getSelectedNumber++;
        } 
        else {
            getSelectedNumber--;
        } 
        component.set("v.selectedCount", getSelectedNumber);
    }
})