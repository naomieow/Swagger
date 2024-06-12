import gleam/bool
import gleam/dynamic.{bool, field, int, string}
import gleam/http
import gleam/http/request.{type Request}
import gleam/int
import gleam/json
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/string
import swagger/internal/decoders
import swagger/settings.{type Settings}

pub type User {
  User(
    active: Bool,
    avatar_url: String,
    created: String,
    description: String,
    email: String,
    followers_count: Int,
    following_count: Int,
    full_name: String,
    id: Int,
    is_admin: Bool,
    language: String,
    last_login: String,
    // date-time
    location: String,
    login: String,
    login_name: String,
    prohibit_login: Bool,
    pronouns: String,
    restricted: Bool,
    starred_repos_count: Int,
    visibility: String,
    website: String,
  )
}

fn with_headers(
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

fn auth(
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

pub fn get_authed_user(settings settings: Settings) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user")
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn get_authed_runner_registration_token(
  settings settings: Settings,
) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/actions/runners/registration-token")
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn get_authed_oauth2_applications(
  settings settings: Settings,
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let #(query, headers) = auth(settings)
  let query =
    [
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
      ..query
      |> list.map(fn(x) { Some(x) })
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/applications/oauth2")
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn get_authed_oauth2_application_by_id(
  settings settings: Settings,
  id id: Int,
) -> Request(String) {
  let id = id |> int.to_string

  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/applications/oauth2/" <> id)
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn get_authed_emails(settings settings: Settings) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/emails")
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn get_authed_followers(
  settings settings: Settings,
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let #(query, headers) = auth(settings)
  let query =
    [
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
      ..query
      |> list.map(fn(x) { Some(x) })
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/followers")
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn get_authed_following(
  settings settings: Settings,
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let #(query, headers) = auth(settings)
  let query =
    [
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
      ..query
      |> list.map(fn(x) { Some(x) })
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/following")
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn get_authed_is_following(
  settings settings: Settings,
  username username: String,
) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/following/" <> username)
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn get_authed_gpg_key_token(settings settings: Settings) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/gpg_key_token")
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn get_authed_gpg_keys(
  settings settings: Settings,
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let #(query, headers) = auth(settings)
  let query =
    [
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
      ..query
      |> list.map(fn(x) { Some(x) })
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/gpg_keys")
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn get_authed_gpg_key_by_id(
  settings settings: Settings,
  id id: Int,
) -> Request(String) {
  let id = id |> int.to_string

  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/gpg_keys/" <> id)
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn get_authed_hooks(
  settings settings: Settings,
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let #(query, headers) = auth(settings)
  let query =
    [
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
      ..query
      |> list.map(fn(x) { Some(x) })
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/hooks")
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn get_authed_hook_by_id(
  settings settings: Settings,
  id id: Int,
) -> Request(String) {
  let id = id |> int.to_string

  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/hooks/" <> id)
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn get_authed_keys(
  settings settings: Settings,
  fingerprint fingerprint: Option(String),
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let #(query, headers) = auth(settings)
  let query =
    [
      fingerprint |> option.map(fn(x) { #("fingerprint", x) }),
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
      ..query
      |> list.map(fn(x) { Some(x) })
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/keys")
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn get_authed_key_by_id(
  settings settings: Settings,
  fingerprint fingerprint: Option(String),
  id id: Int,
) -> Request(String) {
  let id = id |> int.to_string

  let #(query, headers) = auth(settings)
  let query =
    [
      fingerprint |> option.map(fn(x) { #("fingerprint", x) }),
      ..query
      |> list.map(fn(x) { Some(x) })
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/keys/" <> id)
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn get_authed_blocked_users(
  settings settings: Settings,
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let #(query, headers) = auth(settings)
  let query =
    [
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
      ..query
      |> list.map(fn(x) { Some(x) })
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/list_blocked")
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn get_authed_repositories(
  settings settings: Settings,
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let #(query, headers) = auth(settings)
  let query =
    [
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
      ..query
      |> list.map(fn(x) { Some(x) })
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/repos")
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn get_authed_settings(settings settings: Settings) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/settings")
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn get_authed_starred(
  settings settings: Settings,
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let #(query, headers) = auth(settings)
  let query =
    [
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
      ..query
      |> list.map(fn(x) { Some(x) })
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/starred")
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn get_authed_is_starred(settings settings: Settings, owner owner: String, repo repository: String) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/starred/" <> owner <> "/" <> repository)
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn get_authed_stopwatches(
  settings settings: Settings,
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let #(query, headers) = auth(settings)
  let query =
    [
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
      ..query
      |> list.map(fn(x) { Some(x) })
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/stopwatches")
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn get_authed_subscriptions(
  settings settings: Settings,
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let #(query, headers) = auth(settings)
  let query =
    [
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
      ..query
      |> list.map(fn(x) { Some(x) })
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/subscriptions")
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn get_authed_teams(
  settings settings: Settings,
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let #(query, headers) = auth(settings)
  let query =
    [
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
      ..query
      |> list.map(fn(x) { Some(x) })
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/teams")
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn get_authed_times(
  settings settings: Settings,
  page page: Option(Int),
  limit limit: Option(Int),
  since since: Option(String),
  before before: Option(String),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let #(query, headers) = auth(settings)
  let query =
    [
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
      since |> option.map(fn(x) { #("since", x) }),
      before |> option.map(fn(x) { #("before", x) }),
      ..query
      |> list.map(fn(x) { Some(x) })
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/teams")
  |> request.set_query(query)
  |> with_headers(headers)
}

pub fn search(
  settings settings: Settings,
  query q: Option(String),
  uid uid: Option(Int),
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let uid = uid |> option.map(int.to_string)
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let query =
    [
      q |> option.map(fn(x) { #("q", x) }),
      uid |> option.map(fn(x) { #("uid", x) }),
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/users/search")
  |> request.set_query(query)
}

pub fn get_user(
  settings settings: Settings,
  username username: String,
) -> Request(String) {
  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/users/" <> username)
}

pub fn get_activity_feeds(
  settings settings: Settings,
  username username: String,
  only_performed_by only: Option(Bool),
  date date: Option(String),
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let only = only |> option.map(bool.to_string) |> option.map(string.lowercase)
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let query =
    [
      only |> option.map(fn(x) { #("only-performed-by", x) }),
      date |> option.map(fn(x) { #("date", x) }),
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/users/" <> username <> "/activities/feeds")
  |> request.set_query(query)
}

pub fn get_followers(
  settings settings: Settings,
  username username: String,
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let query =
    [
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/users/" <> username <> "/followers")
  |> request.set_query(query)
}

pub fn get_following(
  settings settings: Settings,
  username username: String,
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let query =
    [
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/users/" <> username <> "/following")
  |> request.set_query(query)
}

pub fn get_is_following(
  settings settings: Settings,
  username username: String,
  target target: String,
) -> Request(String) {
  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/users/" <> username <> "/following/" <> target)
}

pub fn get_gpg_keys(
  settings settings: Settings,
  username username: String,
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let query =
    [
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/users/" <> username <> "/gpg_keys")
  |> request.set_query(query)
}

pub fn get_heatmap(
  settings settings: Settings,
  username username: String,
) -> Request(String) {
  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/users/" <> username <> "/heatmap")
}

pub fn get_keys(
  settings settings: Settings,
  username username: String,
  fingerprint fingerprint: Option(String),
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let query =
    [
      fingerprint |> option.map(fn(x) { #("fingerprint", x) }),
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/users/" <> username <> "/keys")
  |> request.set_query(query)
}

pub fn get_repos(
  settings settings: Settings,
  username username: String,
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let query =
    [
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/users/" <> username <> "/repos")
  |> request.set_query(query)
}

pub fn get_starred(
  settings settings: Settings,
  username username: String,
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let query =
    [
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/users/" <> username <> "/starred")
  |> request.set_query(query)
}

pub fn get_subscriptions(
  settings settings: Settings,
  username username: String,
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let query =
    [
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/users/" <> username <> "/subscriptions")
  |> request.set_query(query)
}

pub fn get_tokens(
  settings settings: Settings,
  username username: String,
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let query =
    [
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/users/" <> username <> "/tokens")
  |> request.set_query(query)
}

pub fn decode_user_response(
  json_string: String,
) -> Result(User, json.DecodeError) {
  let decoder =
    decoders.decode21(
      User,
      field("active", bool),
      field("avatar_url", string),
      field("created", string),
      field("description", string),
      field("email", string),
      field("followers_count", int),
      field("following_count", int),
      field("full_name", string),
      field("id", int),
      field("is_admin", bool),
      field("language", string),
      field("last_login", string),
      field("location", string),
      field("login", string),
      field("login_name", string),
      field("prohibit_login", bool),
      field("pronouns", string),
      field("restricted", bool),
      field("starred_repos_count", int),
      field("visibility", string),
      field("website", string),
    )
  json.decode(from: json_string, using: decoder)
}
