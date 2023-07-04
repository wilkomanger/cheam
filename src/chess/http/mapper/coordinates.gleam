import gleam/json.{Json}
import chess/coordinates
import chess/coordinates/rank.{Rank}
import chess/coordinates/file.{File}

pub fn to_json(coords: #(Rank, File)) -> Json {
  let #(rank, file) =
    coords
    |> coordinates.numeric()
  [rank, file]
  |> json.array(fn(coord) { json.int(coord) })
}
