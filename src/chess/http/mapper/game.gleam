import gleam/json.{Json}
import chess/game.{Game}
import chess/http/mapper/board
import chess/http/mapper/status

pub fn to_json(game: Game) -> Json {
  json.object([
    #(
      "id",
      game.id.value
      |> json.string(),
    ),
    #(
      "status",
      game.status
      |> status.to_json(),
    ),
    #(
      "board",
      game.board
      |> board.to_json(),
    ),
  ])
}
