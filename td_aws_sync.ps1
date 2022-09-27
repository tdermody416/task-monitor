#########
#Name:td_test_sync.ps1
#
#Test Purpose: Use portions of main script to test Sync to S3 where parameters contain spaces in strings
#Purpose: Synchronize (upload) file system with an AWS S3 bucket. Data removed from file system DOES NOT get removed from S3. Each instrument should have 
#it's own individual folder on S3.
#
#Instructions: .\td_test_sync.psq -source <Local or remote directory to synchronize> -instrument <instrument name, all lowercase, use underscores and no spaces> 
# -awsprofile <name of locally configured aws credentials profile>
#
#Example 1: Synchronize the content of C:\Data directory storing Optima Analytical Ultracentrifuge data runs with a folder called optima_auc on S3
#.\awssync.ps1 -source "C:\Data" -instrument optima_auc -awsprofile s3
#Example 2: Synchronize the content of a remote file share storing BioRad QX200 runs with a folder on S3. 
# .\awssync.ps1 -source "\\share_name\folder_name" -instrument qx200 -awsprofile s3
####
#09/20/2022, v1.0, Terry Dermody, creating new PS script to test Sync with parameters which contain spaces in their value string
##### 

#Input parameters
Param(
[string]$source # = '\\rawdata1\c$\HOLD\test_data_destination_v1',
)
#[string]$instrument = 'td_test',
#[string]$awsprofile = 'td'
#)

#Variables
#$source = '\\rawdata1\c$\HOLD\test data source v2'
#$year = (Get-Date).Year
#$month = (Get-Date).Month
#$day = (Get-Date).Day
#$bucket = 'terry-test-raw-data'
#$logBase = "C:\Logs"
#$daysBack = 60
#$awsprofile = 'td'
#$region = 'us-east-1'

#Logging. If log folder does not exist, create it
#$logLocal = $logBase+"\"+$instrument+"\"+$year+"\"+$month+"\"+$day

#if (!(test-path $logLocal)){
#    New-Item -ItemType Directory $logLocal | Out-Null;
#}

#Synchronize content from local folder and log into file
#aws s3 sync $source s3://$bucket/$instrument --profile $awsprofile --region 'us-east-1' >> c:\hold\log.txt
#below is working;
#aws s3 sync c:\hold\test_data_source_v1 s3://terry-test-raw-data --profile td --region us-east-1
#adding UNC path
aws s3 sync $source s3://terry-test-raw-data --profile td --region us-east-1

#Upload the log file to the instrument logs folder
#aws s3 cp $logLocal\$year$month$day-log.txt s3://$bucket/$instrument/~logs/$year/$month/$day/$year$month$day-log.txt --profile $awsprofile

#Clean up local log files older than 60 days
#$cleanUpDate = (Get-Date).AddDays($daysBack)
#Get-ChildItem $logLocal | Where-Object {$_.LastWriteTime -gt $cleanUpDate} | Remove-Item