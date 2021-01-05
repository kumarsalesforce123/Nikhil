({
    doInit : function(component, helper) {
        var obj = component.get('v.ObjectName');
        var fName = component.get('v.fieldName');
        var outputText = component.find("outputTextId");
        if (fName.indexOf(".") >= 0) {
            var ParentSobject = obj[FieldName.split(".")[0]];
            if(ParentSobject != undefined){
                outputText.set("v.value",ParentSobject[FieldName.split(".")[1]]);
            }
        }
        else{
            outputText.set("v.value",obj[fName]);
        }
    }
})