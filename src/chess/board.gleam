import gleam/list.{map, map_fold, range}
import gleam/option.{None, Some}
import chess/piece.{Bishop, King, Knight, Pawn, Queen, Rook}
import chess/board/square.{Square}
import chess/coordinates
import chess/coordinates/rank.{I, II, VII, VIII}
import chess/coordinates/file.{A, B, C, D, E, F, G, H}
import chess/color

pub type Board {
  Board(squares: List(List(Square)))
}

pub fn initial() -> Board {
  let range = range(1, 8)

  let squares =
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
              I | II -> Some(color.White)
              VII | VIII -> Some(color.Black)
              _ -> None
            }

            case piece_color {
              None -> None
              Some(color) -> {
                let #(first_rank, second_rank) = case color {
                  color.White -> #(I, II)
                  color.Black -> #(VIII, VII)
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

  Board(squares)
}
