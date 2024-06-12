import gleam/httpc
import gleam/io
import gleam/option.{None, Some}
import gleam/result
import swagger/settings
import swagger/user

pub fn main() {
  let s =
    settings.new()
    |> settings.with_auth_header_token("token nuh_uh")
  test_authed_user(s)
  test_get_user(s)
  test_search(s)
}

fn test_authed_user(s: settings.Settings) {
  let search = user.get_authed_user(s) |> io.debug
  use resp <- result.try(httpc.send(search))
  Ok(resp.body |> user.decode_user_response |> io.debug)
}

fn test_search(s: settings.Settings) {
  let search = user.search(s, Some("naomi"), None, None, None) |> io.debug
  use resp <- result.try(httpc.send(search))
  Ok(resp.body |> io.debug)
}

fn test_get_user(s: settings.Settings) {
  let u = user.get_user(s, "naomi") |> io.debug
  use resp <- result.try(httpc.send(u))
  Ok(resp.body |> user.decode_user_response |> io.debug)
}
