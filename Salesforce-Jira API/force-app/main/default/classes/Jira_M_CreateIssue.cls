public class Jira_M_CreateIssue {
    
        public cls_update update_z;
        public cls_fields fields;
        public class cls_update {
        }
        public class cls_fields {
            public String summary;	
            public cls_issuetype issuetype;
            public cls_project project;
            public cls_description description;
            public String duedate;	
        }
        public class cls_issuetype {
            public String id;	
        }
        public class cls_project {
            public String id;	
        }
        public class cls_description {
            public String type;	
            public Integer version;	
            public cls_content[] content;
        }
        public class cls_content {
            public cls_content[] content;
            public String text;	
            public String type;	
        }
        public static Jira_M_CreateIssue parse(String json){
            return (Jira_M_CreateIssue) System.JSON.deserialize(json, Jira_M_CreateIssue.class);
        }
    
}
