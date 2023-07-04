import gleam/io
import gleam/erlang/process
import chess/http

pub fn main() {
  io.println("Starting..")

  http.start()

  process.sleep_forever()
}
