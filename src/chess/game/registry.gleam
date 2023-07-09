import gleam/io
import gleam/map.{Map, insert, size}
import gleam/int.{to_string}
import gleam/erlang/process.{Subject}
import gleam/otp/actor.{call, send}
import chess/game.{Game}
import chess/game/session.{GameSession}

pub opaque type GameRegistry {
  GameRegistry(actor: Subject(Message))
}

pub fn create() -> GameRegistry {
  let assert Ok(actor) = actor.start(map.new(), handle_message)
  GameRegistry(actor)
}

pub type NewGameError {
  // TODO: TEMP
  NewGameError
}

pub fn new_game(manager: GameRegistry) -> Result(Game, NewGameError) {
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
  sessions: Map(game.Id, GameSession),
) -> actor.Next(Map(game.Id, GameSession)) {
  case message {
    New(client) -> {
      // TODO: Use UUID
      let game_id =
        sessions
        |> size()
        |> to_string()
        |> game.Id()
      let game = game.new(game_id)

      // TODO: Handle error
      let assert Ok(session) = session.start(game)

      client
      |> send(game)

      let new_sessions =
        sessions
        |> insert(game_id, session)

      io.debug(new_sessions)

      actor.Continue(new_sessions)
    }
  }
}
