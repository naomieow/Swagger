import swagger
import gleam/http
import gleam/http/request.{type Request}
import swagger/internal/utils
import gleam/int

/// Returns the person actor for a user
/// 
pub fn get_person(settings settings: swagger.Settings, user_id user_id: Int) -> Request(String) {
  let user_id = int.to_string(user_id)

  let #(query, headers) = utils.auth(settings)

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/activitypub/user-id/" <> user_id)
  |> request.set_query(query)
  |> utils.with_headers(headers)
}

/// Send to the inbox
/// 
pub fn send_to_inbox(settings settings: swagger.Settings, user_id user_id: Int) -> Request(String) {
  let user_id = int.to_string(user_id)

  let #(query, headers) = utils.auth(settings)

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/activitypub/user-id/" <> user_id <> "/inbox")
  |> request.set_query(query)
  |> utils.with_headers(headers)
}