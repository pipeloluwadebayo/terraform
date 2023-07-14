resource "aws_s3_bucket" "development" {
  bucket = "2023q3developmentbucket"
  tags = {
    description = "Development and PreTests"
  }
}


resource "aws_s3_bucket_object" "q3devbucket" {
  content = "/root/devtest/devtestjuly23.doc"
  key     = "devtestjuly23.doc"
  bucket  = aws_s3_bucket.development.id
}


# grant access to users that terraform is not aware of
data "aws_iam_group" "devtest" {
  group_name = "DevTestDepartment"
}


resource "aws_s3_bucket_policy" "devtest-policy" {
  bucket = aws_s3_bucket.development.id
  policy = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [{
        "Principal":{
            "AWS":[
                 "${data.aws_iam_group.devtest.arn}"
         ]
        },
        "Effect": "Allow",
        "Action": [
            "s3:PutObject"
        ],
        "Resource": [
            "arn:aws:s3:::${aws_s3_bucket.development.id}/*"
        ],
        "Condition": {
            "StringEquals": {
                "s3:RequestObjectTag/Department": "Finance"
            }
        }
    }]
}
EOF
}
