import { LightningElement, track} from 'lwc';
import getContact from '@salesforce/apex/AccountRelated.contactRecord';
import getOpp from '@salesforce/apex/AccountRelated.opportunityRecord';
import getCase from '@salesforce/apex/AccountRelated.caseRecord';
const conColumns = [
          { label: 'LastName', fieldName: 'LastName' },
          { label: 'Phone', fieldName: 'Phone', type: 'Phone' },
          { label: 'Email', fieldName: 'Email', type: 'Email' }
     ];
const oppColumns = [
          { label: 'Id', fieldName: 'Id' },
          { label: 'Name', fieldName: 'Name'},
          { label: 'StageName', fieldName: 'StageName' }
     ];
const caseColumns = [
          { label: 'Id', fieldName: 'Id' },
          { label: 'Status', fieldName: 'Status' },
          { label: 'Priority', fieldName: 'Priority'}
     ];

export default class AccountRelatedrecord extends LightningElement {

     conColumns = conColumns;
     oppColumns = oppColumns;
     caseColumns = caseColumns;

     @track contactList;
     @track opportunityList;
     @track caseList;
     showResult = false;

     connectedCallback() {
         this.showRecord()        
     }
     showRecord(){
           getContact()
          .then(result => {
               this.contactList = result;
          })

          getOpp()
          .then(result1 => {
               this.opportunityList = result1;
          })

          getCase()
          .then(result2 => {
               this.caseList = result2;
          })
     }
}
