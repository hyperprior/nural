use std assert
use std/testing *
use ../nural/linalg.nu *

@test
def "dot product of two vectors is correct" [] {
  let x = [1.0, 2.2, 3]
  let y =  [4, 5.1, 6.0]

  let product = $x | dot $y
  assert equal $product 33.22
}
