import { LightningElement, wire } from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList';

export default class ContactListLWC extends LightningElement {
    contacts;
    error;    
    @wire(getContactList)
    allOrders({error,data})
    {
        if (data){
                        //this.contacts = data;
            let contacts = [];
            data.forEach(row=>{
                let row1 = JSON.parse(JSON.stringify(row)); 
                
                row1["AccountType"] = (row.Account && row.Account.Type)?row.Account.Type:'';
              //  row1["OrderNumber"]=(row.Account && row.Account.Type) ?'/'+x.Id : '';
                contacts.push(row1);
             //   console.log(row1.AccountType);                            
            });
            this.contacts = contacts;
            console.log(this.contacts);
					/*	this.contactData = data.map(row=>{
								console.log('test');
             if(row.Account){
								 console.log(row.Account.Type);
								 row.AccountName = row.Account.Type;
						 } 
         }) */
            
        } else if (error) {
            this.error = error;
        }
    }
}