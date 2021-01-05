import { LightningElement } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import WEBSITE_FIELD from '@salesforce/schema/Account.Website';

export default class Account_LDS extends LightningElement {

    accountObject = ACCOUNT_OBJECT;
    myFields = [NAME_FIELD, WEBSITE_FIELD];
    handleAccountCreated(){
        const event = new ShowToastEvent({
            "title": "Success!",
            "variant" : "Success",
            message: 'Record created sucessfully',
        });
        this.dispatchEvent(event);

    }
}