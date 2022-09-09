import { LightningElement, api } from 'lwc';

export default class ChildWebComponent extends LightningElement {
    message
    @api
    showMessage(){
        this.message = 'Hello World';
    }
}