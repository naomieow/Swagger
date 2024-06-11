pub type Settings {
  Settings(
    host: String
  )
}

pub fn new() -> Settings {
  Settings(host: "codeberg.org")
}

pub fn with_hostname(settings: Settings, url host: String) -> Settings {
  Settings(..settings, host: host)
}