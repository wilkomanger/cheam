import gleam/json.{Json}
import chess/board.{Board}
import chess/http/mapper/square

pub fn to_json(board: Board) -> Json {
  json.array(board, fn(squares) { json.array(squares, square.to_json) })
}
