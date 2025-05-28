export def dot [right: list<number>]: list<number> -> number {
  if ($in | length) != ($right | length) {
    return nothing
  }

  $in
  | zip $right
  | each {|pair| $pair.0 * $pair.1 }
  | math sum
}

export def dim []: any -> list<int> {
  if ($in | describe) =~ 'list' {
    if ($in | is-empty) {
      [0]
    } else {
      let head = ($in | get 0)
      let rest = ($head | dim)
      [($in | length)] ++ $rest
    }
  } else {
    []
  }
}

export def @ [right: any]: any -> any {
  let left = $in

  if $left == null or $right == null {
    return nothing
  }

  if ($left | dim) != ($right | dim) {
    return nothing
  }

  if ($left | describe) =~ 'list' and ($right | describe) =~ 'list' {
    $left | zip $right | each {|pair|
      let l = $pair.0
      let r = $pair.1

      if $l == null or $r == null {
        return nothing
      }

      $l | @ $r
    }
  } else {
    $left * $right
  }
}
