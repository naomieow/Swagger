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

/// Gets the authenticated user
/// 
pub fn get_authed_user(settings settings: Settings) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user")
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Gets the authenticated user's actions runner registration token
/// 
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

/// Gets a list of the authenticated user's OAuth2 applications
/// 
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

/// Gets one of the authenticated user's OAuth2 applications by its ID
/// 
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

/// Gets a list of the authenticated user's email addresses
/// 
pub fn get_authed_emails(settings settings: Settings) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/emails")
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Gets a list of the authenticated user's followers
/// 
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

/// Gets a list of the users the authenticated user is following
/// 
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

/// Checks whether a user is followed by the authenticated user
/// 
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

/// Gets a token to verify from the authenticated user
/// 
pub fn get_authed_gpg_key_token(settings settings: Settings) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/gpg_key_token")
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Gets a list of the authenticated user's GPG keys
/// 
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

/// Gets a specific one of the authenticated user's GPG keys by ID
///
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

/// Gets a list of the authenticated user's webhooks
///
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

/// Gets a specific one of the authenticated user's webhooks by ID
///
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

/// Gets a list of the authenticated user's public keys
///
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

/// Gets a specific one of the authenticated user's public keys by ID
///
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

/// Gets a list of the authenticated user's blocked users
///
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

/// Gets a list of the authenticated user's repositories
///
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

/// Gets the authenticated user's settings
/// 
pub fn get_authed_settings(settings settings: Settings) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/settings")
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Gets a list of the authenticated user's starred repositories
///
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

/// Checks whether a repository is starred by the authenticated user
/// 
pub fn get_authed_is_starred(
  settings settings: Settings,
  owner owner: String,
  repo repository: String,
) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/starred/" <> owner <> "/" <> repository)
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Gets a list of the authenticated user's stopwatches
///
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

/// Gets a list of the authenticated user's subscriptions (watched repositories)
///
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

/// Gets a list of the authenticated user's teams that they belong to
///
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

/// Gets a list of the authenticated user's tracked times
///
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

/// Searches for users
/// 
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

/// Gets a specific user
/// 
pub fn get_user(
  settings settings: Settings,
  username username: String,
) -> Request(String) {
  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/users/" <> username)
}

/// Gets a list of a user's activity feeds
/// 
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

/// Gets a list of a user's followers
/// 
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

/// Gets a list of users the given user is following
/// 
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

/// Checks whether one user is following another
/// 
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

/// Gets a list of a user's GPG keys
/// 
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

/// Gets a given user's heatmap
/// 
pub fn get_heatmap(
  settings settings: Settings,
  username username: String,
) -> Request(String) {
  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/users/" <> username <> "/heatmap")
}

/// Gets a list of a user's public keys
/// 
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

/// Gets a list of a user's repositories
/// 
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

/// Gets a list of a user's starred repositories
/// 
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

/// Gets a list of a user's subscriptions (watched repositories)
/// 
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

/// Gets a list of an authenticated user's access tokens to a given user
/// 
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

/// Creates or Updates the specified secret for the authenticated user
///
pub fn create_or_update_secret(
  settings settings: Settings,
  name secret_name: String,
  data secret_data: String,
) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Put)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/actions/secrets/" <> secret_name)
  |> request.set_body("{\"data\":\"" <> secret_data <> " \"}")
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Deletes the specified secret for the authenticated user
/// 
pub fn delete_secret(
  settings settings: Settings,
  name secret_name: String,
) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Delete)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/actions/secrets/" <> secret_name)
  |> request.set_query(query)
  |> with_headers(headers)
}

fn create_oauth2_body(
  confidential_client confidential: Bool,
  name name: String,
  redirect_uris uris: List(String),
) -> String {
  "{\"confidential_client\":"
  <> bool.to_string(confidential) |> string.lowercase
  <> ","
  <> "\"name\":\""
  <> name
  <> "\","
  <> "\"redirect_uris\":["
  <> uris |> list.map(fn(uri) { "\"" <> uri <> "\"" }) |> string.join(",")
  <> "]}"
}

