# Welcome to MeetGreet's CDK Java project!

This project contains the code for MeetGreet's CDK development with Java.

The `cdk.json` file tells the CDK Toolkit how to execute MeetGreet.

It is a [Maven](https://maven.apache.org/) based project, so you can open this project with any Maven compatible Java IDE to build and run tests.

## Useful commands

 * `mvn package`     compile and run tests
 * `cdk ls`          list all stacks in the app
 * `cdk synth`       emits the synthesized CloudFormation template
 * `cdk deploy`      deploy this stack to your default AWS account/region
 * `cdk diff`        compare deployed stack with current state
 * `cdk docs`        open CDK documentation

In order to use AWS Services, you need to create an account via https://aws.amazon.com. You may qualify for a free tier account but if not, charges may be incurred if you attempt to create this stack. Please check your eligibility: https://aws.amazon.com/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all

Please note that we are not responsible for any charges that you may incur if you wish to AWS services.

## Please follow these steps to deploy a MeetGreet config.

NOTE: Before following any of these steps, you must download the aws-cli and the aws-cdk to your computer.

Installing the AWS CLI Docs: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

Installing the AWS CDK Docs: https://docs.aws.amazon.com/cdk/v2/guide/cli.html

Installing MYSQL to your computer: https://dev.mysql.com/doc/refman/8.0/en/installing.html (You will need to determine the correct version to install based on your OS and the requirements of said version.)

### 1) Navigate to the AWS-Infrastructure-As-Code package on your device.

You will need to generate an API Key via the AWS Console to use their services. This is not something that can be done programatically. Please follow these steps if you are unsure of how to do this:

   a) Search for IAM. Click on Users -> Add Users. Add a username and press next.
    
   b) Click on 'Attach Policies Directly'.
    
   c) Search for 'AdministratorAccess' and check it to add this policy to the user. Press the Next button at the bottom of the page.
    
   d) Press 'Create User'. You will be navigated to a list of the current users for your account. Click on the user you just created.
    
   e) Click on the 'Security Credentials' tab and find the 'Access Keys' header. Click on 'Create Access Key'.
    
   f) Select 'Command Line Interface', agree to the terms and press next. You may add a description if you wish on the next page.
    
   e) Then, press 'Create Access Key'. You will be presented with a screen displaying for Access Key and Secret Access Key. Make sure to take note of both and store them in a secure location. You can also opt to download the CSV file.

### 2) `aws configure` -> When prompted for your Access Key and Secret Access Key, please provide the ones created in step 1.
### 3) `cdk bootstrap`
### 4) `cdk deploy --profile default`

The MeetGreet CloudFormation stack will begin deployment. Please note that this will take some time but the resources should begin to be provisioned on your AWS account. You can see detailed progress updates by navigating to the 'CloudFormation' console on AWS or less detailed progress updated by following along in the terminal. 

## Steps Following a Successful CDK Deployment.

Once deployment completes, you will be have your own stack of MeetGreet's services running. You will need to connect to the AWS RDS MYSQL database created in order to create the MeetGreet database using the commands present in the `MYSQL/dot_net_init.sql` file of this package. This can be done using the `mysql -h <host name> -u admin -p` command from a terminal. The host name of your RDS MYSQL databse is dynamically generated and can be found in the RDS console on AWS. When prompted for a password, please note that the default password is `password`. You may need to install mysql to your system if it does not have it installed already. 

**You must also provide an Email API Key** for the `INSERT INTO EmailAPIKey (APIKey) VALUES ("[VALUE-REDACTED]")` command in the `dot_net_init.sql`. This is used for the SendGrid email verification API (https://sendgrid.com). Our service is configured to not allow users to login without a verified email so this will block the functionality from our site of being accessed if not configured.

**You must also provide a value for the AWS AWSAPIKey** for the `INSERT INTO AWSAPIKey (AccessKey, SecretAccessKey) VALUES ("[VALUE-REDACTED]", "[VALUE-REDACTED]")` command in the `dot_net_init.sql` file. This is used for the service to access certain AWS resources and not configuring this correctly may result in MeetGreet not working correctly, or at all. You can create your own AWS API Keys using the AWS console and these keys must provide full access to AWS S3. 

Once the database has been configured, you must change the `DefaultConnection:ConnectionString` (located in appsettings.json) inside of the MeetGreet's ASP.NET project to that of the RDS MYSQL instance that was created in your AWS account. The same must also be done to the connectionstring in the MeetGreetContext file as well (on line 37). You must also change the value of the `BUCKET_NAME` string variable present in the `MeetGreet/AmazonS3HelperClasses/AmazonS3Helper.cs` class to that of your S3 bucket. S3 bucket names are globally unique so this change must be made. You can find your bucket's name via the S3 console on AWS. 

After the above steps have been completed, you will have an AWS Stack provsioned that can support the MeetGreet application. Please note that this is unneccessary if you're looking to just run MeetGreet; As previously mentioned, the application is configured to connect with and work with our configured AWS stack for its 'production' mode.

## Deleting The Stack

In order to Delete the MeetGreet Infrastructure Stack, navigate to the CloudFormation page on the AWS Console. Select the `AwsInfrastructureAsCodeStack` stack and click the delete button. This will deprovision the stack and delete any resources that it created. Once the status of the stack changes to 'DELETE_COMPLETE', the stack and all of its resources have been deleted successfully (it may also disapear from your list of stacks prior to the status change). Please note that if an error occurs during resource deprovision, the stuck resources may need to be deleted manually.
