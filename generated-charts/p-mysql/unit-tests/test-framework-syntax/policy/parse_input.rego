package main

expect ["input should contain valid object representation of rendered template"] {
  k := input["serviceinstance.yaml"].kind
  k == "ServiceInstance"
}
