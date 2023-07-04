import gleam/option.{None, Option, Some}
import gleam/json.{Json}
import chess/piece.{Bishop, King, Knight, Pawn, Piece, Queen, Rook}
import chess/http/mapper/color

pub fn to_json(piece optional_piece: Option(Piece)) -> Json {
  case optional_piece {
    None -> json.null()
    Some(piece) ->
      json.object([
        #(
          "kind",
          json.string(case piece {
            Pawn(_) -> "pawn"
            Rook(_) -> "rook"
            Knight(_) -> "knight"
            Bishop(_) -> "bishop"
            Queen(_) -> "queen"
            King(_) -> "king"
          }),
        ),
        #(
          "color",
          piece.color
          |> color.to_json(),
        ),
      ])
  }
}
