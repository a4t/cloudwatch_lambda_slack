resource "aws_kms_key" "lambda" {
  description         = "${var.identifier} key"
  enable_key_rotation = true

  tags {
    Name = "${var.identifier}"
  }
}

resource "aws_kms_alias" "lambda" {
  name          = "alias/${var.identifier}"
  target_key_id = "${aws_kms_key.lambda.key_id}"
}

data "aws_kms_ciphertext" "slack_hook_url" {
  key_id    = "${aws_kms_key.lambda.key_id}"
  plaintext = "${var.slack_hook_url}"
}
