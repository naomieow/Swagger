import gleam/http/request.{type Request}
import gleam/list
import gleam/option
import swagger.{type Settings}

pub fn with_headers(
  req: Request(String),
  headers: List(#(String, String)),
) -> Request(String) {
  let req =
    headers
    |> list.map_fold(from: req, with: fn(req, header) {
      #(req |> request.set_header(header.0, header.1), header)
    })
  req.0
}

pub fn auth(
  settings: Settings,
) -> #(List(#(String, String)), List(#(String, String))) {
  #(
    [
      settings.access_token |> option.map(fn(x) { #("access_token", x) }),
      settings.sudo_param |> option.map(fn(x) { #("sudo", x) }),
      settings.token |> option.map(fn(x) { #("token", x) }),
    ]
      |> option.values,
    [
      settings.authorization_header_token
        |> option.map(fn(x) { #("authorization", x) }),
      settings.sudo_header |> option.map(fn(x) { #("sudo", x) }),
      settings.totp_header |> option.map(fn(x) { #("x-forgejo-otp", x) }),
    ]
      |> option.values,
  )
}
