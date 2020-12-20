package main

assert ["servicePlanName should be defined"] {
  "100mb" == input["values"]["servicePlanName"]
}

