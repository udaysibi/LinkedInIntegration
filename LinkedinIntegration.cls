public class LinkedinIntegration {
    
    public static void callmethods(){
        String loginId=loginToLinkedin();
        postToLinkedin(loginId);
        
    }
    public static void postToLinkedin(String loginId)
    {
        
        Http http = new Http();
        Httprequest request =new Httprequest();
        request.setMethod('POST');
        request.setHeader('Content-Type','application/json');
        String authorid='urn:li:person:' + loginId;
        String postbody= '{' +
            '"author": "'+authorId+'",' +
            '"lifecycleState": "PUBLISHED",' +
            '"specificContent": {' +
            '"com.linkedin.ugc.ShareContent": {' +
            '  "shareCommentary": {' +
            '     "text": "Hello World! This is my first Share on LinkedIn!"' +
            '},' +
            '"shareMediaCategory": "NONE"' +
            '}' +
            '},' +
            '"visibility": {' +
            ' "com.linkedin.ugc.MemberNetworkVisibility": "PUBLIC"' +
            '}' +
            '}';
        request.setBody(postbody);
        request.setEndpoint('callout:Linkedin/v2/ugcPosts');
        Httpresponse response=http.send(request);
        system.debug('response ' + response.getBody());
        system.debug('response ' + response.getStatus());
    }
    
    
    public static string loginToLinkedin(){
        Http http = new Http();
        Httprequest request =new Httprequest();
        request.setMethod('GET');
        request.setEndpoint('callout:Linkedin/v2/userinfo');
        Httpresponse response=http.send(request);
        system.debug('response ' + response.getBody());
        system.debug('response ' + response.getStatus());
        Map<String,object> result=(Map<String,object>)JSON.deserializeUntyped(response.getBody());
        String loginId=(String)result.get('sub');
        System.debug(loginId);
        return loginId;
        
    }
}