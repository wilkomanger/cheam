pub type Rank {
  I
  II
  III
  IV
  V
  VI
  VII
  VIII
}

pub fn numeric(rank: Rank) -> Int {
  case rank {
    I -> 1
    II -> 2
    III -> 3
    IV -> 4
    V -> 5
    VI -> 6
    VII -> 7
    VIII -> 8
  }
}

pub fn from_numeric(rank: Int) -> Rank {
  case rank {
    1 -> I
    2 -> II
    3 -> III
    4 -> IV
    5 -> V
    6 -> VI
    7 -> VII
    8 -> VIII
    _ -> panic
  }
}
