#!/bin/sh
aws ec2-instance-connect send-ssh-public-key --instance-id i-0f592d9fe5e38f33c  --instance-os-user ec2-user --ssh-public-key file://~/.ssh/helen_aws.pub --availability-zone us-east-2a | cat
aws ec2-instance-connect send-ssh-public-key --instance-id i-02f61701031509a4f --instance-os-user ec2-user --ssh-public-key file://~/.ssh/helen_aws.pub --availability-zone us-east-2c | cat
aws ec2-instance-connect send-ssh-public-key --instance-id i-09158fb4628e68f4d --instance-os-user ec2-user --ssh-public-key file://~/.ssh/helen_aws.pub --availability-zone us-east-2c | cat
