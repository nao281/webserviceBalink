@RestResource(urlMapping='/ClientListMembers/*')
global with sharing class WS_ClientListMember {

@HttpPut
global static void upsertClientListMember(String clientListId,List<String> listIdAccount) {
    RestResponse res = RestContext.response;
    res.addHeader('Content-Type','application/json');
    //map AccountId,Client List Member
    Map<String, Client_list_member__c> MapAccountCLM = new Map<String, Client_list_member__c>(); 

    //filling the map with the client that already have been added to the list
    for(Client_list_member__c clm : [Select Id,	Client__c,Client_list__c 
                                FROM Client_list_member__c
                                WHERE Client_list__c=:clientListId 
                                AND Client__c IN:listIdAccount]){
        MapAccountCLM.put(clm.Client__c, clm);
                                }
        for(String id:listIdAccount){
            //if there isn't client list member with these accounts we create a new client list member
            if(!MapAccountCLM.containskey(id) ){
                Client_list_member__c clm=new Client_list_member__c(
                Client_list__c=clientListId,
                Client__c=id
            );
            MapAccountCLM.put(id,clm);
            }   
        }
    try{
        upsert(MapAccountCLM.values());
        Set<Id>listCLMIds=new  Set<Id>();
        for(Client_list_member__c clm:MapAccountCLM.values()){
            listCLMIds.add(clm.Id);
        }
        res.statusCode = 200;
        res.responseBody =  Blob.valueOf(JSON.serialize(new Map<String, String>{'Success' => String.valueof(listCLMIds)}));
       
    }
    catch(Exception e){
        res.statusCode = 400;
        res.responseBody =  Blob.valueOf(JSON.serialize(new Map<String, String>{'Failed' => String.valueOf(e.getMessage())}));
        
        
    }
    
}
}