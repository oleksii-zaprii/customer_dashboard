defmodule CustomerDashboard.Repo do
  use Ecto.Repo,
    otp_app: :customer_dashboard,
    adapter: Ecto.Adapters.Postgres
end
