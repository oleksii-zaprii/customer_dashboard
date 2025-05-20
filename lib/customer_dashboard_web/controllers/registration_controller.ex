defmodule CustomerDashboardWeb.RegistrationController do
  use CustomerDashboardWeb, :controller

  alias CustomerDashboard.Accounts
  alias CustomerDashboard.Applications
  alias CustomerDashboardWeb.UserAuth

  plug :get_application when action in [:show, :update]

  def redirect_to_page_one(conn, _params) do
    redirect(conn, to: "/register/page-1")
  end

  def show(conn, _params) do
    application = conn.assigns.application

    page_number =
      case conn.path_info do
        [_, "page-" <> page] -> String.to_integer(page)
        # default fallback
        _ -> 1
      end

    changeset = Applications.change_application_page(page_number, application)

    render(conn, :page,
      application: application,
      changeset: changeset,
      page: page_number,
      page_title: "Registration - Step #{page_number} of 9"
    )
  end

  def update(conn, %{"page" => page, "application" => application_params}) do
    application = conn.assigns.application
    page_number = String.to_integer(page)

    if page_number === 8 do
      conn
      |> put_session(:new_user_email, application.email)
      |> put_session(:new_user_password, application_params["password"])
      |> redirect(to: ~p"/register/page-#{page_number + 1}")
    else
      update_function = get_update_function(page_number)

      case apply(Applications, update_function, [application, application_params]) do
        {:ok, _application} ->
          redirect_to_next_page(conn, application, page_number)

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, :page,
            application: application,
            changeset: changeset,
            page: page_number,
            page_title: "Registration - Step #{page_number} of 9"
          )
      end
    end
  end

  defp redirect_to_next_page(conn, application, page_number) do
    if page_number === 9 do
      user_attrs = %{
        email: get_session(conn, :new_user_email),
        password: get_session(conn, :new_user_password)
      }

      case Accounts.create_user_and_complete_application(application, user_attrs) do
        {:ok, {user, _application}} ->
          conn
          |> UserAuth.log_in_user(user)
          |> put_flash(:info, "Application submitted successfully!")
          |> redirect(to: ~p"/dashboard")

        {:error, changeset} ->
          conn
          |> put_flash(:error, "Something wend wrong")
          |> render(:page,
            application: application,
            changeset: changeset,
            page: 9,
            page_title: "Registration - Step 9 of 9"
          )
      end
    else
      redirect(conn, to: ~p"/register/page-#{page_number + 1}")
    end
  end

  defp get_update_function(page_number) do
    case page_number do
      1 -> :update_application_page_1
      2 -> :update_application_page_2
      3 -> :update_application_page_3
      4 -> :update_application_page_4
      5 -> :update_application_page_5
      6 -> :update_application_page_6
      7 -> :update_application_page_7
      9 -> :update_application_page_9
      _ -> :update_application
    end
  end

  defp get_application(conn, _opts) do
    app_id = get_session(conn, :application_id)

    case app_id do
      nil ->
        # No application ID in session, create a new one
        {:ok, application} = Applications.create_application()

        conn
        |> put_session(:application_id, application.id)
        |> assign(:application, application)

      id ->
        # Application ID exists in session, try to load it
        try do
          application = Applications.get_application!(id)
          assign(conn, :application, application)
        rescue
          Ecto.NoResultsError ->
            # Application doesn't exist anymore, create a new one
            {:ok, application} = Applications.create_application()

            conn
            |> put_session(:application_id, application.id)
            |> assign(:application, application)
        end
    end
  end
end
