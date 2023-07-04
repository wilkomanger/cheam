import gleam/option.{Option}
import chess/piece.{Piece}
import chess/coordinates/rank.{Rank}
import chess/coordinates/file.{File}
import chess/color.{Color}

pub type Square {
  Square(coordinates: #(Rank, File), color: Color, occupied_by: Option(Piece))
}
