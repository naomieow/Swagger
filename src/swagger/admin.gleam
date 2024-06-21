import swagger
import gleam/http
import gleam/http/request.{type Request}
import gleam/option.{type Option, Some}
import swagger/internal/utils
import gleam/int
import gleam/list
import gleam/bool
import gleam/string
import swagger/models

/// Returns a list of all cron tasks
/// 
/// Decoder: [decode_crons](#decode_crons)
pub fn get_cron_tasks(
  settings settings: swagger.Settings, 
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let #(query, headers) = utils.auth(settings)
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
  |> request.set_path("api/v1/admin/cron")
  |> request.set_query(query)
  |> utils.with_headers(headers)
}

/// Runs a cron task
/// 
pub fn run_cron_task(
  settings settings: swagger.Settings,
  task task: String
) -> Request(String) {
  let #(query, headers) = utils.auth(settings)

  request.new()
  |> request.set_method(http.Post)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/admin/cron/" <> task)
  |> request.set_query(query)
  |> utils.with_headers(headers)
}

/// Returns a list of all emails
/// 
/// Decoder: [decode_emails](#decode_emails)
pub fn get_emails(
  settings settings: swagger.Settings, 
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let #(query, headers) = utils.auth(settings)
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
  |> request.set_path("api/v1/admin/emails")
  |> request.set_query(query)
  |> utils.with_headers(headers)
}


