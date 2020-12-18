package main

assert ["values object should have multiple file values"] {
  100mb == input["values"]["servicePlanName"]
}
