({
    jsLoaded: function(component) {
        component.set("v.jsLoaded", true);
    } , 
    onPlotMapMarker : function(component,event,helper) {
        var id=event.getParam('sobjectId');
        var latitude=event.getParam('lat');
        var longtitude=event.getParam('long');
        var label=event.getParam('label');
        component.set('v.location',{
            'lat' :latitude,
            'long' : longtitude;
        })
    }
})