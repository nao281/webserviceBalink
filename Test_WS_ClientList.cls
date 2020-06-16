@IsTest
private class Test_WS_ClientList {
    @isTest static void testCreateClientList() {
        RestResponse res = new RestResponse();
        RestContext.response = res;
         // Call the method to test
	    WS_clientList.CreateClientList('Client List 1', 'List of clients', 'www.google.fr');

        // Verify results
        Client_list__c thisClientList = [SELECT Id,Name FROM Client_list__c WHERE Name='Client List 1'];
        System.assert(thisClientList.Id != null);
        System.assertEquals(thisClientList.Name, 'Client List 1');
    }
   
}