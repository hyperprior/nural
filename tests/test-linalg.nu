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


@test
def "left and right vectors in dot product must be same length" [] {
  let x = [1, 2, 3, 4, 5, 6]
  let y = [1, 2, 3]

  assert equal ($x | dot $y) nothing
}

@test
def "dimension of a vector is its length" [] {
  assert equal ([1, 2, 3] | dim) [3]
  assert equal ([1, 2, 3, 4] | dim) [4]
  assert equal ([1, 2, 3, 4, 5] | dim) [5]

  
}

@test
def "test multi-dimensional tensor dimensions" [] {

  assert equal ([[1, 2], [3, 4]] | dim) [2 2]
  assert equal ([[[1]]] | dim) [1, 1, 1]
  assert equal ([[1, 2, 3], [4, 5, 6], [7, 8, 9]] | dim) [3, 3]
  assert equal ([[[[1 2 3 4], [5 6 7 8], [9 10 11 12]] , [[[13 14 15 16], [17 18 19 20], [21 22 23 24]]]]] | dim) [1, 2, 3, 4]
  assert equal ([[[1, 2]], [[3, 4]], [[5, 6]]] | dim) [3, 1, 2]
  assert equal ([1] | dim) [1]
  assert equal ([[[[42]]]] | dim) [1, 1, 1, 1]
  assert equal ([[[1, 2], [3, 4]], [[5, 6], [7, 8]]] | dim) [2, 2, 2]
  assert equal ([[], [], []] | dim) [3, 0]
  assert equal ([[], [[]], [[[]]]] | dim) [3, 0]
  assert equal ([[[[1 2], [3 4]], [[5 6], [7 8]]], [[[9 10], [11 12]], [[13 14], [15 16]]]] | dim) [2, 2, 2, 2]


}

@test
def "test multiplying two two-dimensional matrices" [] {
   let x = [
     [1, 2, 3],
     [4, 5, 6],
     [7, 8, 9]
   ]

   let y = [
     [4, 5, 6],
     [7, 8, 9],
     [10, 11, 12]
   ]
  
  let expected = [
  [4, 10, 18]
  [28, 40, 54]
  [70, 88, 108]
]

  assert equal ($x | @ $y) $expected
}
