public class Jira_CreateIssue {

    @InvocableMethod(label='Create Issue on JIRA')
    public static void methodName(List<Id> ids) {
        


    }

    @future(callout=true)
    public Jira_Invoke() {

    }

    public class ModelCreateIssue{
        public cls_update update_z;
        public cls_fields fields;
        class cls_update {
        }
        class cls_fields {
            public String summary;	
            public cls_issuetype issuetype;
            public cls_project project;
            public cls_description description;
            public String duedate;	
        }
        class cls_issuetype {
            public String id;	
        }
        class cls_project {
            public String id;	
        }
        class cls_description {
            public String type;	
            public Integer version;	
            public cls_content[] content;
        }
        class cls_content {
            public cls_content[] content;
            public String text;	
            public String type;	
        }
        public static ModelCreateIssue parse(String json){
            return (ModelCreateIssue) System.JSON.deserialize(json, ModelCreateIssue.class);
        }
    }
}
