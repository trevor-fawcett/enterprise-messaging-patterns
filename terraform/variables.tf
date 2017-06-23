variable "access_key" {}
variable "secret_key" {}
variable "region" {
    default = "eu-west-2"
}
variable "dispatcher_topic" {
    default = "dispatcher"
}
variable "events_topic" {
    default = "events"
}
variable "referrals_queue" {
    default = "referrals"
}