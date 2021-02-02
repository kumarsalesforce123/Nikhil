import { LightningElement ,api, wire, track} from 'lwc';
import getAccountList from '@salesforce/apex/AccountHelper.getAccountList';
import wrpapper from '@salesforce/apex/Wrpapper.wrpapper';

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

    @api accountData = [];
    allAccountData = [];
    prospectCount = 0;
    cdCount = 0;
    ccCount = 0;
    cprCount = 0;
    otherCount = 0;
    @api isLoaded = false;
    @api ShowRMAModal = false;
    @api ShowCaseModal = false;
    activeFilter = '';
    searchString = '';v
    messageToDispaly = '';

    @wire(getAccountList)
    getAccountData({error,data})
    {
        if (data){
            this.activeFilter ='';
            this.accountData = data;
            this.allAccountData = this.accountData;
            this.prospectCount = this.allAccountData.filter(this.typeFilter,'Prospect').length;
            this.cdCount = this.allAccountData.filter(this.typeFilter,'Customer - Direct').length;
            this.ccCount = this.allAccountData.filter(this.typeFilter,'Customer - Channel').length;
            this.cprCount = this.allAccountData.filter(this.typeFilter,'Channel Partner / Reseller').length;
            this.otherOrderCount = this.allAccountData.filter(this.typeFilter,'Other').length;
            this.isLoaded = !this.isLoaded;
            if(data.length === 0){
                this.messageToDispaly = 'No Return Material Authorization to display' ;
            }
        } else if (error) {
            console.error(error);
        }
    }
    // Filter the data with RMA Milestone
    typeFilter(item){
        return  (item.Type === this)? true:false;
    }
    // Method to handle the button click
    filterByType(evnt){
        if(evnt.currentTarget && evnt.currentTarget.dataset && evnt.currentTarget.dataset.type){
            var FilterType = evnt.currentTarget.dataset.type;
            this.activeFilter = FilterType;
            this.accountData = this.allAccountData.filter(this.typeFilter,FilterType);
        }
        else{
            this.activeFilter = '';
            this.accountData = this.allAccountData;
        }
        this.searchString = '';
        if(this.accountData.length === 0){
            this.messageToDispaly = 'No Accounts to display' ;
        }
    }
    // Method to handle the search
    handleSearchInputChange(evnt){
        this.searchString = evnt.target.value;
        let data = this.allAccountData;
        if(this.activeFilter)
            data = this.allAccountData.filter(this.typeFilter,this.activeFilter);

        if(this.searchString.length >= 3){
            this.accountData = data.filter(this.rmaSearchFilter,this.searchString);
        }
        else{
            this.accountData = data;
        }
        if(this.accountData.length === 0){
            this.messageToDispaly = 'No results found, please refine your search.' ;
        }
    }
    rmaSearchFilter(item){
        let searchString = this.toLowerCase();
        if((item.Name && item.Name.toLowerCase().includes(searchString)) || (item.AnnualRevenue && item.AnnualRevenue.toString().includes(searchString)) || (item.Type && item.Type.toLowerCase().includes(searchString)) 
            || (item.Phone && item.Phone.toLowerCase().includes(searchString)) || (item.Website && item.Website.toLowerCase().includes(searchString)) 
            || (item.Rating && item.Rating.toLowerCase().includes(searchString)))
            return true;
        return false;
    }
    // Method to handle the sort of RMA status
    handleSortdata(event) {
        this.sortBy = event.detail.fieldName;
        this.sortDirection = event.detail.sortDirection;
        this.sortData(event.detail.fieldName, event.detail.sortDirection);
    }
    sortData(fieldname, direction) {
        let parseData = JSON.parse(JSON.stringify(this.accountData));
        let keyValue = (a) => {
            return a[fieldname];
        };
        let isReverse = direction === 'asc' ? 1: -1;
        parseData.sort((x, y) => {
            x = keyValue(x) ? keyValue(x) : '';
            y = keyValue(y) ? keyValue(y) : '';
            return isReverse * ((x > y) - (y > x));
        });
        this.accountData = parseData;
    }
    // Methos to handle the actions of data table
    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'rma_details':
                this.viewRMADetails(row);
                break;
            case 'case_details':
                this.viewCaseDetails(row);
                break;
            default:
        }
    }
    viewRMADetails(row){
        this.ShowRMAModal = true;
        
    }
    viewCaseDetails(row){
        
        this.ShowCaseModal = true;
        
    }
    closeModal() {
        this.ShowRMAModal = false;
        this.ShowCaseModal = false;
    }
    // Method to handle the Export all
    exportData(){
      //  this.template.querySelector("c-export-excel").downloadCSVFile(this.allAccountData, 'RMAs', this.fieldMap);
    }
    get allFilterButtonClass(){
        return !this.activeFilter ? 'slds-button slds-button_neutral filter-button filter-button-active' : 'slds-button slds-button_neutral filter-button';
    }
     get bookedFilterButtonClass(){
        return(this.activeFilter && this.activeFilter === 'Prospect') ? 'slds-button slds-button_neutral filter-button filter-button-active' : 'slds-button slds-button_neutral filter-button';
    }
    get toShipFilterButtonClass(){
        return (this.activeFilter && this.activeFilter === 'Customer - Direct') ? 'slds-button slds-button_neutral filter-button filter-button-active' : 'slds-button slds-button_neutral filter-button';
    }
    get deliverFilterButtonClass(){
        return (this.activeFilter && this.activeFilter === 'Customer - Channel') ? 'slds-button slds-button_neutral filter-button filter-button-active' : 'slds-button slds-button_neutral filter-button';
    }
    get toReturnFilterButtonClass(){
        return (this.activeFilter && this.activeFilter === 'Channel Partner / Reseller') ? 'slds-button slds-button_neutral filter-button filter-button-active' : 'slds-button slds-button_neutral filter-button';
    }
    get otherFilterButtonClass(){
        return (this.activeFilter && this.activeFilter === 'Other') ? 'slds-button slds-button_neutral filter-button filter-button-active' : 'slds-button slds-button_neutral filter-button';
    }
}