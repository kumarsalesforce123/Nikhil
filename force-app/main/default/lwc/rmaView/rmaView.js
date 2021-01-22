import { LightningElement ,api, wire, track} from 'lwc';
//import getAccountFieldSets from '@salesforce/apex/AccountHelper.getAccountFieldSets';
import getAccountWithId from '@salesforce/apex/AccountHelper.getAccountWithId';
export default class RmaView extends LightningElement {
    renderedCallback() {
        if (this.hasRendered) return;
        this.hasRendered = true;
    
        const style = document.createElement('style');
        style.innerText = `         
        .slds-vertical-tabs__nav-item a, .slds-vertical-tabs__nav-item.slds-has-focus {
            text-decoration: none !important;
            color: #000 !important;        
        }
        .slds-vertical-tabs__nav-item.slds-is-active {            
            color: #000 !important;
            font-weight: bolder;
        }
        lightning-tab-bar ul {
            min-height: 70vh !important;
        }         
        `;
        this.template.querySelector('.c-continer').appendChild(style);
    }
    AccountId = "";
    Account =[];
    //fieldsetLabels = {"Field_set_1":"RMA Details", "Field_set_2":"Replacement Details", "Field_set_3":"Return Details", "Field_set_4":"Settlement Details"};
    fieldsetsdata = {"Field_set_1":[], "Field_set_2":[], "Field_set_3":[], "Field_set_4":[]};
    @api 
    get recordId(){
        return this.AccountId;
    };
    set recordId(value){
        this.AccountId = value;
    };
    @wire(getAccountWithId , { Id: '$recordId' })
    wiredgetAccounts({error,data}) 
    {
        if (data){                                 
            console.log(data);
            let fieldsetdata = {};
            let fieldsets = data.Config.AccountFieldSets;
            let AccountFieldApiInfo = data.Config.AccountFieldApiInfo;
            let rec = data.Record;        
            Object.keys(fieldsets).forEach(x=>{fieldsetdata[x]= []; fieldsets[x].forEach( y => fieldsetdata[x].push({'Field':AccountFieldApiInfo[y].label,'Value':rec[y]}))});
            this.fieldsetsdata = fieldsetdata;
            console.log(this.fieldsetsdata);
        } 
        else if (error) {
            console.error(error);
        }
    }
    /*saveMethod(event) {
        this.template.querySelector('.slds-show').classList.add('slds-hide');
        this.template.querySelector('.slds-show').classList.remove('slds-show');
        this.template.querySelector('.slds-is-active').classList.remove('slds-is-active');    
        var y=event.target.parentElement;
        y.classList.add('slds-is-active');            
        var x=event.target.id;
        let target = this.template.querySelector(`[aria-labelledby="${x}"]`);   
        target.classList.remove('slds-hide');
        target.classList.add('slds-show');
}*/

}