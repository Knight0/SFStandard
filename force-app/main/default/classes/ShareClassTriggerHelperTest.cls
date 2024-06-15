@isTest
public class ShareClassTriggerHelperTest{
    static testmethod void UpdatePriceEnteredDateTest(){
        Account testAccount = new Account(Name='Test');
        insert testAccount;
        
        Fund__c testFund = new Fund__c(Name='Test Fund', Investment_Firm__c=testAccount.Id);
        insert testFund;

        DateTime testStartTime = DateTime.now().addDays(-1);

        Share_Class__c testShareClass = new Share_Class__c(
            Name='Test Share Class', 
            Fund__c = testFund.Id, 
            Distribution__c = 'Income',
            Current_Price__c = 4.9,
            Price_Entered_Date__c = testStartTime
        );
        insert testShareClass;

        DateTime testTime = DateTime.now();

        testShareClass.Current_Price__c = 5.5;

        List<Share_Class__c> result = ShareClassTriggerHelper.UpdatePriceEnteredDates(new List<Share_Class__c>{testShareClass}, testTime);

        testShareClass = result[0];

        System.assertEquals(testTime, testShareClass.Price_Entered_Date__c);
    }

    static testmethod void DontUpdateIfPriceDoesntChange(){
        Account testAccount = new Account(Name='Test');
        insert testAccount;
        
        Fund__c testFund = new Fund__c(Name='Test Fund', Investment_Firm__c=testAccount.Id);
        insert testFund;

        DateTime testStartTime = DateTime.now().addDays(-1);

        Share_Class__c testShareClass = new Share_Class__c(
            Name='Test Share Class', 
            Fund__c = testFund.Id, 
            Distribution__c = 'Income',
            Current_Price__c = 4.9,
            Price_Entered_Date__c = testStartTime
        );
        insert testShareClass;

        DateTime testTime = DateTime.now();

        testShareClass.Ticker_Symbol__c = 'AV.';

        List<Share_Class__c> result = ShareClassTriggerHelper.UpdatePriceEnteredDates(new List<Share_Class__c>{testShareClass}, testTime);

        testShareClass = result[0];

        System.assertEquals(testStartTime, testShareClass.Price_Entered_Date__c);
    }

    static testmethod void UpdatePriceEnteredDateAutoTest(){
        Account testAccount = new Account(Name='Test');
        insert testAccount;
        
        Fund__c testFund = new Fund__c(Name='Test Fund', Investment_Firm__c=testAccount.Id);
        insert testFund;

        DateTime testStartTime = DateTime.now().addDays(-1);

        Test.startTest();
        Share_Class__c testShareClass = new Share_Class__c(
            Name='Test Share Class', 
            Fund__c = testFund.Id, 
            Distribution__c = 'Income',
            Current_Price__c = 4.9
        );
        insert testShareClass;
        Test.stopTest();

        testShareClass = [select Id, Current_Price__c, Price_Entered_Date__c from Share_Class__c where Id=: testShareClass.Id];

        System.assertNotEquals(null, testShareClass.Price_Entered_Date__c);
    }
}