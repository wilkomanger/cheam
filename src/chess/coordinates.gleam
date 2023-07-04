import gleam/int.{to_string}
import gleam/list.{at}
import chess/color.{Color}
import chess/coordinates/rank.{Rank}
import chess/coordinates/file.{File}

const letters = ["a", "b", "c", "d", "e", "f", "g"]

pub fn numeric(coordinates: #(Rank, File)) -> #(Int, Int) {
  let #(r, f) = coordinates

  #(
    r
    |> rank.numeric(),
    f
    |> file.numeric(),
  )
}

pub fn from_numeric(rank r: Int, file f: Int) -> #(Rank, File) {
  #(
    r
    |> rank.from_numeric(),
    f
    |> file.from_numeric(),
  )
}

/// Returns the coordinates in algebraic form.
pub fn algebraic(coordinates: #(Rank, File)) -> String {
  let #(rank_num, file_num) =
    coordinates
    |> numeric()

  let assert Ok(file) =
    letters
    |> at(file_num - 1)

  rank_num
  |> to_string() <> file
}

const max = 8

/// Returns the coordinates from the given point-of-view.
pub fn relative(coordinates: #(Rank, File), to pov: Color) -> #(Rank, File) {
  case pov {
    color.White -> coordinates
    color.Black -> {
      let #(rank_num, file_num) =
        coordinates
        |> numeric()
      from_numeric(max - rank_num + 1, max - file_num + 1)
    }
  }
}
