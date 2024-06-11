import gleam/bool
import gleam/dynamic.{bool, field, int, string}
import gleam/http
import gleam/http/request.{type Request}
import gleam/int
import gleam/json
import gleam/option.{type Option}
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

fn user_from_json(json_string: String) -> Result(User, json.DecodeError) {
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

pub fn get_authed_user() -> Nil {
  todo
}

pub fn get_authed_runner_registration_token() -> Nil {
  todo
}

pub fn get_authed_oauth2_applications(
  page page: Option(Int),
  limit limit: Option(Int),
) -> Nil {
  todo
}

pub fn get_authed_oauth2_application_by_id(id id: Int) -> Nil {
  todo
}

pub fn get_authed_emails() -> Nil {
  todo
}

pub fn get_authed_followers(
  page page: Option(Int),
  limit limit: Option(Int),
) -> Nil {
  todo
}

pub fn get_authed_following(
  page page: Option(Int),
  limit limit: Option(Int),
) -> Nil {
  todo
}

pub fn get_authed_is_following(username username: String) -> Nil {
  todo
}

pub fn get_authed_gpg_key_token() -> Nil {
  todo
}

pub fn get_authed_gpg_keys(
  page page: Option(Int),
  limit limit: Option(Int),
) -> Nil {
  todo
}

pub fn get_authed_gpg_key_by_id(id id: Int) -> Nil {
  todo
}

pub fn get_authed_hooks(page page: Option(Int), limit limit: Option(Int)) -> Nil {
  todo
}

pub fn get_authed_hook_by_id(id id: Int) -> Nil {
  todo
}

pub fn get_authed_keys(
  fingerprint fingerprint: Option(String),
  page page: Option(Int),
  limit limit: Option(Int),
) -> Nil {
  todo
}

pub fn get_authed_key_by_id(id id: Int) -> Nil {
  todo
}

pub fn get_authed_blocked_users(
  page page: Option(Int),
  limit limit: Option(Int),
) -> Nil {
  todo
}

pub fn get_authed_repositories(
  page page: Option(Int),
  limit limit: Option(Int),
) -> Nil {
  todo
}

pub fn get_authed_settings() -> Nil {
  todo
}

pub fn get_authed_starred(
  page page: Option(Int),
  limit limit: Option(Int),
) -> Nil {
  todo
}

pub fn get_authed_is_starred(owner: String, repo repository: String) -> Nil {
  todo
}

pub fn get_authed_stopwatches(
  page page: Option(Int),
  limit limit: Option(Int),
) -> Nil {
  todo
}

pub fn get_authed_subscriptions(
  page page: Option(Int),
  limit limit: Option(Int),
) -> Nil {
  todo
}

pub fn get_authed_teams(page page: Option(Int), limit limit: Option(Int)) -> Nil {
  todo
}

pub fn get_authed_times(
  page page: Option(Int),
  limit limit: Option(Int),
  since since: Option(String),
  before before: Option(String),
) -> Nil {
  todo
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
