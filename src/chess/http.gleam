import gleam/http/cowboy
import gleam/json.{to_string}
import gleam/http/response
import gleam/bit_builder
import chess/game/registry.{new_game}
import chess/http/mapper/game.{to_json} as game_mapper

pub fn start() {
  let game_registry = registry.create()

  cowboy.start(
    fn(request) {
      case request.path {
        "/new" -> {
          let assert Ok(game) =
            game_registry
            |> new_game()

          let body =
            game
            |> to_json()
            |> to_string()
            |> bit_builder.from_string()

          response.new(200)
          |> response.set_body(body)
          |> response.set_header("Content-Type", "application/json")
        }
        _ ->
          response.new(404)
          |> response.set_body(bit_builder.from_string(""))
      }
    },
    on_port: 3000,
  )
}
