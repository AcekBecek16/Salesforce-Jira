public class Jira_Invoke {

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
            public String summary;	//Testing API
            public cls_issuetype issuetype;
            public cls_project project;
            public cls_description description;
            public String duedate;	//2022-12-30
        }
        class cls_issuetype {
            public String id;	//10112
        }
        class cls_project {
            public String id;	//10039
        }
        class cls_description {
            public String type;	//doc
            public Integer version;	//1
            public cls_content[] content;
        }
        class cls_content {
            public cls_content[] content;
            public String text;	//Order entry fails when selecting supplier.
            public String type;	//text
        }
        public static ModelCreateIssue parse(String json){
            return (ModelCreateIssue) System.JSON.deserialize(json, ModelCreateIssue.class);
        }
    }
}
