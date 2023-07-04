import gleam/json.{Json}
import chess/board/square.{Square}
import chess/http/mapper/coordinates
import chess/http/mapper/color
import chess/http/mapper/piece

pub fn to_json(square: Square) -> Json {
  json.object([
    #(
      "coordinates",
      square.coordinates
      |> coordinates.to_json,
    ),
    #(
      "color",
      square.color
      |> color.to_json,
    ),
    #(
      "occupiedBy",
      square.occupied_by
      |> piece.to_json,
    ),
  ])
}
