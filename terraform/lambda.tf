resource "null_resource" "zip_lambda_script" {
  triggers {
    slack_channel = "${var.slack_channel}"
    slack_hook_url = "${var.slack_hook_url}"
  }

  provisioner "local-exec" {
    command = <<EOM
      rm -rf ../dist/index.zip && \
      zip -j ../dist/index.zip ../src/index.js
EOM
  }
}

resource "aws_iam_policy_attachment" "lambda_role_attachment" {
  name = "lambda_role_attachment"
  roles = ["${aws_iam_role.lambda.name}"]
  policy_arn = "${aws_iam_policy.kms.arn}"
}

resource "aws_lambda_function" "cloudwatch_to_slack" {
  filename         = "../dist/index.zip"
  function_name    = "${var.identifier}-cloudwatch-to-slack"
  role             = "${aws_iam_role.lambda.arn}"
  handler          = "index.handler"
  source_code_hash = "${base64sha256(file("../dist/index.zip"))}"
  runtime          = "nodejs6.10"

  environment {
    variables = {
      kmsEncryptedHookUrl = "${data.aws_kms_ciphertext.slack_hook_url.ciphertext_blob}"
      slackChannel = "${var.slack_channel}"
    }
  }
}
