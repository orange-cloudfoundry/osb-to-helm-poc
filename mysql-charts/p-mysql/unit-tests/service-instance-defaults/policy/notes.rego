package main

expect ["notes.txt renders as string"] {
  notes := input["NOTES.txt"]

  not is_null(notes)
  is_string(notes)
}

expect ["notes.txt contains header"] {
  notes := input["NOTES.txt"]

  contains(notes, "NOTES.txt controls this text output once a chart is installed.")
}