/// Creates a new oauth2 application for the authenticated user
/// 
pub fn create_new_oauth2_application(
  settings settings: Settings,
  confidential_client confidential: Bool,
  name name: String,
  redirect_uris uris: List(String),
) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Post)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/applications/oauth2")
  |> request.set_body(create_oauth2_body(confidential, name, uris))
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Deletes the specified oauth2 application for the authenticated user
/// 
pub fn delete_oauth2_application_by_id(
  settings settings: Settings,
  id id: Int,
) -> Request(String) {
  let id = id |> int.to_string

  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Delete)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/applications/oauth2/" <> id)
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Updates the specified oauth2 application for the authenticated user
/// 
pub fn update_oauth2_application(
  settings settings: Settings,
  id id: Int,
  confidential_client confidential: Bool,
  name name: String,
  redirect_uris uris: List(String),
) -> Request(String) {
  let id = id |> int.to_string

  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Patch)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/applications/oauth2/" <> id)
  |> request.set_body(create_oauth2_body(confidential, name, uris))
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Updates the authenticated user's avatar.
/// 
/// Image must be base64 encoded
/// 
pub fn update_avatar(
  settings settings: Settings,
  image image: String,
) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Post)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/avatar")
  |> request.set_body("{\"image\":\"" <> image <> "\"}")
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Deletes the authenticated user's avatar.
/// 
pub fn delete_avatar(settings settings: Settings) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Delete)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/avatar")
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Blocks the specified user from the authenticated user
/// 
pub fn block_user(
  settings settings: Settings,
  username username: String,
) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Put)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/block/" <> username)
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Adds email addresses to the authenticated user
/// 
pub fn add_emails(
  settings settings: Settings,
  emails emails: List(String),
) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Put)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/emails")
  |> request.set_body(
    "{\"emails\":["
    <> emails |> list.map(fn(uri) { "\"" <> uri <> "\"" }) |> string.join(",")
    <> "]}",
  )
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Deletes email addresses to the authenticated user
/// 
pub fn delete_emails(
  settings settings: Settings,
  emails emails: List(String),
) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Delete)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/emails")
  |> request.set_body(
    "{\"emails\":["
    <> emails |> list.map(fn(uri) { "\"" <> uri <> "\"" }) |> string.join(",")
    <> "]}",
  )
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Follows the specified user from the authenticated user
/// 
pub fn follow_user(
  settings settings: Settings,
  username username: String,
) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Put)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/following/" <> username)
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Unfollows the specified user from the authenticated user
/// 
pub fn unfollow_user(
  settings settings: Settings,
  username username: String,
) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Delete)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/following/" <> username)
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Verifies a GPG key for the authenticated user
/// 
pub fn verify_gpg_key(settings settings: Settings) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Post)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/gpg_key_verify")
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Creates a GPG key for the authenticated user
/// 
pub fn create_gpg_key(
  settings settings: Settings,
  armored_public_key armoured_public_key: String,
  armored_signature armoured_signature: String,
) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Post)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/gpg_keys")
  |> request.set_body(
    "{\"armored_public_key\":\""
    <> armoured_public_key
    <> "\",\"armored_signature\":\""
    <> armoured_signature
    <> "\"}",
  )
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Removed a specified GPG key for the authenticated user
/// 
pub fn remove_gpg_key(
  settings settings: Settings,
  id id: Int,
) -> Request(String) {
  let id = id |> int.to_string

  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Delete)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/gpg_keys/" <> id)
  |> request.set_query(query)
  |> with_headers(headers)
}

pub type HookType {
  Forgejo
  Dingtalk
  Discord
  Gitea
  Gogs
  MSTeams
  Slack
  Telegram
  Feishu
  WeChatWork
  Packagist
}

fn hook_to_string(hook_type: HookType) -> String {
  case hook_type {
    Forgejo -> "forgejo"
    Dingtalk -> "dingtalk"
    Discord -> "discord"
    Gitea -> "gitea"
    Gogs -> "gogs"
    MSTeams -> "msteams"
    Slack -> "slack"
    Telegram -> "telegram"
    Feishu -> "feishu"
    WeChatWork -> "wechatwork"
    Packagist -> "packagist"
  }
}

