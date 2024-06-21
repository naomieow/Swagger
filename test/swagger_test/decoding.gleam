import gleam/dynamic.{DecodeError}
import gleam/json.{UnexpectedFormat}
import startest.{describe, it}
import startest/expect
import swagger/models

pub fn decoding_tests() {
  describe("Decoding Tests", [
    describe("Decode User", [
      it("Successful Decode", fn() {
        "{
          \"active\": true,
          \"avatar_url\": \"some url\",
          \"created\": \"2024-06-21T14:07:13.110Z\",
          \"description\": \"desc\",
          \"email\": \"user@example.com\",
          \"followers_count\": 69,
          \"following_count\": 420,
          \"full_name\": \"name\",
          \"id\": 1234,
          \"is_admin\": true,
          \"language\": \"english\",
          \"last_login\": \"2024-06-21T14:07:13.110Z\",
          \"location\": \"The Moon\",
          \"login\": \"string\",
          \"login_name\": \"wow_so_cool\",
          \"prohibit_login\": false,
          \"pronouns\": \"she/her\",
          \"restricted\": true,
          \"starred_repos_count\": 13,
          \"visibility\": \"public\",
          \"website\": \"https://lesbian.skin\"
        }
        "
        |> models.decode_user
        |> expect.to_equal(
          Ok(models.User(
            active: True,
            avatar_url: "some url",
            created: "2024-06-21T14:07:13.110Z",
            description: "desc",
            email: "user@example.com",
            followers_count: 69,
            following_count: 420,
            full_name: "name",
            id: 1234,
            is_admin: True,
            language: "english",
            last_login: "2024-06-21T14:07:13.110Z",
            location: "The Moon",
            login: "string",
            login_name: "wow_so_cool",
            prohibit_login: False,
            pronouns: "she/her",
            restricted: True,
            starred_repos_count: 13,
            visibility: "public",
            website: "https://lesbian.skin",
          )),
        )
      }),
      it("Missing Field", fn() {
        "
          {
            \"active\": true,
            \"avatar_url\": \"some url\",
            \"created\": \"2024-06-21T14:07:13.110Z\",
            \"description\": \"desc\",
            \"email\": \"user@example.com\",
            \"followers_count\": 69,
            \"following_count\": 420,
            \"full_name\": \"name\",
            \"id\": 1234,
            \"is_admin\": true,
            \"language\": \"english\",
            \"location\": \"The Moon\",
            \"login\": \"string\",
            \"login_name\": \"wow_so_cool\",
            \"prohibit_login\": false,
            \"pronouns\": \"she/her\",
            \"restricted\": true,
            \"starred_repos_count\": 13,
            \"visibility\": \"public\",
            \"website\": \"https://lesbian.skin\"
          }
        "
        |> models.decode_user
        |> expect.to_equal(
          Error(
            UnexpectedFormat([DecodeError("field", "nothing", ["last_login"])]),
          ),
        )
      }),
      it("Incorrect Type", fn() {
        "{
          \"active\": true,
          \"avatar_url\": \"some url\",
          \"created\": \"2024-06-21T14:07:13.110Z\",
          \"description\": \"desc\",
          \"email\": \"user@example.com\",
          \"followers_count\": \"69\",
          \"following_count\": 420,
          \"full_name\": \"name\",
          \"id\": 1234,
          \"is_admin\": true,
          \"language\": \"english\",
          \"last_login\": \"2024-06-21T14:07:13.110Z\",
          \"location\": \"The Moon\",
          \"login\": \"string\",
          \"login_name\": \"wow_so_cool\",
          \"prohibit_login\": false,
          \"pronouns\": \"she/her\",
          \"restricted\": true,
          \"starred_repos_count\": 13,
          \"visibility\": \"public\",
          \"website\": \"https://lesbian.skin\"
        }
        "
        |> models.decode_user
        |> expect.to_equal(
          Error(
            UnexpectedFormat([DecodeError("Int", "String", ["followers_count"])]),
          ),
        )
      }),
    ]),
    describe("Decode Registration Token", [
      it("Successful Decode", fn() {
        "{ \"token\": \"1234\" }"
        |> models.decode_registration_token
        |> expect.to_equal(Ok("1234"))
      }),
      it("Incorrect type", fn() {
        "{ \"token\": 1234 }"
        |> models.decode_registration_token
        |> expect.to_equal(
          Error(UnexpectedFormat([DecodeError("String", "Int", ["token"])])),
        )
      }),
    ]),
    describe("Decode Unadopted", [
      it("Successful Decode", fn() {
        "[ \"1234\", \"5678\", \"9012\"]"
        |> models.decode_unadopted
        |> expect.to_equal(Ok(["1234", "5678", "9012"]))
      }),
      it("Incorrect Item Type", fn() {
        "[ \"1234\", 5678, \"9012\"]"
        |> models.decode_unadopted
        |> expect.to_equal(
          Error(UnexpectedFormat([DecodeError("String", "Int", ["*"])])),
        )
      }),
      it("Incorrect Type", fn() {
        "1234"
        |> models.decode_unadopted
        |> expect.to_equal(
          Error(UnexpectedFormat([DecodeError("List", "Int", [])])),
        )
      }),
    ]),
    describe("Decode Cron", [
      it("Successful Decode", fn() {
        "
        {
          \"exec_times\": 0,
          \"name\": \"cron name 1\",
          \"next\": \"2024-06-21T14:49:05.953Z\",
          \"prev\": \"2024-06-21T14:49:05.953Z\",
          \"schedule\": \"sometime\"
        }
        "
        |> models.decode_cron
        |> expect.to_equal(
          Ok(models.Cron(
            exec_times: 0,
            name: "cron name 1",
            next: "2024-06-21T14:49:05.953Z",
            prev: "2024-06-21T14:49:05.953Z",
            schedule: "sometime",
          )),
        )
      }),
      it("Incorrect Type", fn() {
        "
        {
          \"exec_times\": \"0\",
          \"name\": \"cron name 1\",
          \"next\": \"2024-06-21T14:49:05.953Z\",
          \"prev\": \"2024-06-21T14:49:05.953Z\",
          \"schedule\": \"sometime\"
        }
        "
        |> models.decode_cron
        |> expect.to_equal(
          Error(
            UnexpectedFormat([DecodeError("Int", "String", ["exec_times"])]),
          ),
        )
      }),
    ]),
    describe("Decode Cron List", [
      it("Successful Decode", fn() {
        "
        [
          {
            \"exec_times\": 0,
            \"name\": \"cron name 1\",
            \"next\": \"2024-06-21T14:49:05.953Z\",
            \"prev\": \"2024-06-21T14:49:05.953Z\",
            \"schedule\": \"sometime\"
          },
          {
            \"exec_times\": 0,
            \"name\": \"cron name 2\",
            \"next\": \"2024-06-21T14:49:05.953Z\",
            \"prev\": \"2024-06-21T14:49:05.953Z\",
            \"schedule\": \"sometime\"
          },
          {
            \"exec_times\": 0,
            \"name\": \"cron name 3\",
            \"next\": \"2024-06-21T14:49:05.953Z\",
            \"prev\": \"2024-06-21T14:49:05.953Z\",
            \"schedule\": \"sometime\"
          }
        ]
        "
        |> models.decode_cron_list
        |> expect.to_equal(
          Ok([
            models.Cron(
              exec_times: 0,
              name: "cron name 1",
              next: "2024-06-21T14:49:05.953Z",
              prev: "2024-06-21T14:49:05.953Z",
              schedule: "sometime",
            ),
            models.Cron(
              exec_times: 0,
              name: "cron name 2",
              next: "2024-06-21T14:49:05.953Z",
              prev: "2024-06-21T14:49:05.953Z",
              schedule: "sometime",
            ),
            models.Cron(
              exec_times: 0,
              name: "cron name 3",
              next: "2024-06-21T14:49:05.953Z",
              prev: "2024-06-21T14:49:05.953Z",
              schedule: "sometime",
            ),
          ]),
        )
      }),
      it("Incorrect Type", fn() {
        "
        [
          {
            \"exec_times\": 0,
            \"name\": \"cron name 1\",
            \"next\": \"2024-06-21T14:49:05.953Z\",
            \"prev\": \"2024-06-21T14:49:05.953Z\",
            \"schedule\": \"sometime\"
          },
          \"sly and annoying type\",
          {
            \"exec_times\": 0,
            \"name\": \"cron name 3\",
            \"next\": \"2024-06-21T14:49:05.953Z\",
            \"prev\": \"2024-06-21T14:49:05.953Z\",
            \"schedule\": \"sometime\"
          }
        ]
        "
        |> models.decode_cron_list
        |> expect.to_equal(
          Error(
            UnexpectedFormat([
              DecodeError("Dict", "String", ["*"]),
              DecodeError("Dict", "String", ["*"]),
              DecodeError("Dict", "String", ["*"]),
              DecodeError("Dict", "String", ["*"]),
              DecodeError("Dict", "String", ["*"]),
            ]),
          ),
        )
      }),
    ]),
    describe("Decode Email", [
      it("Successful Decode", fn() {
        "
        {
          \"email\": \"user@example.com\",
          \"primary\": true,
          \"user_id\": 123,
          \"username\": \"user\",
          \"verified\": true
        }
        "
        |> models.decode_email
        |> expect.to_equal(
          Ok(models.Email(
            email: "user@example.com",
            primary: True,
            user_id: 123,
            username: "user",
            verified: True,
          )),
        )
      }),
      it("Incorrect Type", fn() {
        "
        {
          \"email\": \"user@example.com\",
          \"primary\": true,
          \"user_id\": \"123\",
          \"username\": \"user\",
          \"verified\": true
        }
        "
        |> models.decode_email
        |> expect.to_equal(
          Error(UnexpectedFormat([DecodeError("Int", "String", ["user_id"])])),
        )
      }),
    ]),
    describe("Decode Email List", [
      it("Successful Decode", fn() {
        "
        [
          {
            \"email\": \"user@example.com\",
            \"primary\": true,
            \"user_id\": 123,
            \"username\": \"user\",
            \"verified\": true
          },
          {
            \"email\": \"user2@example.com\",
            \"primary\": true,
            \"user_id\": 124,
            \"username\": \"user2\",
            \"verified\": true
          },
          {
            \"email\": \"user3@example.com\",
            \"primary\": true,
            \"user_id\": 125,
            \"username\": \"user3\",
            \"verified\": true
          }
        ]
        "
        |> models.decode_email_list
        |> expect.to_equal(
          Ok([
            models.Email(
              email: "user@example.com",
              primary: True,
              user_id: 123,
              username: "user",
              verified: True,
            ),
            models.Email(
              email: "user2@example.com",
              primary: True,
              user_id: 124,
              username: "user2",
              verified: True,
            ),
            models.Email(
              email: "user3@example.com",
              primary: True,
              user_id: 125,
              username: "user3",
              verified: True,
            ),
          ]),
        )
      }),
      it("Incorrect Type", fn() {
        "
        [
          {
            \"email\": \"user@example.com\",
            \"primary\": true,
            \"user_id\": 123,
            \"username\": \"user\",
            \"verified\": true
          },
          \"little annoying piece of shi-\",
          {
            \"email\": \"user3@example.com\",
            \"primary\": true,
            \"user_id\": 125,
            \"username\": \"user3\",
            \"verified\": true
          }
        ]
        "
        |> models.decode_email_list
        |> expect.to_equal(
          Error(
            UnexpectedFormat([
              DecodeError("Dict", "String", ["*"]),
              DecodeError("Dict", "String", ["*"]),
              DecodeError("Dict", "String", ["*"]),
              DecodeError("Dict", "String", ["*"]),
              DecodeError("Dict", "String", ["*"]),
            ]),
          ),
        )
      }),
    ]),
  ])
}
