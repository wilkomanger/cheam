import gleam/list.{map, map_fold, range}
import gleam/option.{None, Some}
import chess/piece.{Bishop, King, Knight, Pawn, Queen, Rook}
import chess/board/square.{Square}
import chess/coordinates
import chess/coordinates/rank
import chess/coordinates/file.{A, B, C, D, E, F, G, H}
import chess/color

pub type Board =
  List(List(Square))

pub fn initial() -> Board {
  let range = range(1, 8)

  range
  |> map(fn(rank_num) {
    let initial_color = case rank_num % 2 {
      0 -> color.White
      1 -> color.Black
    }

    range
    |> map_fold(
      initial_color,
      fn(square_color, file_num) {
        let coords = coordinates.from_numeric(rank_num, file_num)
        let #(rank, file) = coords

        let piece = {
          let piece_color = case rank {
            rank.One | rank.Two -> Some(color.White)
            rank.Seven | rank.Eight -> Some(color.Black)
            _ -> None
          }

          case piece_color {
            None -> None
            Some(color) -> {
              let #(first_rank, second_rank) = case color {
                color.White -> #(rank.One, rank.Two)
                color.Black -> #(rank.Eight, rank.Seven)
              }

              case rank {
                _ if rank == first_rank ->
                  case file {
                    A | H -> Some(Rook(color))
                    B | G -> Some(Knight(color))
                    C | F -> Some(Bishop(color))
                    D -> Some(King(color))
                    E -> Some(Queen(color))
                    _ -> None
                  }
                _ if rank == second_rank -> Some(Pawn(color))
                _ -> None
              }
            }
          }
        }

        let next_square_color = case square_color {
          color.Black -> color.White
          color.White -> color.Black
        }

        #(next_square_color, Square(coords, square_color, piece))
      },
    )
  })
  |> map(fn(color_and_squares) { color_and_squares.1 })
}
