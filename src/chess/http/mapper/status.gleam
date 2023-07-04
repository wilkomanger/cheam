import gleam/json.{Json}
import chess/game.{Progress, Check, Mate}

pub fn to_json(status: game.Status) -> Json {
  json.string(
    case status {
      Progress -> "progress"
      Check -> "check"
      Mate -> "mate"
    }
  )
}