/// Searches all emails and returns a list of emails
/// 
/// Decoder: [decode_emails](#decode_emails)
pub fn search_emails(
  settings settings: swagger.Settings,
  query q: Option(String),
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let #(query, headers) = utils.auth(settings)
  let query =
    [
      q |> option.map(fn(x) { #("q", x) }),
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
      ..query
      |> list.map(fn(x) { Some(x) })
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/admin/emails/search")
  |> request.set_query(query)
  |> utils.with_headers(headers)
}

/// Returns a list of all system webhooks
/// 
/// Decoder: [decode_hooks](#decode_hooks)
pub fn get_hooks(
  settings settings: swagger.Settings, 
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let #(query, headers) = utils.auth(settings)
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
  |> request.set_path("api/v1/admin/hooks")
  |> request.set_query(query)
  |> utils.with_headers(headers)
}

/// Creates a webhook
/// 
/// Decoder: [decode_hook](#decode_hook)
pub fn new_hook(
  settings settings: swagger.Settings, 
  body body: models.CreateHookOption
) -> Request(String) {
  let #(query, headers) = utils.auth(settings)

  request.new()
  |> request.set_method(http.Post)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/admin/hooks")
  |> request.set_query(query)
  |> request.set_body(models.encode_create_hook_option(body))
  |> utils.with_headers(headers)
}

/// Gets a webhook
/// 
/// Decoder: [decode_hook](#decode_hook)
pub fn get_hook(
  settings settings: swagger.Settings, 
  id id: Int,
) -> Request(String) {
  let id = id |> int.to_string

  let #(query, headers) = utils.auth(settings)

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/admin/hooks/" <> id)
  |> request.set_query(query)
  |> utils.with_headers(headers)
}

/// Deletes a webhook
/// 
pub fn delete_hook(
  settings settings: swagger.Settings, 
  id id: Int,
) -> Request(String) {
  let id = id |> int.to_string

  let #(query, headers) = utils.auth(settings)

  request.new()
  |> request.set_method(http.Delete)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/admin/hooks/" <> id)
  |> request.set_query(query)
  |> utils.with_headers(headers)
}

/// Updates a webhook
/// 
/// Decoder: [decode_hook](#decode_hook)
pub fn edit_hook(
  settings settings: swagger.Settings,
  id id: Int,
  body body: models.EditHookOption
) -> Request(String) {
  let id = id |> int.to_string

  let #(query, headers) = utils.auth(settings)

  request.new()
  |> request.set_method(http.Patch)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/admin/hooks/" <> id)
  |> request.set_query(query)
  |> request.set_body(models.encode_edit_hook_option(body))
  |> utils.with_headers(headers)
}

/// Returns a list of all organizations
/// 
/// Decoder: [decode_orgs](#decode_orgs)
pub fn get_orgs(
  settings settings: swagger.Settings, 
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let #(query, headers) = utils.auth(settings)
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
  |> request.set_path("api/v1/admin/orgs")
  |> request.set_query(query)
  |> utils.with_headers(headers)
}

/// Get a global actions runner registration token
/// 
/// Decoder: [decode_reg_token](#decode_reg_token)
pub fn get_reg_token(
  settings settings: swagger.Settings,
) -> Request(String) {
  let #(query, headers) = utils.auth(settings)

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/admin/runners/registration-token")
  |> request.set_query(query)
  |> utils.with_headers(headers)
}

/// Returns a list of unadopted repositories
/// 
/// Decoder: [decode_unadopted](#decode_unadopted)
pub fn get_unadopted(
  settings settings: swagger.Settings, 
  page page: Option(Int),
  limit limit: Option(Int),
  pattern pattern: Option(String)
) -> Request(String) {
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let #(query, headers) = utils.auth(settings)
  let query =
    [
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
      pattern |> option.map(fn(x) { #("pattern", x) }),
      ..query
      |> list.map(fn(x) { Some(x) })
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/admin/unadopted")
  |> request.set_query(query)
  |> utils.with_headers(headers)
}

/// Adopt unadopted files as a repository
/// 
pub fn adopt_unadopted(
  settings settings: swagger.Settings,
  owner owner: String,
  repo repo: String,
) -> Request(String) {
  let #(query, headers) = utils.auth(settings)

  request.new()
  |> request.set_method(http.Post)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/admin/unadopted/" <> owner <> "/" <> repo)
  |> request.set_query(query)
  |> utils.with_headers(headers)
}


/// Delete unadopted files
/// 
pub fn delete_unadopted(
  settings settings: swagger.Settings,
  owner owner: String,
  repo repo: String,
) -> Request(String) {
  let #(query, headers) = utils.auth(settings)

  request.new()
  |> request.set_method(http.Delete)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/admin/unadopted/" <> owner <> "/" <> repo)
  |> request.set_query(query)
  |> utils.with_headers(headers)
}

/// Returns a list of users
/// 
/// Decoder: [decode_users](#decode_users)
pub fn search_users(
  settings settings: swagger.Settings, 
  source_id source_id: Option(Int),
  login_name login_name: Option(String),
  page page: Option(Int),
  limit limit: Option(Int),
) -> Request(String) {
  let source_id = source_id |> option.map(int.to_string)
  let page = page |> option.map(int.to_string)
  let limit = limit |> option.map(int.to_string)

  let #(query, headers) = utils.auth(settings)
  let query =
    [
      source_id |> option.map(fn(x) { #("source_id", x) }),
      login_name |> option.map(fn(x) { #("login_name", x) }),
      page |> option.map(fn(x) { #("page", x) }),
      limit |> option.map(fn(x) { #("limit", x) }),
      ..query
      |> list.map(fn(x) { Some(x) })
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Get)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/admin/users")
  |> request.set_query(query)
  |> utils.with_headers(headers)
}

/// Creates a new user
/// 
/// Decoder: [decode_user](#decode_user)
pub fn new_user(
  settings settings: swagger.Settings,
  body body: models.CreateUserOption,
) -> Request(String) {
  let #(query, headers) = utils.auth(settings)

  request.new()
  |> request.set_method(http.Post)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/admin/users")
  |> request.set_query(query)
  |> request.set_body(models.encode_create_user_option(body))
  |> utils.with_headers(headers)
}

/// Deletes a user
/// 
pub fn delete_user(
  settings settings: swagger.Settings,
  username username: String,
  purge purge: Option(Bool),
) -> Request(String) {
  let purge = purge |> option.map(bool.to_string) |> option.map(string.lowercase)

  let #(query, headers) = utils.auth(settings)
  let query =
    [
      purge |> option.map(fn(x) { #("purge", x) }),
      ..query
      |> list.map(fn(x) { Some(x) })
    ]
    |> option.values

  request.new()
  |> request.set_method(http.Delete)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/admin/users/" <> username)
  |> request.set_query(query)
  |> utils.with_headers(headers)
}


/// Updates an existing user
/// 
/// Decoder: [decode_user](#decode_user)
pub fn edit_user(
  settings settings: swagger.Settings,
  username username: String,
  body body: models.EditUserOption,
) -> Request(String) {
  let #(query, headers) = utils.auth(settings)

  request.new()
  |> request.set_method(http.Patch)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/admin/users/" <> username)
  |> request.set_query(query)
  |> request.set_body(models.encode_edit_user_option(body))
  |> utils.with_headers(headers)
}

/// Adds a public key on behalf of a user
/// 
/// Decoder: [decode_public_key](#decode_public_key)
pub fn new_public_key(
  settings settings: swagger.Settings,
  username username: String,
  body body: models.CreateKeyOption,
) -> Request(String) {
  let #(query, headers) = utils.auth(settings)

  request.new()
  |> request.set_method(http.Post)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/admin/users/" <> username <> "/keys")
  |> request.set_query(query)
  |> request.set_body(models.encode_create_key_option(body))
  |> utils.with_headers(headers)
}

/// Deletes a public key on behalf of a user
/// 
pub fn delete_public_key(
  settings settings: swagger.Settings,
  username username: String,
  id id: Int,
) -> Request(String) {
  let id = id |> int.to_string

  let #(query, headers) = utils.auth(settings)

  request.new()
  |> request.set_method(http.Delete)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/admin/users/" <> username <> "/keys/" <> id)
  |> request.set_query(query)
  |> utils.with_headers(headers)
}

/// Creates a new organization for a user
/// 
/// Decoder: [decode_organization](#decode_organization)
pub fn new_organization(
  settings settings: swagger.Settings,
  username username: String,
  organization organization: models.CreateOrgOption,
) -> Request(String) {
  let #(query, headers) = utils.auth(settings)

  request.new()
  |> request.set_method(http.Post)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/admin/users/" <> username <> "/orgs")
  |> request.set_query(query)
  |> request.set_body(models.encode_create_org_option(organization))
  |> utils.with_headers(headers)
}

/// Renames a user 
/// 
pub fn rename_user(
  settings settings: swagger.Settings,
  username username: String,
  body body: models.RenameUserOption,
) -> Request(String) {
  let #(query, headers) = utils.auth(settings)

  request.new()
  |> request.set_method(http.Post)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/admin/users/" <> username <>"/rename")
  |> request.set_query(query)
  |> request.set_body(models.encode_rename_user_option(body))
  |> utils.with_headers(headers)
}


/// Creates a new repository for a user
/// 
/// Decoder: [decode_repository](#decode_repository)
pub fn new_repository(
  settings settings: swagger.Settings,
  username username: String,
  repository repository: models.CreateRepoOption,
) -> Request(String) {
  let #(query, headers) = utils.auth(settings)

  request.new()
  |> request.set_method(http.Post)
  |> request.set_host(settings.host)
  |> request.set_path("api/v1/admin/users/" <> username <>"/repos")
  |> request.set_query(query)
  |> request.set_body(models.encode_create_repo_option(repository))
  |> utils.with_headers(headers)
}

