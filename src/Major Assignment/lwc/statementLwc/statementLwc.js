import { LightningElement, api, track } from 'lwc';
import getData from '@salesforce/apex/RetrieveTransactionEntriesRecords.getEntriesRecordForStatement';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import {exportCSVFile} from './utils';
import { CloseActionScreenEvent } from 'lightning/actions';
import sendRecordOnEmail from '@salesforce/apex/StatementPdfEmail.sendEmail';
import { getRecord } from 'lightning/uiRecordApi';

export default class StatementLwc extends LightningElement {

    @api recordId;
    @api startDate_Value = '';
    @api endDate_Value = '';
    @track result1;
    @track result;
    @track date1;  
    @track date2;
    @track startDate1;
    @track endDate1;


    @track entriesRecord;

    handle_Start_Date(event){
        this.startDate_Value = event.target.value;
        this.startDate1 = this.startDate_Value
        console.log('*****************  Start Date  ********************');
    }

    handle_End_Date(event){
        this.endDate_Value = event.target.value;
        this.endDate1 = this.endDate_Value;
        console.log('*****************  End Date  ********************');
    }

    handleClick() {
        let downloadCsvButton = '';
        console.log('=====================' + downloadCsvButton);
        console.log('handleClick ===============> ' + this.startDate_Value);
        console.log('Record Id 2 =====> ' + this.recordId);
        this.date1 = new Date(this.startDate_Value);
        this.date2 = new Date(this.endDate_Value);

        console.log('------------------ startdate --------- ' + this.startDate_Value + '-----------  EndDate   ---------- '+ this.endDate_Value);
        this.result = this.date2 - this.date1; 

        /// this.result is in millisceonds you might need to convert it to days using below formula
        console.log('====================   mid Days  ====================' + this.result);
        this.result = parseInt(this.result/ (1000*60*60*24));


        if(182 > this.result){
            getData({ recordId: this.recordId, start_Date: this.startDate_Value, end_Date: this.endDate_Value })
        .then(result => {
               
            this.entriesRecord = result;          
            console.log('====================> Records ' + this.entriesRecord);
            downloadCsvButton = this.template.querySelector('.csv');
            downloadCsvButton.classList.add('visibleCsv');
            console.log('%%%%%%%%%%%%%%%%%%%%%%%%%      After result %%%%%%%%%%%%%%%%%%');
            // if(result == null){
            //     console.log('============== INvAlid');
            //     this.dispatchEvent(
            //             new ShowToastEvent({
            //                 title: 'Invalid',
            //                 message: 'PDF generated successfully with Id:',
            //                 variant: 'success',
            //             }),
                        
            //         );
            // }

        })
        .catch(error => {
            console.log(error + '      errorrrrrrrrrrrrrrrrrrrrrrrr............................');
            console.error(error);
            
            // let hidedownloadCsvButton = this.template.querySelector('.csv');
            // hidedownloadCsvButton.classList.add('hideButton');
        }) 
        }
        else{
            const event = new ShowToastEvent({
                title: 'Date Limit Hit',
                message: 'You can not enter date more than six months',
                variant: 'Warning'
            });

            this.dispatchEvent(event);
        }

               
    }

    // Download PDF
    downloadPdfFile() {
        console.log('==============   DownloadPDFFile is Running      ==================');
        //let Difference_In_Time = endDate_Value - startDate_Value;
  
        // To calculate the no. of days between two dates
        //let Difference_In_Days = Difference_In_Time / (1000 * 3600 * 24);
        this.date1 = new Date(this.startDate_Value);
        this.date2 = new Date(this.endDate_Value);


        console.log('------------------ startdate --------- ' + this.startDate_Value + '-----------  EndDate   ---------- '+ this.endDate_Value);
        this.result = this.date2 - this.date1; 
        /// this.result is in millisceonds you might need to convert it to days using below formula
        console.log('====================   mid Days  ====================' + this.result);
        this.result = parseInt(this.result/ (1000*60*60*24));

        console.log('====================   Days  ====================' + this.result);
        console.log('*****************************  entriesRecord ************************** ' + this.entriesRecord.length)
        if(182 > this.result){
            if(this.entriesRecord.length > 0){
                console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   this.entriesRecord  @@@@@@@@@@@@@@@@@@  ' + this.entriesRecord);
                let urlString = window.location.href;
                let urlWithParameters = urlString.substring(0, urlString.indexOf(".com/"));
                console.log(this.recordId);

                this.date1 = new Date(this.startDate_Value);
                this.date2 = new Date(this.endDate_Value);
                console.log('=========== Date ==========' + this.date1);
                console.log('=========== Date2 ==========' + this.date2);
                console.log('=========== startDate_Value ==========' + this.startDate_Value);
                console.log('=========== endDate_Value ==========' + this.endDate_Value);
                
                urlWithParameters = urlWithParameters.concat('.com/apex/Download_PDF?id=' + this.recordId + '&startdate=' + this.startDate_Value + '&enddate=' + this.endDate_Value);

                console.log('=====================  Url ============= ' + urlWithParameters);

                const event = new ShowToastEvent({
                    title: 'PDF Success',
                    message: 'PDF Downloaded Successfully',
                    variant: 'success'
                });

                this.dispatchEvent(event);
            
                //Opening url
                window.open(urlWithParameters);
            }
            else{
            const event = new ShowToastEvent({
                title: 'Empty Entries',
                message: 'Entries record is not available',
                variant: 'Warning'
            });
            this.dispatchEvent(event);
        }
            
        }  
        else{
            const event = new ShowToastEvent({
                title: 'Date Limit Hit',
                message: 'You can not enter date more than six months',
                variant: 'Warning'
            });
            this.dispatchEvent(event);
        }     
    }

    entryHeader ={
        Id:"Record Id",
        Name:"Name",
        Amount__c:"Amount",
        Type__c:"Type",
        Transaction_Date__c:"Transaction Date"

    }

    // CSV Download
    downloadCsvFile(){
        console.log('--------------  >  ' + this.entriesRecord );
        if(this.entriesRecord.length > 0){
            exportCSVFile(this.entryHeader, this.entriesRecord, "Transaction Entry Records")
        }
        else{
            const event = new ShowToastEvent({
                title: 'Empty Entries',
                message: 'Entries record is not available',
                variant: 'Warning'
            });
            this.dispatchEvent(event);
        }  
    }

    // Email Statement
    handleEmail(){
    
    console.log('Handle');
        
        //Calling Email method from apex
        sendRecordOnEmail({recordIdOfContact : this.recordId, start_Date: this.startDate1, end_Date: this.endDate1 })
                .then(result => 
                {
                    console.log('Result==== > ' + result);
                })
                .catch(error => {
                    console.log(error);
                    console.log('Error ===================');
                });
        
        const event = new ShowToastEvent({
            title: 'Email',
            message: 'PDF Genrated And sent to Contact Email address.',
            variant: 'success'
        });  
        this.dispatchEvent(event);
    }
    
    // For cancel Button
    closeAction(){
        console.log('closeAction is Running');
        console.log('Record Id 3 =====> ' + this.recordId);
        this.dispatchEvent(new CloseActionScreenEvent());
    }

}