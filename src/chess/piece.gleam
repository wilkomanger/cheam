import chess/color.{Color}

pub type Piece {
  Pawn(color: Color)
  Rook(color: Color)
  Knight(color: Color)
  Bishop(color: Color)
  Queen(color: Color)
  King(color: Color)
}
