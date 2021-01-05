public class sf_dev_test_controller {
    public String cont_role {get; set;}
    public String email {get; set;}
    public String job_title {get; set;}
    public String first_name {get; set;}
    public String last_name {get; set;}
    public String phone_num {get; set;}
    public String assistant {get; set;}
    
    public sf_dev_test_controller() 
    {
    
        String message = '' + ApexPages.CurrentPage().GetParameters().Get('message');
        String pageHeaderReferer = ApexPages.currentPage().getHeaders().get('Referer'); 
        if(pageHeaderReferer != null && pageHeaderReferer.containsIgnoreCase('nikhilreddy') && message != 'null')
        {
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, message)); 
        }
        
    }
    
    public pagereference create_contact() 
    {   
        if(String.isBlank( cont_role ) )
        {
            Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR, 'You must select a Contact Role.' ) ); 
        } 
        else if( cont_role == 'TECH' ) {
            if( String.isBlank( email ) ) 
            {
                Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR, 'Email is a required field.' ) ); 
            } 
        else {
            if( !( email.contains( '@' ) ) ) 
            {
                Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR, 'Enter a valid email address.' ) ); 
            }
        }
        if( String.isBlank( first_name ) ) {
            Apexpages.addMessage( new ApexPages.Message( 
            ApexPages.Severity.ERROR, 'First Name is a required field.' ) );
        } else {
            if( first_name.length() > 40 ) {
                Apexpages.addMessage( new ApexPages.Message( 
            ApexPages.Severity.ERROR, 'First Name is limited to 40 characters.' ) );
            }
        }
        if( String.isBlank( last_name ) ) {
            Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'Last Name is a required field.' ) );
            } else {
                if( last_name.length() > 80 ) {
                    Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'Last Name is limited to 80 characters.' ) );
                }
            }
            if( String.isBlank( phone_num ) ) {
                Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'Phone Number is a required field.' ) );
            }
            if( String.isBlank( job_title ) ) {
                Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'Job Title is a required field.' ) );
            }
        // Field Checks for Exectuive Role   
        } else if( cont_role == 'EXEC' ) {
            if( String.isBlank( email ) ) {
                Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'Email is a required field.' ) ); 
            } else {
                if( !( email.contains( '@' ) ) ) {
                    Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR, 'Enter a valid email address.' ) ); 
                }
            }
            if( String.isBlank( first_name ) ) {
                Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'First Name is a required field.' ) );
            } else {
                if( first_name.length() > 40 ) {
                    Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'First Name is limited to 40 characters.' ) );
                }
            }
            if( String.isBlank( last_name ) ) {
                Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'Last Name is a required field.' ) );
            } else {
                if( last_name.length() > 80 ) {
                    Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'Last Name is limited to 80 characters.' ) );
                }
            }
            if( String.isBlank( phone_num ) ) {
                Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'Phone Number is a required field.' ) );
            }
            if( String.isBlank( job_title ) ) {
                Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'Job Title is a required field.' ) );
            }
            if( String.isBlank( assistant ) ) {
               Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'Assistant is a required field.' ) );
            }
                    
        // Field Checks for Customer Role
        } else if( cont_role == 'CUST' ) {
            if( String.isBlank( email ) ) {
                Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'Email is a required field.' ) ); 
            } else {
                if( !( email.contains( '@' ) ) ) {
                    Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'Enter a valid email address.' ) ); 
                }
            }
            if( String.isBlank( first_name ) ) {
                Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'First Name is a required field.' ) );
            } else {
                if( first_name.length() > 40 ) {
                    Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'First Name is limited to 40 characters.' ) );
                }
            }
            if( String.isBlank( last_name ) ) {
               Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'Last Name is a required field.' ) );
            } else {
                if( last_name.length() > 80 ) {
                   Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'Last Name is limited to 80 characters.' ) );
                }
            }
            if( String.isBlank( phone_num ) ) {
              Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'Phone Number is a required field.' ) );
            }
                
        // Field Checks for Unknown Role
        } else if( cont_role == 'UNKNOWN' ) {
            if( String.isBlank( email ) ) {
               Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'Email is a required field.' ) ); 
            } else {
                if( !( email.contains( '@' ) ) ) {
                   Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'Enter a valid email address.' ) ); 
                }
            }
            if( String.isBlank( first_name ) ) {
               Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'First Name is a required field.' ) );
            } else {
                if( first_name.length() > 40 ) {
                    Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'First Name is limited to 40 characters.' ) );
                }
            }
            if( String.isBlank( last_name ) ) {
                Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'Last Name is a required field.' ) );
            } else {
                if( last_name.length() > 80 ) {
                   Apexpages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,  'Last Name is limited to 80 characters.' ) );
                }
            }
        }
            Contact con = new Contact();
                con.Department = cont_role;
                con.Email = email;
                con.FirstName = first_name;
                con.LastName = last_name;
                con.Title = job_title;
                con.AssistantName = assistant;
                con.Phone = phone_num;
            insert con;
            
            
            PageReference pg = new PageReference('/apex/nick');
            pg.getParameters().put('message', 'Contact Created Successfully  ' + con.id);
            pg.setRedirect(true); 
           
        return pg;  
        
        }
       
}