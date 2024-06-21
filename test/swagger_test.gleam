import startest
import startest/config
import startest/reporters/dot

// pub fn main() {
//   let s =
//     swagger.new()
//     |> swagger.with_auth_header_token("token nuh_uh")
//   test_authed_user(s)
//   test_get_user(s)
//   test_search(s)
// }

// fn test_authed_user(s: swagger.Settings) {
//   let search = user.get_authed_user(s) |> pprint.debug
//   use resp <- result.try(httpc.send(search))
//   Ok(resp.body |> models.decode_user |> pprint.debug)
// }

// fn test_search(s: swagger.Settings) {
//   let search = user.search(s, Some("naomi"), None, None, None) |> pprint.debug
//   use resp <- result.try(httpc.send(search))
//   Ok(resp.body |> pprint.debug)
// }

// fn test_get_user(s: swagger.Settings) {
//   let u = user.get_user(s, "naomi") |> pprint.debug
//   use resp <- result.try(httpc.send(u))
//   Ok(resp.body |> models.decode_user |> pprint.debug)
// }
pub fn main() {
  startest.default_config()
  |> config.with_reporters([dot.new()])
  |> startest.run
}
