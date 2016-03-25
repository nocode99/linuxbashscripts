AWSCLI.sh

#list by EC2 instance tag names:
aws ec2 describe-instances --query 'Reservations[].Instances[].Tags[?Key==`Name`].Value[]'
