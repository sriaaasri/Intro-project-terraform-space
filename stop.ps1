echo "Stopping ec2 instance"

aws ec2 stop-instances --instance-ids i-03398bd6fc30fa3f3

echo "Stopping RDS instance"

aws rds stop-db-instance --db-instance-identifier flask