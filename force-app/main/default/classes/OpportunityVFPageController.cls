public class OpportunityVFPageController {
    public Opportunity opp;
    public Boolean CustomRender  ;
    public boolean oppLineItem;
    public OpportunityVFPageController(ApexPages.StandardController stdController) {
        this.CustomRender = true ;
        this.opp = (Opportunity)stdController.getRecord();

    }

}