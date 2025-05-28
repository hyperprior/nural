use std assert
use std/testing *

@before-all
def setup [] {
  {
    iris: (open tests/iris.csv)
  }
}

@test
def "iris is a nu table" [] {
  assert equal ($in.iris | length) 150
}
