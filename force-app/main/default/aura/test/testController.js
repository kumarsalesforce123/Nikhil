({
    doInit : function(cmp, event, helper) {
        
        
    },
    handleClick : function(cmp, event, helper) {
        var TaskSubject = cmp.find("subject");
        var Subject = TaskSubject.get("v.value");
        if (Subject === null) {
            TaskSubject.setCustomValidity("Please enter subject");            
        }
        TaskSubject.reportValidity();     
        var TaskDate = cmp.find("tdate");
        var TDate = TaskDate.get("v.value");        
        if (TDate === null) {
            TaskDate.setCustomValidity("Please select a Date");            
        }
        TaskDate.reportValidity();       
        var TaskComments = cmp.find("comments");
        var Comments = TaskComments.get("v.value");
        if (Comments === null) {
            TaskComments.setCustomValidity("Please enter Comments");            
        } 
        TaskComments.reportValidity();
    }
})