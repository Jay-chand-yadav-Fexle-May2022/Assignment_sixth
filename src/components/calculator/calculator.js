import { LightningElement } from 'lwc';
export default class Calculator extends LightningElement {
    result
    showResult = false
    // Operation will be perform during addition 
    handleAdd(event){
        this.result = parseInt(this.template.querySelectorAll(".operand")[0].value)  + parseInt(this.template.querySelectorAll(".operand")[1].value)
        this.showResult = true     
    }
    // Operation will be perform during substration 
    handleSub(event){
        this.result = parseInt(this.template.querySelectorAll(".operand")[0].value)  - parseInt(this.template.querySelectorAll(".operand")[1].value)
        this.showResult = true
    }
    // Operation will be perform during multiplication 
    handleMul(event){
        this.result = parseInt(this.template.querySelectorAll(".operand")[0].value)  * parseInt(this.template.querySelectorAll(".operand")[1].value)
        this.showResult = true
    }
    // Operation will be perform during division 
    handleDiv(event){
        this.result = parseInt(this.template.querySelectorAll(".operand")[0].value)  / parseInt(this.template.querySelectorAll(".operand")[1].value)
        this.showResult = true
    }
}