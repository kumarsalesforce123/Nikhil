@Istest
Public class sf_dev_test_controller_Test
{    
    public static testmethod void sf_dev_test_controller()
    {
        test.starttest();
        sf_dev_test_controller sfdc = new sf_dev_test_controller();
        sfdc.cont_role=null;
        sfdc.email='test@gmail.com';
        sfdc.job_title='test';
        sfdc.first_name =null;
        sfdc.last_name =null;
        sfdc.phone_num='1234455';
        sfdc.assistant='testassistant'; 
        try
        { 
        sfdc.create_contact();
        }catch(exception e){}
        
        sf_dev_test_controller sfdc1 = new sf_dev_test_controller();

        sfdc1.cont_role='TECH';
        sfdc1.email=null;
        sfdc1.job_title='test';
        sfdc1.first_name ='nkrdfsalkfldsjosdjfjdkjfkjdjfdfdkkdkdkkdkdkdkdkdk';
        sfdc1.last_name ='nkrdfsalkfldsjosdjfjdkjfkjdjfdfdkkdkdkkdkdkdkdkdknkrdfsalkfldsjosdjfjdkjfkjdjfdfdkkdkdkkdkdkdkdkdk';
        sfdc1.phone_num='1234455';
        sfdc1.assistant='testassistant'; 
        try
        { 
        sfdc1.create_contact();
        }catch(exception e){}
        
        sf_dev_test_controller sfdc2 = new sf_dev_test_controller();
        sfdc2.cont_role='TECH';
        sfdc2.email='dfdfdsfds';
        sfdc2.job_title='test';
        sfdc2.first_name ='nkr';
        sfdc2.last_name ='nkr';
        sfdc2.phone_num='1234455';
        sfdc2.assistant='testassistant';  
        try
        {
        sfdc2.create_contact();
        }catch(exception e){}
        
        sf_dev_test_controller sfdc3 = new sf_dev_test_controller();
        sfdc3.cont_role='TECH';
        sfdc3.email='dfdfdsfds';
        sfdc3.job_title=null;
        sfdc3.first_name =null;
        sfdc3.last_name =null;
        sfdc3.phone_num=null;
        sfdc3.assistant=null;  
        try
        {
        sfdc3.create_contact();
        }catch(exception e){}
        
        sf_dev_test_controller sfdc4 = new sf_dev_test_controller();
        sfdc4.cont_role='EXEC';
        sfdc4.email=null;
        sfdc4.job_title=null;
        sfdc4.first_name =null;
        sfdc4.last_name =null;
        sfdc4.phone_num=null;
        sfdc4.assistant=null;  
        try
        {
        sfdc4.create_contact();
        }catch(exception e){}
        
        sf_dev_test_controller sfdc5 = new sf_dev_test_controller();
        sfdc5.cont_role='EXEC';
        sfdc5.email='fdfdddfdfdd';
        sfdc5.job_title=null;
        sfdc5.first_name ='nkrdfsalkfldsjosdjfjdkjfkjdjfdfdkkdkdkkdkdkdkdkdk';
        sfdc5.last_name ='nkrdfsalkfldsjosdjfjdkjfkjdjfdfdkkdkdkkdkdkdkdkdknkrdfsalkfldsjosdjfjdkjfkjdjfdfdkkdkdkkdkdkdkdkdk';
        sfdc5.phone_num=null;
        sfdc5.assistant=null;  
        try
        {
        sfdc5.create_contact();
        }catch(exception e){}
        
        sf_dev_test_controller sfdc6 = new sf_dev_test_controller();
        sfdc6.cont_role='CUST';
        sfdc6.email=null;
        sfdc6.job_title=null;
        sfdc6.first_name =null;
        sfdc6.last_name =null;
        sfdc6.phone_num=null;
        sfdc6.assistant=null;  
        try
        {
        sfdc6.create_contact();
        }catch(exception e){}
        
        sf_dev_test_controller sfdc7 = new sf_dev_test_controller();
        sfdc7.cont_role='CUST';
        sfdc7.email='fdfdddfdfdd';
        sfdc7.job_title=null;
        sfdc7.first_name ='nkrdfsalkfldsjosdjfjdkjfkjdjfdfdkkdkdkkdkdkdkdkdk';
        sfdc7.last_name ='nkrdfsalkfldsjosdjfjdkjfkjdjfdfdkkdkdkkdkdkdkdkdknkrdfsalkfldsjosdjfjdkjfkjdjfdfdkkdkdkkdkdkdkdkdk';
        sfdc7.phone_num=null;
        sfdc7.assistant=null;  
        try
        {
        sfdc7.create_contact();
        }catch(exception e){}
        
        sf_dev_test_controller sfdc8 = new sf_dev_test_controller();
        sfdc8.cont_role='UNKNOWN';
        sfdc8.email=null;
        sfdc8.job_title=null;
        sfdc8.first_name =null;
        sfdc8.last_name =null;
        sfdc8.phone_num=null;
        sfdc8.assistant=null;  
        try
        {
        sfdc8.create_contact();
        }catch(exception e){}
        
        sf_dev_test_controller sfdc9 = new sf_dev_test_controller();
        sfdc9.cont_role='UNKNOWN';
        sfdc9.email='fdfdddfdfdd';
        sfdc9.job_title=null;
        sfdc9.first_name ='nkrdfsalkfldsjosdjfjdkjfkjdjfdfdkkdkdkkdkdkdkdkdk';
        sfdc9.last_name ='nkrdfsalkfldsjosdjfjdkjfkjdjfdfdkkdkdkkdkdkdkdkdknkrdfsalkfldsjosdjfjdkjfkjdjfdfdkkdkdkkdkdkdkdkdk';
        sfdc9.phone_num=null;
        sfdc9.assistant=null;  
        try
        {
        sfdc9.create_contact();
        }catch(exception e){}
        
        sf_dev_test_controller sfdc10 = new sf_dev_test_controller();
        sfdc10.cont_role='test';
        sfdc10.email='testddd@gmail.com';
        sfdc10.job_title='test';
        sfdc10.first_name ='nkr';
        sfdc10.last_name ='nkr';
        sfdc10.phone_num='333322222';
        sfdc10.assistant='testassistant';  
        
        sfdc10.create_contact();
        
        test.stoptest();
    }
}