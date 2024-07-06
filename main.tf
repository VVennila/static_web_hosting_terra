resource "aws_s3_bucket" "static_bucket" {
  bucket        = "vennilastaticwebsite.sctp-sandbox.com"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "enable_public_access" {
  bucket                  = aws_s3_bucket.static_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "allow_public_access" {
  bucket = aws_s3_bucket.static_bucket.id
  policy = data.aws_iam_policy_document.static_bucket.json

}
data "aws_iam_policy_document" "static_bucket" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.static_bucket.arn,
      "${aws_s3_bucket.static_bucket.arn}/*",
    ]
  }
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject",
    ]
    resources = [
      "arn:aws:s3:::vennilastaticwebsite.sctp-sandbox.com/*",
    ]
  }
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.static_bucket.id

  index_document {
    suffix = "index.html"
  }
}

