import { LightningElement, wire, api, track } from 'lwc';
import getContact from '@salesforce/apex/ContactRecord.userContactRecord';

export default class ContactLwc extends LightningElement {

    @track tempList = [];
    @api flexipageRegionWidth;
    @wire(getContact)
    wiredData({error, data}){
        console.log('1st place......');
        if(data){          
           data.forEach((item) => {
                item.Url = '/' + item.Id;
                this.tempList.push(item);
            })
        }
    }
}
