import { LightningElement } from 'lwc';
export default class Calculator extends LightningElement {
    result
    showResult = false
    // Perform arithmetic operation during action on html button
    handleOperation(event){
        if(event.target.title == 'addition'){
            this.result = parseInt(this.template.querySelectorAll(".operand")[0].value)  + parseInt(this.template.querySelectorAll(".operand")[1].value)               
        }
        else if(event.target.title == 'subtract'){
            this.result = parseInt(this.template.querySelectorAll(".operand")[0].value)  - parseInt(this.template.querySelectorAll(".operand")[1].value)
        }
        else if(event.target.title == 'multiply'){
            this.result = parseInt(this.template.querySelectorAll(".operand")[0].value)  * parseInt(this.template.querySelectorAll(".operand")[1].value)
        }
        else{
            this.result = parseInt(this.template.querySelectorAll(".operand")[0].value)  / parseInt(this.template.querySelectorAll(".operand")[1].value)
        }
        this.showResult = true
    }   
}
