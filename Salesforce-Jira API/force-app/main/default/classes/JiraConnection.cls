public class JiraConnection {
    public static string JiraConnection(String endpoint, String body, String method) {

        Http http = new Http();
        HttpRequest request = new HttpRequest();

        //!set basic authenticationq
        Blob auth = Blob.valueOf(System.label.Jira_Username+':'+System.label.JIRA_Token);


        request.setHeader('Content-Type', 'application/json');
        request.setEndpoint(System.label.JIRA_URL+''+endpoint);
        request.setHeader('Authorization', 'Basic '+auth);
        request.setMethod(method);
        request.setBody(body);

        HttpResponse response = http.send(request);
        System.debug(response.getBody());
        return response.getBody();
        

    }
}
