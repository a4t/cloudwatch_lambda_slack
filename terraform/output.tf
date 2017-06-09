output sns_arn {
  value = "${aws_sns_topic.notify_to_slack.arn}"
}
