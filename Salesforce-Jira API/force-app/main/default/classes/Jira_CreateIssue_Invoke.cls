public class Jira_CreateIssue_Invoke {


    @InvocableMethod(label='Create Issue on JIRA')
    public static void getIssueRecord(List<Id> ids) {
        
        //!set Variable for payload
        Map<String,String> payload = new Map<String,String>();
        String RecordId;

        //!get model for create issue
        Jira_M_CreateIssue IssueModel = new Jira_M_CreateIssue();
        
        Jira_M_CreateIssue.cls_fields fields = new Jira_M_CreateIssue.cls_fields();
        // Jira_M_CreateIssue.cls_update update_z = new Jira_M_CreateIssue.cls_update();
        Jira_M_CreateIssue.cls_content content1 = new Jira_M_CreateIssue.cls_content();
        Jira_M_CreateIssue.content2 content2 = new Jira_M_CreateIssue.content2();
        Jira_M_CreateIssue.cls_issuetype issueType = new Jira_M_CreateIssue.cls_issuetype();
        Jira_M_CreateIssue.cls_project project = new Jira_M_CreateIssue.cls_project();
        Jira_M_CreateIssue.cls_description description = new Jira_M_CreateIssue.cls_description();

        //!get Project Line Records
        List<Project_Line__c> ProjectLine = [
            SELECT 
                Id, Assigned_to__c, Description__c, Due_Date__c, 
                Name, Project__r.Name, 
                Project__r.SPK__c, Project__r.Jira_Project_ID__c 
            FROM 
                Project_Line__c
            WHERE Id=:ids];

        
        
        for (Project_Line__c PL_List : ProjectLine) {
            //!set class model
            issueType.id = '10078';
            project.id = PL_List.Project__r.Jira_Project_ID__c;

            //!set content model
            content2.type = 'text';
            content2.text = PL_List.Description__c;

            //!set Descriptions model
            description.type = 'doc';
            description.version = 1;
            List<Jira_M_CreateIssue.content2> contentDetails = new List<Jira_M_CreateIssue.content2>();
            contentDetails.add(content2);
            content1.type  ='paragraph';
            content1.content = contentDetails;
            
            List<Jira_M_CreateIssue.cls_content> contentDescriptions = new List<Jira_M_CreateIssue.cls_content>();
            contentDescriptions.add(content1);
            description.content = contentDescriptions;

            //!set fields model
            fields.summary = PL_List.Name;
            fields.duedate = String.valueOf(PL_List.Due_Date__c);
            fields.description= description;
            fields.issuetype = issueType;
            fields.project = project;

            RecordId = PL_List.Id;
        }

        IssueModel.fields = fields;
        
        String DataModel = JSON.serialize(IssueModel);
        System.debug('Data Model => ' + DataModel);

        payload.put(RecordId, DataModel);
        System.debug('payload => ' + payload);

        doRequest_CreateIssueJira(DataModel, RecordId);


    }
    

    @future(callout=true)
    public static void doRequest_CreateIssueJira(String payload, String RecordIds) {

        
        List<Project_Line__c> Obj_ProjectLine = new List<Project_Line__c>();


        // for (String keyvalue: payload.keySet()){
        //     JSONBody = JSON.serialize(payload.get(keyvalue));
        //     RecordIds.add(keyvalue);
        // }
        JiraConnection conn = new JiraConnection();
        String doreq = conn.JiraConnection('rest/api/3/issue', payload, 'POST');
        
        Object response = JSON.deserializeUntyped(doReq);
        Map<String,Object> Map_Response = (Map<String,Object>) response;

        System.debug('JSON response =>'+JSON.serialize(Map_Response));

        Obj_ProjectLine = [Select Id, Jira_Issue_ID__c FROM Project_Line__c WHERE Id=: RecordIds];

        for(Project_Line__c listPL : Obj_ProjectLine){
            listPL.Jira_Issue_ID__c = Map_Response.get('id').toString();
        }

        System.debug('Update PL => '+Obj_ProjectLine);
        Update Obj_ProjectLine;

    }

    
}
