({
    clickCreateItem : function(component, event, helper) {
        var validCampign = true;

        // Name cannot be blank
        var nameField   = component.find("name");
        var campaignname = nameField.get("v.value");
        if($A.util.isEmpty(campaignname)) {
            validCampign = false;
            nameField.set("v.errors",[{message: "Camping name can't be blank."}]);     
        }
        else {
            nameField.set("v.errors",null);
        }

        // Quantity cannot be blank.
        var qty = component.find("quantity");
        var quantity = qty.get("v.value");
        if($A.util.isEmpty(quantity)) {
            validCampign = false;
            qty.set("v.errors",[{message: "Quantity can't be blank."}]);
        }
        else {
            qty.set("v.errors",null);            
        }
		
        // Price cannot be blank.
        var priceField = component.find("price");
        var price      = priceField.get("v.value");
        if($A.util.isEmpty(price)) {
            validCampign = false;
            priceField.set("v.errors",[{message: "Price can't be blank."}]);
        }
        else {
            priceField.set("v.errors",null);            
        }
		
        // No validation errors
        if(validCampign) {
            var newCampaign = component.get("v.newItem");
            helper.createItem(component, newCampaign);
        }               
        
    }

})