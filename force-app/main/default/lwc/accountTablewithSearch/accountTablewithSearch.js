import { LightningElement ,api, wire, track} from 'lwc';
import getAccountList from '@salesforce/apex/AccountHelper.getAccountList';

const actions = [
    { label: 'View RMA', name: 'rma_details'}, 
    { label: 'View Case', name: 'case_details'}
];

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
    @track accData = [];
    @track allAccounts = [];
    @track ProspectList = [];
    @track CustomerList = [];
    /*allAccountsCount = 0;
    allProspectCount = 0;
    allCustomerCount = 0;*/
    activeFilter ='';
    searchString = '';
    @track ShowRMAModal = false;
    @track ShowcaseModal = false;
    @track Account;
    @track isLoaded = false;

    @wire(getAccountList)
    wiredAccounts({error,data}) 
    {
        if (data){                                 
            this.accData = data;
            this.allAccounts = data;
            this.ProspectList = this.accData.filter(this.ProspectFilter);
            this.CustomerList = this.accData.filter(this.CustomerFilter);
            this.activeFilter ='';
            /*this.allAccountsCount = 'All - ' + this.allAccounts.length;
            this.allProspectCount = 'Prospect - ' + this.ProspectList.length;
            this.allCustomerCount = 'Customers - ' + this.CustomerList.length;*/
        } else if (error) {
            console.error(error);
        }
    }
    ProspectFilter(item)
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
    }
    allAccountsData(){
        this.activeFilter ='';
        this.accData = this.allAccounts;
        this.searchString = '';
    }
    allProspectsData(){
        this.activeFilter ='Prospect';
        this.accData = this.ProspectList;
        this.searchString = '';
    }
    allCustomersData(){
        this.activeFilter ='Customer - Direct';
        this.accData = this.CustomerList;
        this.searchString = '';
    }
    handleSearchInputChange(evnt)
    {
        this.searchString = evnt.target.value;
        let data = [];
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
        }
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
        this.Account = row;

    }

    viewcasedetails(row) {
        this.Account = row;
        this.ShowcaseModal = true;
    }
    closeModal() {
        this.ShowRMAModal = false;
        this.ShowcaseModal = false;
    }

    get allFilterButtonClass() {
        return !this.activeFilter ? 'slds-button slds-button_neutral filter-button filter-button-active' : 'slds-button slds-button_neutral filter-button';        
     }
     get prospectFilterButtonClass() {
        return (this.activeFilter && this.activeFilter === 'Prospect') ? 'slds-button slds-button_neutral filter-button filter-button-active' : 'slds-button slds-button_neutral filter-button';        
     }
     get customerFilterButtonClass() {
        return (this.activeFilter && this.activeFilter === 'Customer - Direct') ? 'slds-button slds-button_neutral filter-button filter-button-active' : 'slds-button slds-button_neutral filter-button';        
     }
}