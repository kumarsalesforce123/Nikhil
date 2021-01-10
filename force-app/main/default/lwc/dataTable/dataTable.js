import { LightningElement ,api, wire, track} from 'lwc';
import getAccountList from '@salesforce/apex/AccountHelper.getAccountList';
export default class LightningDatatableLWCExample extends LightningElement {
  columns = [{
            label: 'Account Name',
            fieldName: 'AccountLink',
            type: 'url',
            cellAttributes: {
                class: 'AccountLink'
            },
            typeAttributes: { tooltip: { fieldName: 'Name' }, label: { fieldName: 'Name' }}
        },
        {
            label: 'Type',
            fieldName: 'Type',
            type: 'text'
        },
        {
            label: 'Annual Revenue',
            fieldName: 'AnnualRevenue',
            type: 'Currency'
        },
        {
            label: 'Phone',
            fieldName: 'Phone',
            type: 'phone'
        },
        {
            label: 'Website',
            fieldName: 'Website',
            type: 'url'
        },
        {
            label: 'Rating',
            fieldName: 'Rating',
            type: 'text'
        }
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

    @wire(getAccountList)
    wiredAccounts({error,data}) 
    {
        if (data){                      
            this.allAccounts = data.map(x => {
                let y = JSON.parse(JSON.stringify(x));   
                y['AccountLink']='/'+x.Id;
                return y;
             });
            this.ProspectList = this.allAccounts.filter(this.ProspectFilter);
            this.CustomerList = this.allAccounts.filter(this.CustomerFilter);
            this.activeFilter ='';
            this.accData = this.allAccounts;
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
        if((item.Name && item.Name.toLowerCase().includes(searchString)) || (item.AnnualRevenue && item.AnnualRevenue.toString().includes(searchString)) ||  (item.Type && item.Type.toLowerCase().includes(searchString)) || (item.Phone && item.Phone.toLowerCase().includes(searchString)) || (item.Website && item.Website.toLowerCase().includes(searchString)) || (item.Rating && item.Rating.toLowerCase().includes(searchString)))
            return true;
        return false;
    }
}