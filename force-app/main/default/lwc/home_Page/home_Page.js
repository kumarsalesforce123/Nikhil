import { LightningElement, track, api, wire} from 'lwc';
import method1 from '@salesforce/apex/HomePageController.method1';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Home_Page extends LightningElement {
    areDetailsVisible = true;
    @track FirstName = '';
    @track LastName = '';


    @wire(method1, {RecordIDofAccount: "1234ffffs", TestingtheClass : "Nikhil"}) 
    Accounts ;
    handleChange(event){
        const field = event.target.name;
        if (field === 'Fname') {
            this.FirstName = event.target.value;
        } else if (field === 'LName') {
            this.LastName = event.target.value;
        }
    }
    handleClick(){
        alert('Nikhil is Testing This Component in VS Code   ');
        const event = new ShowToastEvent({
            "title": "Success!",
            "variant" : "Success",
            message: 'Salesforce documentation is available in the app. Click ? in the upper-right corner.',
        });
        this.dispatchEvent(event);
    }
}