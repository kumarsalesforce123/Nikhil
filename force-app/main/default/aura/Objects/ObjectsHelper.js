({
    lstofRecords: function(component, event, objName, FieldName) {
        var action = component.get("c.listofRecords");
        action.setParams({ 
            "objectName" : objName, 
            "fieldNames" : FieldName
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
        $A.enqueueAction(action);
    },
    deleteSelectedHelper: function(component, event, deleteRecordsIds, objectName, Fieldnames) {
        var action = component.get('c.deleteRecords');
        action.setParams({
            "lstRecordId": deleteRecordsIds,
            "SobjectName" : objectName
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log(state);
                if (response.getReturnValue() != '') {
                    
                } else {
                    
                }   
                this.lstofRecords(component, event, objectName, Fieldnames);
            }
        });
        $A.enqueueAction(action);
    },
})