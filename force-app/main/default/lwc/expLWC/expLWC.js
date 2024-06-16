import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from "lightning/platformShowToastEvent";

import SECURITY_NAME_FIELD from '@salesforce/schema/Security__c.Name';
import SECURITY_VALUE_FIELD from '@salesforce/schema/Security__c.Value__c';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Security__c.Account_Name__c';
import getSecurities from '@salesforce/apex/ExpLWCController.getSecurities';

const SECURITY_COLUMNS =[
    {label: 'Security Name', fieldName: SECURITY_NAME_FIELD.fieldApiName, type:'text'},
    {label: 'Value', fieldName: SECURITY_VALUE_FIELD.fieldApiName, type:'currency'},
    {label: 'Account', fieldName: ACCOUNT_NAME_FIELD.fieldApiName, type:'text'}
]

export default class ExpLWC extends LightningElement {
    columns = SECURITY_COLUMNS;
    @wire(getSecurities) securities;

    handleClick(event){
        const showToastEvt = new ShowToastEvent({
            title: 'A button was clicked',
            message: 'This is a message',
            variant: 'info'
        });
        this.dispatchEvent(showToastEvt);
    }
}