import { LightningElement ,api, wire, track} from 'lwc';
import getAccountList from '@salesforce/apex/AccountHelper.getAccountList';
import wrpapper from '@salesforce/apex/Wrpapper.wrpapper';
// Multiple branches testing
const actions = [
    { label: 'View RMA', name: 'rma_details'}, 
    { label: 'View Case', name: 'case_details'}
];

export default class LightningDatatableLWCExample extends LightningElement {
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
    @track accData ;
    @track allAccounts = [];
    @track ProspectList = [];
    @track CustomerList = [];
    allAccountsCount = 0;
    allProspectCount = 0;
    allCustomerCount = 0;
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
            console.log('Nikhil kumar' + data);                               
            this.accData = data;
            this.allAccounts = data;
            this.ProspectList = this.accData.filter(this.ProspectFilter);
            this.CustomerList = this.accData.filter(this.CustomerFilter);
            this.activeFilter ='';
            this.allAccountsCount = 'All - ' + this.allAccounts.length;
            this.allProspectCount = 'Prospect - ' + this.ProspectList.length;
            this.allCustomerCount = 'Customers - ' + this.CustomerList.length;
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
    }
    allProspectsData(){
        this.activeFilter ='Prospect';
        this.accData = this.ProspectList;
    }
    allCustomersData(){
        this.activeFilter ='Customer - Direct';
        this.accData = this.CustomerList;
    }
    handleSearchInputChange(evnt)
    {     
        this.searchString = evnt.target.value;
        console.log(this.searchString);
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
        if((item.Name.toLowerCase().includes(searchString)) || (item.Type && item.Type.toLowerCase().includes(searchString)) 
            || (item.Phone && item.Phone.toLowerCase().includes(searchString)) || (item.Website && item.Website.toLowerCase().includes(searchString)) 
            || (item.Rating && item.Rating.toLowerCase().includes(searchString)) || (item.AnnualRevenue && item.AnnualRevenue.toString().includes(searchString)))
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

    @track AccId;
    @track rmaDetails = [];
    @track replacementDetails = [];
    @track returnDetails = [];
    @track settlementDetails = [];

    @wire(wrpapper, { Id : '$AccId' })
    wrappedAccount({error,data}) 
    {
        if (data){   
            this.rmaDetails = data.filter(this.tabSection);
            this.replacementDetails = data.filter(this.tabSection);
            this.returnDetails = data.filter(this.tabSection);
            this.settlementDetails = data.filter(this.tabSection);
        }
    }

    tabSection(item)
    {
        if (item.fieldSetName === 'Field_set_1') {
            return true; 
        }
        else if(item.fieldSetName === 'Field_set_2'){
            return true;
        }
        else if(item.fieldSetName === 'f'){
            return true;
        }
        else if(item.fieldSetName === 'ff'){
            return true;
        }                    
        return false;
    }
    
    viewrmadetails(row) {
        this.ShowRMAModal = true;       
        this.AccId = row.Id;
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
    saveMethod(event) {
            this.template.querySelector('.slds-show').classList.add('slds-hide');
            this.template.querySelector('.slds-show').classList.remove('slds-show');
            this.template.querySelector('.slds-is-active').classList.remove('slds-is-active');    
            var y=event.target.parentElement;
            y.classList.add('slds-is-active');            
            var x=event.target.id;
            let target = this.template.querySelector(`[aria-labelledby="${x}"]`);   
            target.classList.remove('slds-hide');
            target.classList.add('slds-show');
    }

}