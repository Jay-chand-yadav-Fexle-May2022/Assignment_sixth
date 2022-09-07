import { LightningElement, wire } from 'lwc';
import text1 from '@salesforce/apex/Textmethod.getTextMethod1';
import text2 from '@salesforce/apex/Textmethod.getTextMethod2';
import text3 from '@salesforce/apex/Textmethod.getTextMethod3';
export default class TextMethod extends LightningElement {
    @wire(text1) textOne;
    @wire(text2) textTwo;
    @wire(text3) textThree;
    showResult1 = false;
    showResult2 = false;
    showResult3 = false;

    firstTextMethod(){
        text1()
            .then(result => {
                this.textOne = result;
            })
            .catch(error => {
                this.error = error;
            });
        this.showResult1 = true;
    }

    secondTextMethod(){
        text1()
            .then(result => {
                this.textOne = result;
            })
        text2()
            .then(result => {
                this.textTwo = result;
            })
            .catch(error => {
                this.error = error;
            });
        this.showResult2 = true;
    }

    thirdTextMethod(){
        text1()
            .then(result => {
                this.textOne = result;
            })
        text2()
            .then(result => {
                this.textTwo = result;
            })
        text3()
            .then(result => {
                this.textThree = result;
            })
            .catch(error => {
                this.error = error;
            });
        this.showResult3 = true;
    }    
}