public class ShareClassTriggerHelper{
    public static List<Share_Class__c> UpdatePriceEnteredDates(List<Share_Class__c> shareclasses, DateTime timeToSet){
        System.debug('Share Classes');
        System.debug(shareClasses);
        Set<Id> shareClassIds = new Set<Id>();

        for(Share_Class__c shareClass : shareclasses){
            if(shareClass.Id != null){
                shareClassIds.add(shareClass.Id);
            }
        }

        Map<Id, Share_Class__c> oldShareClassesMap = new Map<Id, Share_Class__c>();
        if(!shareClassIds.isEmpty())
        {
            oldShareClassesMap = new Map<Id, Share_Class__c>([select Id, Current_Price__c from Share_Class__c where Id in: shareClassIds]);
        }

        for(Share_Class__c shareClass : shareclasses){
            Share_Class__c oldValue = oldShareClassesMap.get(shareClass.Id);

            //if new or current price changed
            if(oldValue == null || oldValue.Current_Price__c != shareClass.Current_Price__c){
                shareClass.Price_Entered_Date__c = timeToSet;
            }
        }

        return shareclasses;
    }
}