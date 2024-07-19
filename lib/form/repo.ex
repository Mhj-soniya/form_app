defmodule Form.Repo do
  use Ecto.Repo,
    otp_app: :form,
    adapter: Ecto.Adapters.Postgres
end
