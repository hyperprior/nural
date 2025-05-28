export def zeros [shape: list<int>] {
  if ($in | is-empty) {
    return 0
  }

  let n = ($shape | first)
  let rest = ($shape | skip 1)

  seq 0 ($n - 1) | each {|_| zeros $rest }
 
}


export def ones [shape: list<int>] {
  
}
