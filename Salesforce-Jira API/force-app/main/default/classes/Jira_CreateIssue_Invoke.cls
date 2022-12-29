public class Jira_CreateIssue_Invoke {
    public Jira_CreateIssue_Invoke() {

    }

    @InvocableMethod(label='Create Issue on JIRA')
    public static void getIssueRecord(List<Id> ids) {
        
        //!get model for create issue
        Jira_M_CreateIssue IssueModel = new Jira_M_CreateIssue();
        
        Jira_M_CreateIssue.cls_fields fields = new Jira_M_CreateIssue.cls_fields();
        Jira_M_CreateIssue.cls_update update_z = new Jira_M_CreateIssue.cls_update();
        Jira_M_CreateIssue.cls_content content = new Jira_M_CreateIssue.cls_content();
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
            issueType.id = '10112';
            project.id = PL_List.Project__r.Jira_Project_ID__c;

            //!set content model
            content.type = 'text';
            content.text = PL_List.Description__c;

            //!set Descriptions model
            description.type = 'doc';
            description.version = 1;
            List<Jira_M_CreateIssue.cls_content> contentDetails = new List<Jira_M_CreateIssue.cls_content>();
            contentDetails.add(content);
            description.content = contentDetails;

            //!set fields model
            fields.summary = PL_List.Name;
            fields.duedate = String.valueOf(PL_List.Due_Date__c);
            fields.description= description;
            fields.issuetype = issueType;
            fields.project = project;
        }

        IssueModel.fields = fields;
        
        String DataModel = JSON.serialize(IssueModel);

    }
}
