import chess/board.{Board}

pub type Game {
  Game(id: Id, board: Board, status: Status)
}

pub type Id {
  Id(value: String)
}

pub type Status {
  Progress
  Check
  Mate
}

pub fn new(id: Id) -> Game {
  Game(id, board.initial(), Progress)
}
