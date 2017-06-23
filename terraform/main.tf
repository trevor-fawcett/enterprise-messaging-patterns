provider "aws" {
    access_key      = "${var.access_key}"
    secret_key      = "${var.secret_key}"
    region          = "${var.region}"
}

resource "aws_sns_topic" "dispatcher_topic" {
    name            = "${var.dispatcher_topic}"
}

output "dispatcher_topic_arn" {
    value           = "${aws_sns_topic.dispatcher_topic.arn}"
}

resource "aws_sns_topic" "events_topic" {
    name            = "${var.events_topic}"
}

output "events_topic_arn" {
    value           = "${aws_sns_topic.events_topic.arn}"
}

resource "aws_sqs_queue" "referrals_queue" {
    name            = "${var.referrals_queue}"
    redrive_policy  = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.referrals_queue_deadletter.arn}\",\"maxReceiveCount\":3}"
}

output "referrals_queue_id" {
    value           = "${aws_sqs_queue.referrals_queue.id}"
}

output "referrals_queue_arn" {
    value           = "${aws_sqs_queue.referrals_queue.arn}"
}

resource "aws_sqs_queue_policy" "referrals_queue_policy" {
    queue_url       = "${aws_sqs_queue.referrals_queue.id}"
    policy          = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "${aws_sqs_queue.referrals_queue.arn}/SQSDefaultPolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "SQS:SendMessage",
      "Resource": "${aws_sqs_queue.referrals_queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.dispatcher_topic.arn}"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_sqs_queue" "referrals_queue_deadletter" {
    name            = "${var.referrals_queue}_deadletter"
}

resource "aws_sns_topic_subscription" "dispatch_topic_referrals_queue_subscription" {
    topic_arn       = "${aws_sns_topic.dispatcher_topic.arn}"
    protocol        = "sqs"
    endpoint        = "${aws_sqs_queue.referrals_queue.arn}"
}