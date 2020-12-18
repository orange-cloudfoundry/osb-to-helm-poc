
Each test suite is composed of a set of rego assertions all sharing the same user input(s).

```
unit-tests/suite-template
├── policy
│   └── passing.rego
└── user-inputs
    └── empty-input.yml
```

The test launcher iterates over each test suite and evalues it