fn create_hook_body(
  active active: Bool,
  authorization_header authorization_header: String,
  branch_filter branch_filter: String,
  config config: List(#(String, String)),
  events events: List(String),
  hook_type hook_type: HookType,
) -> String {
  "{\"active\":"
  <> bool.to_string(active) |> string.lowercase
  <> ","
  <> "\"authorization_header\":\""
  <> authorization_header
  <> "\","
  <> "\"branch_filter\":\""
  <> branch_filter
  <> "\","
  <> "\"config\":{"
  <> config
  |> list.map(fn(prop) { "\"" <> prop.0 <> "\":" <> "\"" <> prop.1 <> "\"" })
  |> string.join(",")
  <> "},"
  <> "\"events\":["
  <> events |> list.map(fn(event) { "\"" <> event <> "\"" }) |> string.join(",")
  <> "],"
  <> "\"type\":\""
  <> hook_type |> hook_to_string
  <> "\""
  <> "}"
}

fn create_hook_body_no_type(
  active active: Bool,
  authorization_header authorization_header: String,
  branch_filter branch_filter: String,
  config config: List(#(String, String)),
  events events: List(String),
) -> String {
  "{\"active\":"
  <> bool.to_string(active) |> string.lowercase
  <> ","
  <> "\"authorization_header\":\""
  <> authorization_header
  <> "\","
  <> "\"branch_filter\":\""
  <> branch_filter
  <> "\","
  <> "\"config\":{"
  <> config
  |> list.map(fn(prop) { "\"" <> prop.0 <> "\":" <> "\"" <> prop.1 <> "\"" })
  |> string.join(",")
  <> "},"
  <> "\"events\":["
  <> events |> list.map(fn(event) { "\"" <> event <> "\"" }) |> string.join(",")
  <> "],"
  <> "}"
}

/// Creates a webhook for the authenticated user
/// 
pub fn create_hook(
  settings settings: Settings,
  active active: Bool,
  authorization_header auth_header: String,
  branch_filter filter: String,
  config config: List(#(String, String)),
  events events: List(String),
  hook_type hook_type: HookType,
) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Post)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/hooks")
  |> request.set_body(create_hook_body(
    active,
    auth_header,
    filter,
    config,
    events,
    hook_type,
  ))
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Deletes a specified webhook for the authenticated user
/// 
pub fn delete_webhook(
  settings settings: Settings,
  id id: Int,
) -> Request(String) {
  let id = id |> int.to_string

  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Delete)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/hooks/" <> id)
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Updates a webhook for the authenticated user
/// 
pub fn update_hook(
  settings settings: Settings,
  id id: Int,
  active active: Bool,
  authorization_header auth_header: String,
  branch_filter filter: String,
  config config: List(#(String, String)),
  events events: List(String),
) -> Request(String) {
  let id = id |> int.to_string

  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Patch)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/hooks/" <> id)
  |> request.set_body(create_hook_body_no_type(
    active,
    auth_header,
    filter,
    config,
    events,
  ))
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Creates a public key for the authenticated user
/// 
pub fn create_key(
  settings settings: Settings,
  key key: String,
  read_only read_only: Bool,
  title title: String,
) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Post)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/keys")
  |> request.set_body(
    "{\"key\":\""
    <> key
    <> "\","
    <> "\"read_only\":"
    <> bool.to_string(read_only) |> string.lowercase
    <> ","
    <> "\"title\":\""
    <> title
    <> "\","
    <> "}",
  )
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Deletes a public key for the authenticated user
/// 
pub fn delete_key(settings settings: Settings, id id: Int) -> Request(String) {
  let id = id |> int.to_string

  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Delete)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/keys/" <> id)
  |> request.set_query(query)
  |> with_headers(headers)
}

pub type ObjectFormatName {
  Sha1
  Sha256
}

fn ofn_to_string(ofn: ObjectFormatName) -> String {
  case ofn {
    Sha1 -> "sha1"
    Sha256 -> "sha256"
  }
}

pub type TrustModel {
  Default
  Collaborator
  Comitter
  CollaboratorCommitter
}

fn tm_to_string(tm: TrustModel) -> String {
  case tm {
    Default -> "default"
    Collaborator -> "collaborator"
    Comitter -> "comitter"
    CollaboratorCommitter -> "collaboratorcomitter"
  }
}

fn create_repo_body(
  auto_init auto_init: Bool,
  default_branch default_branch: String,
  description description: String,
  gitignores gitignores: String,
  issue_labels issue_labels: String,
  license license: String,
  name name: String,
  object_format_name object_format_name: ObjectFormatName,
  private private: Bool,
  readme readme: String,
  template template: Bool,
  trust_model trust_model: TrustModel,
) -> String {
  "{\"auto_init\":"
  <> bool.to_string(auto_init) |> string.lowercase
  <> ","
  <> "\"default_branch\":\""
  <> default_branch
  <> "\","
  <> "\"description\":\""
  <> description
  <> "\","
  <> "\"gitignores\":\""
  <> gitignores
  <> "\","
  <> "\"issue_labels\":\""
  <> issue_labels
  <> "\","
  <> "\"license\":\""
  <> license
  <> "\","
  <> "\"name\":\""
  <> name
  <> "\","
  <> "\"object_format_name\":\""
  <> object_format_name |> ofn_to_string
  <> "\","
  <> "\"private\":"
  <> bool.to_string(private) |> string.lowercase
  <> ","
  <> "\"readme\":\""
  <> readme
  <> "\","
  <> "\"template\":"
  <> bool.to_string(template) |> string.lowercase
  <> ","
  <> "\"trust_model\":\""
  <> trust_model |> tm_to_string
  <> "\""
  <> "}"
}

/// Creates a repository for the authenticated user
/// 
pub fn create_repo(
  settings settings: Settings,
  auto_init auto_init: Bool,
  default_branch default_branch: String,
  description description: String,
  gitignores gitignores: String,
  issue_labels issue_labels: String,
  license license: String,
  name name: String,
  object_format_name object_format_name: ObjectFormatName,
  private private: Bool,
  readme readme: String,
  template template: Bool,
  trust_model trust_model: TrustModel,
) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Patch)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/repos")
  |> request.set_body(create_repo_body(
    auto_init,
    default_branch,
    description,
    gitignores,
    issue_labels,
    license,
    name,
    object_format_name,
    private,
    readme,
    template,
    trust_model,
  ))
  |> request.set_query(query)
  |> with_headers(headers)
}

