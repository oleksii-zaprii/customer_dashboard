defmodule CustomerDashboard.Repo.Migrations.CreateApplications do
  use Ecto.Migration

  def change do
    create table(:applications) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :phone_number, :string
      add :date_of_birth, :date
      add :ssn, :string
      add :address_street1, :string
      add :address_street2, :string
      add :address_city, :string
      add :address_state, :string
      add :address_zip, :string
      add :monthly_income, :decimal
      add :income_type, :string
      add :bank_name, :string
      add :routing_number, :string
      add :account_number, :string
      add :agreed_to_terms, :boolean, default: false, null: false
      add :status, :string
      add :submitted_at, :utc_datetime
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:applications, [:user_id])
  end
end
