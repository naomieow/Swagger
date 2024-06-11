import swagger/user
import gleam/io
import gleam/result
import gleam/httpc
import swagger/settings

pub fn main() {
  let u = user.get_user(settings.new(), "naomi") |> io.debug
  use resp <- result.try(httpc.send(u))
  Ok(resp.body |> io.debug)
}