fn create_settings_body(
  description description: String,
  diff_view_style diff_view_style: String,
  enable_repo_unit_hints repo_hints: Bool,
  full_name full_name: String,
  hide_activity hide_activity: Bool,
  hide_email hide_email: Bool,
  language language: String,
  location location: String,
  pronouns pronouns: String,
  theme theme: String,
  website website: String,
) -> String {
  "{\"description\":\""
  <> description
  <> "\","
  <> "\"diff_view_style\":\""
  <> diff_view_style
  <> "\","
  <> "\"enable_repo_unit_hints\":"
  <> bool.to_string(repo_hints) |> string.lowercase
  <> ","
  <> "\"full_name\":\""
  <> full_name
  <> "\","
  <> "\"hide_activity\":"
  <> bool.to_string(hide_activity) |> string.lowercase
  <> ","
  <> "\"hide_email\":"
  <> bool.to_string(hide_email) |> string.lowercase
  <> ","
  <> "\"language\":\""
  <> language
  <> "\","
  <> "\"location\":\""
  <> location
  <> "\","
  <> "\"pronouns\":\""
  <> pronouns
  <> "\","
  <> "\"theme\":\""
  <> theme
  <> "\","
  <> "\"website\":\""
  <> website
  <> "}"
}

/// Updates the authenticated user's settings
/// 
pub fn update_settings(
  settings settings: Settings,
  description description: String,
  diff_view_style diff_view_style: String,
  enable_repo_unit_hints repo_hints: Bool,
  full_name full_name: String,
  hide_activity hide_activity: Bool,
  hide_email hide_email: Bool,
  language language: String,
  location location: String,
  pronouns pronouns: String,
  theme theme: String,
  website website: String,
) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Patch)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/settings")
  |> request.set_body(create_settings_body(
    description,
    diff_view_style,
    repo_hints,
    full_name,
    hide_activity,
    hide_email,
    language,
    location,
    pronouns,
    theme,
    website,
  ))
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Stars the given repo as the authenticated user
/// 
pub fn star_repository(
  settings settings: Settings,
  owner owner: String,
  repo repo: String,
) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Put)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/starred/" <> owner <> "/" <> repo)
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Unstars the given repo as the authenticated user
/// 
pub fn unstar_repository(
  settings settings: Settings,
  owner owner: String,
  repo repo: String,
) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Delete)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/starred/" <> owner <> "/" <> repo)
  |> request.set_query(query)
  |> with_headers(headers)
}


/// Unblocks the given user from the authenticated user
/// 
pub fn unblock_user(
  settings settings: Settings,
  username username: String,
) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Put)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/user/unblock/" <> username)
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Creates an access token for a given user
/// 
pub fn create_access_token(
  settings settings: Settings,
  username username: String,
  token_name name: String,
  scopes scopes: List(String),
) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Post)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/users/" <> username <> "/tokens")
  |> request.set_body(
    "{\"name\": \"" 
    <> name 
    <> "\",
    \"\": [" 
    <> scopes |> list.map(fn(scope) { "\"" <> scope <> "\"" }) |> string.join(",") 
    <> "]}"
  )
  |> request.set_query(query)
  |> with_headers(headers)
}

/// Deletes an access token for a given user
/// 
pub fn delete_access_token(
  settings settings: Settings,
  username username: String,
  token token: String,
) -> Request(String) {
  let #(query, headers) = auth(settings)

  request.new()
  |> request.set_method(http.Delete)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/users/" <> username <> "/tokens/" <> token)
  |> request.set_query(query)
  |> with_headers(headers)
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
