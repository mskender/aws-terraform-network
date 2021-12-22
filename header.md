# Simple Network Module for AWS


## Description

This is a module to provide a cookie-cutter vpc layout, currently supporting following features:
- private subnet(s) creation
- public subnet(s) creation
- IGW and appropriate route table creation
- NATGW and appropriate route table creation
- SSM endpoints creation with appropriate security groups
- default tags
- custom subnet tags for i.e. EKS tagging