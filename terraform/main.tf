provider "aws" {
    access_key      = "${var.access_key}"
    secret_key      = "${var.secret_key}"
    region          = "${var.region}"
}

resource "aws_sns_topic" "dispatcher_topic" {
    name            = "dispatcher"
}

resource "aws_sns_topic" "events_topic" {
    name            = "events"
}

module "referrals_queue" {
    source          = "./queue"
    name            = "referrals"
    topic           = "${aws_sns_topic.dispatcher_topic.arn}"
}

module "clients_queue" {
    source          = "./queue"
    name            = "clients"
    topic           = "${aws_sns_topic.dispatcher_topic.arn}"
}

module "cases_queue" {
    source          = "./queue"
    name            = "cases"
    topic           = "${aws_sns_topic.dispatcher_topic.arn}"
}

module "networks_queue" {
    source          = "./queue"
    name            = "networks"
    topic           = "${aws_sns_topic.dispatcher_topic.arn}"
}

module "members_queue" {
    source          = "./queue"
    name            = "members"
    topic           = "${aws_sns_topic.dispatcher_topic.arn}"
}

module "communications_queue" {
    source          = "./queue"
    name            = "communications"
    topic           = "${aws_sns_topic.dispatcher_topic.arn}"
}
