public with sharing class expLWCController {
    @AuraEnabled(Cacheable=true)
    public static List<Security__c> getSecurities(){
        if(Security__c.SObjectType.getDescribe().isAccessible()){
            return [SELECT Id, Name, Value__c, Account_Name__c from Security__c];
        }
        return new List<Security__c>();
    }
}