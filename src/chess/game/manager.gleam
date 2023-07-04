import gleam/io
import gleam/map.{Map, insert, size}
import gleam/int.{to_string}
import gleam/erlang/process.{Subject}
import gleam/otp/actor.{call, send}
import chess/game.{Game}

pub opaque type GameManager {
  GameManager(actor: Subject(Message))
}

pub fn create() -> GameManager {
  let assert Ok(actor) = actor.start(map.new(), handle_message)
  GameManager(actor)
}

pub type NewGameError {
  // TODO: TEMP
  NewGameError
}

pub fn new_game(manager: GameManager) -> Result(Game, NewGameError) {
  // TODO: Handle error
  let game =
    manager.actor
    |> call(New, 100)

  Ok(game)
}

type Message {
  New(reply_with: Subject(Game))
}

fn handle_message(
  message: Message,
  games: Map(game.Id, Game),
) -> actor.Next(Map(game.Id, Game)) {
  case message {
    New(client) -> {
      let game_id =
        games
        |> size()
        |> to_string()
        |> game.Id()
      let game = game.new(game_id)

      client
      |> send(game)

      let new_games =
        games
        |> insert(game_id, game)

      io.debug(new_games)

      actor.Continue(new_games)
    }
  }
}
