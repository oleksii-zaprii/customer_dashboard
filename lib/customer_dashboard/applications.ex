defmodule CustomerDashboard.Applications do
  @moduledoc """
  The Applications context.
  """

  import Ecto.Query, warn: false
  alias CustomerDashboard.Repo
  alias CustomerDashboard.Applications.Application

  @doc """
  Returns the list of applications.
  """
  def list_applications do
    Repo.all(Application)
  end

  @doc """
  Gets applications for a specific user.
  """
  def list_user_applications(user_id) do
    Application
    |> where([a], a.user_id == ^user_id)
    |> Repo.all()
  end

  @doc """
  Gets a single application.
  """
  def get_application!(id), do: Repo.get!(Application, id)

  @doc """
  Gets a single application for a specific user.
  """
  def get_user_application!(user_id, id) do
    Application
    |> where([a], a.user_id == ^user_id and a.id == ^id)
    |> Repo.one!()
  end

  @doc """
  Creates a blank application to start the process.
  """
  def create_application(attrs \\ %{}) do
    %Application{}
    |> Application.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates an application with page 1 data.
  """
  def update_application_page_1(application, attrs) do
    application
    |> Application.page_1_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates an application with page 2 data.
  """
  def update_application_page_2(application, attrs) do
    application
    |> Application.page_2_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates an application with page 3 data.
  """
  def update_application_page_3(application, attrs) do
    application
    |> Application.page_3_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates an application with page 4 data.
  """
  def update_application_page_4(application, attrs) do
    application
    |> Application.page_4_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates an application with page 5 data.
  """
  def update_application_page_5(application, attrs) do
    application
    |> Application.page_5_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates an application with page 6 data.
  """
  def update_application_page_6(application, attrs) do
    application
    |> Application.page_6_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates an application with page 7 data.
  """
  def update_application_page_7(application, attrs) do
    application
    |> Application.page_7_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates an application with page 9 data and marks it as submitted.
  """
  def update_application_page_9(application, attrs) do
    application
    |> Application.page_9_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes an application.
  """
  def delete_application(%Application{} = application) do
    Repo.delete(application)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking application changes.
  """
  def change_application(%Application{} = application, attrs \\ %{}) do
    Application.changeset(application, attrs)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking application changes for a specific page.
  """
  def change_application_page(page_number, %Application{} = application, attrs \\ %{}) do
    case page_number do
      1 -> Application.page_1_changeset(application, attrs)
      2 -> Application.page_2_changeset(application, attrs)
      3 -> Application.page_3_changeset(application, attrs)
      4 -> Application.page_4_changeset(application, attrs)
      5 -> Application.page_5_changeset(application, attrs)
      6 -> Application.page_6_changeset(application, attrs)
      7 -> Application.page_7_changeset(application, attrs)
      9 -> Application.page_9_changeset(application, attrs)
      _ -> Application.changeset(application, attrs)
    end
  end
end
