@isTest
private class updateInvCaseSubTypeTest{
    @isTest static void TestCase (){
        String dateString = String.valueof(Datetime.now()).replace(' ', '').replace(':', '').replace('-', '');
        String orgId = UserInfo.getOrganizationId();
        Integer randomInt = Integer.valueOf(math.rint(math.random() * 1000000));
        String uniqueName = orgId + dateString + randomInt;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        
        User u = new User(Alias = 'standt', 
        Email = 'standarduser@testorg.com', 
        EmailEncodingKey = 'UTF-8', 
        LastName = 'Testing', 
        LanguageLocaleKey = 'en_US', 
        LocaleSidKey = 'en_US', 
        TimeZoneSidKey = 'America/Los_Angeles', 
        ProfileId = p.Id,
        Username = uniqueName + '@test' + orgId + '.org'); 
        insert u;
        
        Bucket_Account_Settings__c bas = new Bucket_Account_Settings__c();
        bas.Bucket_Account_Owner_ID__c ='005d0000001WOeV';
        bas.Bucket_Account_RecordTypeID__c = '012d000000098Wt';
        bas.Default_Bucket_Name__c = 'Bucket Account';
        bas.Maximum_Size_of_Bucket__c = 5000;
        insert bas;
        
        Account acc = new account(name = 'individual');
        insert acc;
        
        Contact con = new Contact(AccountId=acc.Id, lastname='testing', firstname='apex');
        insert con; 
            
        Switch__c cohstest = new Switch__c();
        cohstest.Switch__c = false;
        cohstest.Name = 'CaseOwnerHistorySwitch';
        insert cohstest;
        
        id strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Service Cases'].Id;
        
        Validation_Rules__c supportConfig = Validation_Rules__c.getOrgDefaults();
        supportConfig.Bypass_Rules__c = false;        
        upsert supportConfig Validation_Rules__c.Id;  
        
        System.runas(u){        
            Case caseObj = new Case(
            RecordTypeId  = strRecordTypeId, 
            ContactId = con.Id,
            AccountId  = acc.Id,
            Type = 'Aquatics',
            Subject = 'Grants',
            Status = 'New',
            Origin = 'Email',
            Invoice_Case_Sub_Type__c = 'Product',
            CRS__c = '123',
            Current_Order_Amount__c = 123.88,
            Order_Number__c = '123',
            Customer_ID__c = '123',
            State__c = 'AK');
            
            insert caseObj; 
        }
        
                
        
    }
}