import gleam/option.{type Option, None, Some}

pub type Settings {
  Settings(
    host: String,
    username: Option(String),
    password: Option(String),
    access_token: Option(String),
    authorization_header_token: Option(String),
    sudo_header: Option(String),
    sudo_param: Option(String),
    totp_header: Option(String),
    token: Option(String),
  )
}

/// Defaults the host to `codeberg.org` and everything else as `None`
pub fn new() -> Settings {
  Settings(
    host: "codeberg.org",
    username: None,
    password: None,
    access_token: None,
    authorization_header_token: None,
    sudo_header: None,
    sudo_param: None,
    totp_header: None,
    token: None,
  )
}

/// Set the hostname of the swagger `Settings`
pub fn with_hostname(settings: Settings, url host: String) -> Settings {
  Settings(..settings, host: host)
}

/// Set the username for authentication
pub fn with_username(settings: Settings, username username: String) -> Settings {
  Settings(..settings, username: Some(username))
}

/// Set the password for authentication
pub fn with_password(settings: Settings, password password: String) -> Settings {
  Settings(..settings, password: Some(password))
}

/// Set the access token for authentication - this is in a query
@deprecated("This authentication option is deprecated for removal in Gitea 1.23. use `with_auth_header_token` instead.")
pub fn with_access_token(
  settings: Settings,
  token access_token: String,
) -> Settings {
  Settings(..settings, access_token: Some(access_token))
}

/// Set the auth token for authentication - this is in the header
/// 
/// API tokens **must** be prepended with "token" followed by a space.
pub fn with_auth_header_token(
  settings: Settings,
  token authorization_header_token: String,
) -> Settings {
  Settings(
    ..settings,
    authorization_header_token: Some(authorization_header_token),
  )
}

/// Sudo API request as the user provided as the key. Admin privileges are required.
pub fn with_sudo_header(
  settings: Settings,
  sudo_header sudo_header: String,
) -> Settings {
  Settings(..settings, sudo_header: Some(sudo_header))
}

/// Sudo API request as the user provided as the key. Admin privileges are required.
pub fn with_sudo_param(
  settings: Settings,
  sudo_param sudo_param: String,
) -> Settings {
  Settings(..settings, sudo_param: Some(sudo_param))
}

/// Must be used in combination with BasicAuth (username/password) if two-factor authentication is enabled.
pub fn with_totp_header(
  settings: Settings,
  totp_header totp_header: String,
) -> Settings {
  Settings(..settings, totp_header: Some(totp_header))
}

/// Set the auth token for authentication - this is in a query
@deprecated("This authentication option is deprecated for removal in Gitea 1.23. use `with_auth_header_token` instead.")
pub fn with_auth_token(settings: Settings, token token: String) -> Settings {
  Settings(..settings, token: Some(token))
}
