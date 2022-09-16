import { LightningElement, wire, api } from 'lwc';
import getContact from '@salesforce/apex/ContactRecord.userContactRecord';

export default class ContactLwc extends LightningElement {

    @api flexipageRegionWidth;
    @wire(getContact) contactList;
}