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


Please follow these steps to deploy a MeetGreet config 

1) aws configure
2) cdk bootstrap
3) cdk deploy --profile default

