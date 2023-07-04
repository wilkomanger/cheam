import gleam/json.{Json}
import chess/color.{Black, Color, White}

pub fn to_json(color: Color) -> Json {
  case color {
    White -> json.string("white")
    Black -> json.string("black")
  }
}
