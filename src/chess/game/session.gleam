import gleam/erlang/process.{Subject}
import gleam/otp/actor
import chess/game.{Game}

pub opaque type GameSession {
  GameSession(actor: Subject(Message))
}

pub fn start(game: Game) -> Result(GameSession, StartGameSessionError) {
  let assert Ok(actor) = actor.start(game, handle_message)
  Ok(GameSession(actor))
}

pub type StartGameSessionError {
  // TODO: TEMP
  StartGameSessionError
}

type Message {
  Move(reply_with: Subject(Game))
}

fn handle_message(message: Message, game: Game) -> actor.Next(Game) {
  case message {
    Move(client) -> {
      actor.Continue(game)
    }
  }
}
