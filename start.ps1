echo "Starting instances"

aws ec2 start-instances --instance-ids 'i-03398bd6fc30fa3f3'

echo "Starting RDS instances"

aws rds start-db-instance --db-instance-identifier flask