({
	doInit : function(component, event, helper) {
        let ids = component.get("v.ids");
        let action = component.get("c.queryCases");
        action.setParams({ ids : ids });
        action.setCallback(this, function(response) {
            const state = response.getState();
            if (state === "SUCCESS") {
                let mergeData = [{ cases: response.getReturnValue()}]
                console.log( "mergeData", mergeData );
                component.set("v.mergeData", mergeData);
                let fulfillmentId = '0013h000004aqqSAAQ'; // TODO replace this with a Fulfillment record
                let templateId = "caseInstructions";
                component.set("v.recordId", fulfillmentId);
                component.set("v.templateId", templateId);
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
            else if (state === "ERROR") {
                const errors = response.getError();
                if (errors && errors[0] && errors[0].message) {
                    console.log("Error message: " + errors[0].message);
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
	},
    handleOnMerge: function(component,event,helper){
        console.log( event );
        console.log( event.detail );
        console.log( event.target );
        console.log( event.isSuccess );
        console.log( event.Id );
        console.log( JSON.stringify(event) );
    }
})