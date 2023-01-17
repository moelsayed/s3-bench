resource "aws_iam_user" "s3bench" {
  name = "s3bench"
}


// TODO: reduce this a bit
resource "aws_iam_policy_attachment" "test-attach" {
  name  = "s3bench"
  users = [aws_iam_user.s3bench.name]

  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_access_key" "s3bench" {
  user = aws_iam_user.s3bench.name
}
