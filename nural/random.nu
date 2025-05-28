use ./constants.nu *

export def normal []: nothing -> any {
  # box-muller transform for normal random variables
  let u1 = (random float) + 1e-10
  let u2 = (random float)

  let r = (-2 * ($u1 | math ln)) | math sqrt
  let theta = (2 * (pi) * $u2)
  $r * ($theta | math cos)
}


(normal)
