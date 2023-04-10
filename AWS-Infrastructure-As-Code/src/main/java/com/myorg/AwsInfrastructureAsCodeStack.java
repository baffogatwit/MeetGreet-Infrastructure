package com.myorg;

import software.constructs.Construct;

import java.util.Arrays;

import software.amazon.awscdk.PhysicalName;
import software.amazon.awscdk.SecretValue;
import software.amazon.awscdk.Stack;
import software.amazon.awscdk.StackProps;
import software.amazon.awscdk.services.ec2.*;
import software.amazon.awscdk.services.iam.Effect;
import software.amazon.awscdk.services.iam.Policy;
import software.amazon.awscdk.services.iam.PolicyStatement;
import software.amazon.awscdk.services.iam.User;
import software.amazon.awscdk.services.rds.*;
import software.amazon.awscdk.services.s3.Bucket;
import software.amazon.awscdk.services.s3.BucketEncryption;

public class AwsInfrastructureAsCodeStack extends Stack {
    public AwsInfrastructureAsCodeStack(final Construct scope, final String id) {
        this(scope, id, null);
    }

    public AwsInfrastructureAsCodeStack(final Construct scope, final String id, final StackProps props) {
        super(scope, id, props);
        // The code that defines your stack goes here
        final Vpc vpc = Vpc.Builder.create(this, id + "-vpc")
                .natGateways(1)
                .natGatewaySubnets(SubnetSelection.builder().subnetType(SubnetType.PUBLIC).build())
                .build();

        final Policy s3AccessPolicy = Policy.Builder.create(this, id + "-s3policy")
                .statements(Arrays.asList(PolicyStatement.Builder
                        .create()
                        .effect(Effect.ALLOW)
                        .actions(
                                Arrays.asList(
                                        "s3:*"))
                        .resources(
                                Arrays.asList("*"))
                        .build()))
                .build();

        final User meetGreetASP = User.Builder.create(this, id)
                .userName("meet-greet-asp")
                .build();

        s3AccessPolicy.attachToUser(meetGreetASP);

        final IInstanceEngine instanceEngine = DatabaseInstanceEngine.mysql(
                MySqlInstanceEngineProps.builder()
                        .version(MysqlEngineVersion.VER_8_0_28)
                        .build());

        final SecurityGroup databaseSecurityGroup = SecurityGroup.Builder.create(this, id + "-sg")
                .vpc(vpc)
                .allowAllOutbound(true)
                .build();

        databaseSecurityGroup.addIngressRule(databaseSecurityGroup, Port.allTraffic());

        final DatabaseInstance databaseInstance = DatabaseInstance.Builder.create(this, id + "-rds")
                .vpc(vpc)
                .vpcSubnets(SubnetSelection.builder().subnetType(SubnetType.PUBLIC).build())
                .instanceType(InstanceType.of(InstanceClass.BURSTABLE3, InstanceSize.MICRO))
                .engine(instanceEngine)
                .instanceIdentifier(id + "-rds")
                .publiclyAccessible(true)
                .securityGroups(Arrays.asList(databaseSecurityGroup))
                .credentials(Credentials.fromPassword("admin", SecretValue.unsafePlainText("password")))
                .build();

        final Bucket targetBucket = Bucket.Builder.create(this, id + "-s3")
                .bucketName(PhysicalName.GENERATE_IF_NEEDED)
                .encryption(BucketEncryption.S3_MANAGED)
                .versioned(Boolean.TRUE)
                .build();

    }

}
