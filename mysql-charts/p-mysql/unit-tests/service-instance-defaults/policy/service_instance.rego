package main

expect ["serviceinstance.yml produces svcat CR"] {
  k := input["serviceinstance.yaml"].kind
  k == "ServiceInstance"

  api := input["serviceinstance.yaml"].apiVersion
  api == "servicecatalog.k8s.io/v1beta1"
}

expect ["empty service instance params by default"] {
  spec := input["serviceinstance.yaml"].spec
  # {} is an empty composite value, i.e. an empty array
  # Learn more at https://www.openpolicyagent.org/docs/latest/policy-language/#composite-values
  spec.parameters == {}
}