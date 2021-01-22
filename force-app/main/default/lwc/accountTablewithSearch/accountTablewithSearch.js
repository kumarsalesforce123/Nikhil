import { LightningElement ,api, wire, track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord } from 'lightning/uiRecordApi';
import getAccountList from '@salesforce/apex/AccountHelper.getAccountList';

const actions = [
    { label: 'View RMA', name: 'rma_details'}, 
    { label: 'View Case', name: 'case_details'}
];

const FIELDS = ['Account.Name'];
export default class AccountTablewithSearch extends LightningElement {    
    
columns = [{
            label: 'Account Name',
            fieldName: 'Name',
            type: 'text',
            hideDefaultActions: "true"
        },
        {
            label: 'Type',
            fieldName: 'Type',
            type: 'text',
            hideDefaultActions: "true"
        },
        {
            label: 'Annual Revenue',
            fieldName: 'AnnualRevenue',
            type: 'text',
            hideDefaultActions: "true"
        },
        {
            label: 'Phone',
            fieldName: 'Phone',
            type: 'text',
            hideDefaultActions: "true"
        },
        {
            label: 'Website',
            fieldName: 'Website',
            type: 'text',
            hideDefaultActions: "true"
        },
        {
            label: 'Rating',
            fieldName: 'Rating',
            type: 'test',
        },
        {
            type: 'action',
            typeAttributes: {
                rowActions: actions,
                menuAlignment: 'right'
            }
        },
    ];
    @api recordId;
    recordName;
    @track accData = [];
    @track allAccounts = [];
    /*@track ProspectList = [];
    @track CustomerList = [];*/
    /*allAccountsCount = 0;
    allProspectCount = 0;
    allCustomerCount = 0;*/
    allProspectCount = 0;
    allCustomerCount = 0;
    activeFilter ='';
    searchString = '';
    @track ShowRMAModal = false;
    @track ShowcaseModal = false;
    @track AccountSelected;
    @track isLoaded = false;

    get allFilterButtonClass() {
        return !this.activeFilter ? 'slds-button slds-button_neutral filter-button filter-button-active' : 'slds-button slds-button_neutral filter-button';        
    }
    get prospectFilterButtonClass() {
        return (this.activeFilter && this.activeFilter === 'Prospect') ? 'slds-button slds-button_neutral filter-button filter-button-active' : 'slds-button slds-button_neutral filter-button';        
    }
    get customerFilterButtonClass() {
        return (this.activeFilter && this.activeFilter === 'Customer - Direct') ? 'slds-button slds-button_neutral filter-button filter-button-active' : 'slds-button slds-button_neutral filter-button';        
    }
    get fileName()
    {
        return (this.recordName) ? this.recordName+' RMA List':'Account RMA List';
    }   

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    wiredRecord({ error, data }) {
        if (error) {
            let message = 'Unknown error';
            if (Array.isArray(error.body)) {
                message = error.body.map(e => e.message).join(', ');
            } else if (typeof error.body.message === 'string') {
                message = error.body.message;
            }
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error loading Account',
                    message,
                    variant: 'error',
                }),
            );
        } else if (data) {        
            this.recordName = data.fields.Name.value;        
        }
    }

    @wire(getAccountList)
    wiredAccounts({error,data}) 
    {
        if (data){    
            this.activeFilter ='';                             
            this.accData = data;
            this.allAccounts = data;
            this.allProspectCount =  this.accData.filter(this.typeFilter,'Prospect').length;
            this.allCustomerCount =  this.accData.filter(this.typeFilter,'Customer - Direct').length;
            /*this.ProspectList = this.accData.filter(this.ProspectFilter);
            this.CustomerList = this.accData.filter(this.CustomerFilter);*/            
            /*this.allAccountsCount = 'All - ' + this.allAccounts.length;
            this.allProspectCount = 'Prospect - ' + this.ProspectList.length;
            this.allCustomerCount = 'Customers - ' + this.CustomerList.length;*/
        } else if (error) {
            console.error(error);
        }
    }
    /*ProspectFilter(item)
    {
        if (item.Type === 'Prospect') 
            return true;          
        return false;
    }
    CustomerFilter(item)
    {
        if (item.Type === 'Customer - Direct') 
            return true;          
        return false;
    }*/
   /* allAccountsData(a){
        this.activeFilter ='';
        this.accData = this.allAccounts;
        this.searchString = '';        
    }
    allProspectsData(a){
        this.activeFilter ='Prospect';
        this.accData = this.ProspectList;
        this.searchString = '';
    }
    allCustomersData(){
        this.activeFilter ='Customer - Direct';
        this.accData = this.CustomerList;
        this.searchString = '';
    }*/
    filterByType(evnt)
    {
        if(evnt.currentTarget && evnt.currentTarget.dataset && evnt.currentTarget.dataset.type)
        {
            let FilterType = evnt.currentTarget.dataset.type;
            this.activeFilter = FilterType;
            this.accData = this.allAccounts.filter(this.typeFilter,FilterType);                    
        }
        else
        {
            this.activeFilter = '';
            this.accData = this.allAccounts;     
        }
        this.searchString = ''; 
    }
    typeFilter(item)
    {
        return  (item.Type === this)? true:false;
        /*if (item.Type === this) 
            return true;          
        return false;*/
    }
    handleSearchInputChange(evnt)
    {
        this.searchString = evnt.target.value;
        /*let data = [];
        if(this.activeFilter && (this.activeFilter ==='Prospect' || this.activeFilter === 'Customer - Direct'))
        {
            if(this.activeFilter ==='Prospect')
                data = this.ProspectList;
            else if(this.activeFilter === 'Customer - Direct')
                data= this.CustomerList;
        }
        else
        {
            data = this.allAccounts;
        }*/
        let data = this.allAccounts;
        if(this.activeFilter)
            data = this.allAccounts.filter(this.typeFilter,this.activeFilter);   

        if(this.searchString)
        {
            this.accData = data.filter(this.accountSearchFilter,this.searchString);
        }
        else
            this.accData = data;
    }
    accountSearchFilter(item){
        let searchString = this.toLowerCase();
        if((item.Name && item.Name.toLowerCase().includes(searchString)) || (item.AnnualRevenue && item.AnnualRevenue.toString().includes(searchString)) || (item.Type && item.Type.toLowerCase().includes(searchString)) 
            || (item.Phone && item.Phone.toLowerCase().includes(searchString)) || (item.Website && item.Website.toLowerCase().includes(searchString)) 
            || (item.Rating && item.Rating.toLowerCase().includes(searchString)))
            return true;
        return false;
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'rma_details':
                this.viewrmadetails(row);
                break;
            case 'case_details':
                this.viewcasedetails(row);
                break;
            default:
        }
    }

    viewrmadetails(row) {
        this.ShowRMAModal = true;
     //   this.accountname = row.Name;
        this.AccountSelected = row;

    }

    viewcasedetails(row) {
        this.AccountSelected = row;
        this.ShowcaseModal = true;
    }
    closeModal() {
        this.ShowRMAModal = false;
        this.ShowcaseModal = false;
    }
}