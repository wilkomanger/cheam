import gleam/json.{Json}
import chess/board.{Board}
import chess/http/mapper/square

pub fn to_json(board: Board) -> Json {
  json.object([
    #(
      "squares",
      json.array(
        board.squares,
        fn(squares) { json.array(squares, square.to_json) },
      ),
    ),
  ])
}
