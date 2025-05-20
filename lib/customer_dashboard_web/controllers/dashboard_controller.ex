defmodule CustomerDashboardWeb.DashboardController do
  use CustomerDashboardWeb, :controller

  alias CustomerDashboard.Applications

  def index(conn, _params) do
    user = conn.assigns.current_user
    applications = Applications.list_user_applications(user.id)

    render(conn, :index, applications: applications)
  end
end
