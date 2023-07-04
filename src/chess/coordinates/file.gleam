pub type File {
  A
  B
  C
  D
  E
  F
  G
  H
}

pub fn numeric(file: File) -> Int {
  case file {
    A -> 1
    B -> 2
    C -> 3
    D -> 4
    E -> 5
    F -> 6
    G -> 7
    H -> 8
  }
}

pub fn from_numeric(file: Int) -> File {
  case file {
    1 -> A
    2 -> B
    3 -> C
    4 -> D
    5 -> E
    6 -> F
    7 -> G
    8 -> H
    _ -> panic
  }
}
