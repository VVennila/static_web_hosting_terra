terraform {
  backend "s3" {
    bucket = "sctp-ce6-tfstate"
    key    = "ven-stcweb.tfstate" #Remember to change this
    region = "ap-southeast-1"     #The region of your backend bucket
  }
}