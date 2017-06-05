resource "aws_sns_topic" "notify_to_slack" {
  name = "${var.identifier}_notify_to_slack"
}

resource "aws_sns_topic_subscription" "notify_to_slack" {
  topic_arn = "${aws_sns_topic.notify_to_slack.arn}"
  protocol = "lambda"
  endpoint = "${aws_lambda_function.cloudwatch_to_slack.arn}"
}
