@IsTest
private class Test_WS_ClientListMember {
    @isTest static void testupsertClientListMember() {
       
        RestResponse res = new RestResponse();
        RestContext.response = res;
         // Call the method to test
		List<String>ListIdAccount=new List<String>();
        ListIdAccount.add('0014K0000037ZS7QAM');
        ListIdAccount.add('0014K0000037ZS6QAM');
	    WS_clientListMember.upsertClientListMember('a004K000001NmxdQAC', listIdAccount);

        // Verify results
        Client_list_member__c thisClientListMember = [SELECT Id,Client_list__c FROM Client_list_member__c WHERE Client__c='0014K0000037ZS7QAM'];
        System.assert(thisClientListMember.Id != null);
        System.assertEquals(thisClientListMember.Client_list__c, 'a004K000001NmxdQAC');
    }
   
}