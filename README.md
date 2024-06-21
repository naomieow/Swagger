# swagger

[![Package Version](https://img.shields.io/hexpm/v/swagger)](https://hex.pm/packages/swagger)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/swagger/)

```sh
gleam add swagger
```
```gleam
import swagger
import swagger/users
import gleam/httpc
import gleam/io

pub fn main() {
  let s = swagger.new()
    |> swagger.with_hostname("codeberg.org")
  
  let u = s |> users.get_user("naomi")
  use resp <- result.try(httpc.send(u))
  Ok(resp.body |> models.decode_user) |> io.debug
}
```

Further documentation can be found at <https://hexdocs.pm/swagger>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```
