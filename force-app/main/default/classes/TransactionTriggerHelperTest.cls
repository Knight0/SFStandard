@isTest
public class TransactionTriggerHelperTest {
    static testmethod void CalculateDividendValue(){
        Account testAccount = new Account(Name='Test');
        insert testAccount;
        
        Fund__c testFund = new Fund__c(Name='Test Fund', Investment_Firm__c=testAccount.Id);
        insert testFund;
        
        Share_Class__c testShareClass = new Share_Class__c(Name='Test Share Class', Fund__c = testFund.Id, Distribution__c = 'Income'  );
        insert testShareClass;
        
        Integer randomBookCost = Integer.valueof((Math.random() * 1000))+100;
        
        Transaction__c testTransaction = new Transaction__c(
            Share_Class__c = testShareClass.Id, 
            Settled_Date__c=Date.today().addDays(-1), 
            Cost__c = randomBookCost,
            Units__c = 1,
            Execution_Date__c = Date.today().addDays(-4) 
        );
        insert testTransaction; 
        
        test.startTest();
        testShareClass = [select Id, Book_Cost__c from Share_Class__c where Id=: testShareClass.Id];
        system.assertEquals(randomBookCost , testShareClass.Book_Cost__c);
        
        Dividend__c testDividend = new Dividend__c(Date__c = Date.today(), Share_Class__c = testShareClass.Id, Dividend__c = 10);
        insert testDividend;
        testDividend = [select Id,  Book_Value_at_Dividend__c from Dividend__c where Id=:testDividend.Id];
        
        System.assertEquals(randomBookCost , testDividend.Book_Value_at_Dividend__c);
    }
}