defmodule CustomerDashboardWeb.DashboardHTML do
  use CustomerDashboardWeb, :html

  embed_templates "dashboard_html/*"

  def status_color(status) do
    case status do
      "submitted" -> "px-2 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-800"
      "incomplete" -> "px-2 py-1 text-xs font-semibold rounded-full bg-yellow-100 text-yellow-800"
      "approved" -> "px-2 py-1 text-xs font-semibold rounded-full bg-blue-100 text-blue-800"
      "rejected" -> "px-2 py-1 text-xs font-semibold rounded-full bg-red-100 text-red-800"
      _ -> "px-2 py-1 text-xs font-semibold rounded-full bg-gray-100 text-gray-800"
    end
  end
end
