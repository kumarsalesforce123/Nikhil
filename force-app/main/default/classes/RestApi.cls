@RestResource(urlmapping = '/Testing/*')
global with sharing class RestApi {
    // @RestResource(urlmapping = '/Testing/*')
    
    @HttpGet
    global static List<Account> getAccountName(){
        List<Account> accList = [select id,Name from account];
        return accList;
        
    }
  /*  @HttpPost
    @HttpDelete
    @HttpPut
    @HttpPatch */

}