public class TransactionTriggerHelper {
    public static void SetBookValueAtDividend(List<Dividend__c> dividends){
        Set<Id> shareClassIds = new Set<Id>();
        
        for(Dividend__c dividend : dividends){
            shareClassIds.add(dividend.Share_Class__c);
        }
        
        Map<Id, Share_Class__c> shareClassMap = new Map<Id, Share_Class__c>([select Id, Book_Cost__c from Share_Class__c where Id in: shareClassIds]);
        
        for(Dividend__c dividend : dividends){
            dividend.Book_Value_at_Dividend__c = shareClassMap.get(dividend.Share_Class__c).Book_Cost__c;
        }
    }
}