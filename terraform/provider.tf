terraform {
  required_providers {
    eveng = {
      source = "CorentinPtrl/eveng"
    }
  }
}

provider "eveng" {
  host     = "https://192.168.100.75/"
  username = "lucille"
  password = "lucille"
}