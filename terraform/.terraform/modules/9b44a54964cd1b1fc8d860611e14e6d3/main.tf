variable "name" {}
variable "topic" {}

resource "aws_sqs_queue" "queue" {
    name            = "${var.name}_queue"
    redrive_policy  = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.deadletter.arn}\",\"maxReceiveCount\":3}"
}

resource "aws_sqs_queue_policy" "policy" {
    queue_url       = "${aws_sqs_queue.queue.id}"
    policy          = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "${aws_sqs_queue.queue.arn}/SQSDefaultPolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "SQS:SendMessage",
      "Resource": "${aws_sqs_queue.queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${var.topic}"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_sqs_queue" "deadletter" {
    name            = "${var.name}_queue_deadletter"
}

resource "aws_sns_topic_subscription" "topic_queue_subscription" {
    topic_arn       = "${var.topic}"
    protocol        = "sqs"
    endpoint        = "${aws_sqs_queue.queue.arn}"
}