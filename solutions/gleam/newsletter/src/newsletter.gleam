import simplifile
import gleam/list
import gleam/string
import gleam/result

pub fn read_emails(path: String) -> Result(List(String), Nil) {
  path
  |> simplifile.read()
  |> result.nil_error()
  |> result.try(fn(s) {
    s
    |> string.trim()
    |> string.split("\n")
    |> Ok()
  })
}

pub fn create_log_file(path: String) -> Result(Nil, Nil) {
  path
  |> simplifile.create_file()
  |> result.nil_error()
}

pub fn log_sent_email(path: String, email: String) -> Result(Nil, Nil) {
  simplifile.append(email <> "\n", to: path)
  |> result.nil_error()
}

pub fn send_newsletter(
  emails_path: String,
  log_path: String,
  send_email: fn(String) -> Result(Nil, Nil),
) -> Result(Nil, Nil) {
  let assert Ok(_) = create_log_file(log_path)
  let assert Ok(emails) = read_emails(emails_path)

  {
    use email <- list.each(emails)
    use _ <- result.try(send_email(email))
    let assert Ok(_) = log_sent_email(log_path, email)
  }
  Ok(Nil)
}
