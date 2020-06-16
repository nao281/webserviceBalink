@RestResource(urlMapping='/ClientLists/*')
global with sharing class WS_ClientList {

    //creation d'une nouvelle liste de clients
	 @HttpPost
    global static void CreateClientList(String name, String description,
        String image) {
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type','application/json');
        Client_list__c thisClientList = new Client_list__c(
            Name=name,
            description__c=description,
            image__c=image);

        try{
            insert thisClientList;
            res.statusCode = 200;
            res.responseBody =  Blob.valueOf(JSON.serialize(new Map<String, String>{'Success' => String.valueOf(thisClientList.Id)}));
            
        }
        catch(Exception e){
            res.statusCode=400;
            res.responseBody= Blob.valueOf(JSON.serialize(new Map<String, String>{'Failed' => String.valueOf(e.getMessage())}));
           
        }
 
    }

}