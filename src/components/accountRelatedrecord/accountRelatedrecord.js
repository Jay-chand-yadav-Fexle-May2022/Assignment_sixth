import { LightningElement, track,  wire } from 'lwc';
import getContact from '@salesforce/apex/AccountRelated.contactRecord';
import getOpp from '@salesforce/apex/AccountRelated.opportunityRecord';
import getCase from '@salesforce/apex/AccountRelated.caseRecord';
export default class AccountRelatedrecord extends LightningElement {

     @track contactList;
     @track opportunityList;
     @track caseList;
     opp = false;
     case = false;

     @wire(getContact) wiredContact({data,error}){
          if (data) {
               this.contactList = data;
               this.opp = true;
          console.log(data); 
          } else if (error) {
            console.log(error);
          }
     }    
     @wire(getOpp) wiredOpportunity({data,error}){
          if(this.opp){
               if (data) {
                    this.opportunityList = data;
                    this.case = true;
                    console.log(data); 
               } else if (error) {
                    console.log(error);
               }
          }         
     }
     @wire(getCase) wiredCase({data,error}){
          if(this.case){
               if (data) {
                    this.caseList = data;
                    console.log(data); 
               } else if (error) {
                    console.log(error);
               }
          }         
     }
}