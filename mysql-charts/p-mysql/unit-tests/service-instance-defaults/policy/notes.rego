package main

expect ["NOTES.txt renders as string"] {
  notes := input["NOTES.txt"]

  not is_null(notes)
  is_string(notes)
}

expect ["NOTES.txt contains header"] {
  notes := input["NOTES.txt"]

  contains(notes, "Dashboard url may be accessed through the following command:")
}
