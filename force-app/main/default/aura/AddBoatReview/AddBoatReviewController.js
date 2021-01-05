({







    doInit :
function(component, event, helper) {







       
helper.onInit(component,event);







    },







    onSave :
function(component, event, helper) {







       
component.set("v.boatReview.Boat__c",component.get("v.boat.Id"));







        component.find("service").saveRecord(function(saveResult){







           
if(saveResult.state==="SUCCESS" || saveResult.state ===
"DRAFT")







            {







                







               var
resultsToast = $A.get("e.force:showToast");







               
if(resultsToast)







                {







                   
resultsToast.setParams({







                       
"title": "Saved",







                       
"message": "Boat Review Created"







                   
});







                   
resultsToast.fire(); 







                }







               
else







                {







                   
alert('Boat Review Created');







                }







            }







            else if
(saveResult.state === "ERROR") {







                var
errMsg='';







               
console.log('Problem saving record, error: ' +
JSON.stringify(saveResult.error));







                for
(var i = 0; i < saveResult.error.length; i++) {







                   
errMsg += saveResult.error[i].message + "\n";







                }







               
component.set("v.recordError", errMsg);







            }







            else







            {







               
console.log('Unknown problem, state: ' + saveResult.state + ', error: '
+ JSON.stringify(saveResult.error));







            }







            var
boatReviewAddedEvnt=component.getEvent("boatReviewAdded");







               
boatReviewAddedEvnt.fire();







                
helper.onInit(component,event,helper);







           







        });







       







    },







    onRecordUpdated
: function(component, event, helper) {







        var
eventParams = event.getParams();







       
if(eventParams.changeType === "CHANGED") {







            var
changedFields = eventParams.changedFields;







            var
saveResultsToast = $A.get("e.force:showToast");







               
if(saveResultsToast!='undefined')







                {







                    saveResultsToast.setParams({







                       
"title": "Saved",







                       
"message": "Boat Review Saved"







                   
});







                   
saveResultsToast.fire(); 







                }







               
else







                {







                   
alert('Boat Review Saved');







                }







        }







    }







})







AddBoatReviewHealper.js







({







    onInit :
function(component,event) {







       
component.find("service").getNewRecord(







           
"BoatReview__c", // sObject type (entityAPIName)







           
null,      // recordTypeId







           
false,     // skip cache?







           
$A.getCallback(function() {







                var
rec = component.get("v.boatReview");







                var
error = component.get("v.recordError");







                var
boat=component.get("v.boat");







               
if(error || (rec === null)) {







                   
console.log("Error initializing record template: " + error);







                }







               
else {







                   
component.set("v.boatReviewRecord.Boat__c",boat.Id);







                   
component.set("v.boatReview.Boat__c",boat.Id);







                }







            })







        );







    }







})