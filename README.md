# Day-Two-task
use IaC Terrafrom to build the following resource besides requirement specifications:


Use S3 to store Terraform statefile using "erakiterrafromstatefiles" bucket

Create S3 Bucket.

Enable S3 Bucker Versioning.

Disable ACL and ensure object ownership have "BucketOwnerEnforced"

Create a directory under the S3 Bucket called "logs"

Provide Bucket policy permission for your IAM user to upload object only under logs.

Force destroy Bucket even if the bucket is not empty.
