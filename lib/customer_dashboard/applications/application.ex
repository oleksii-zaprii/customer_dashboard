defmodule CustomerDashboard.Applications.Application do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "applications" do
    field :status, :string
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :phone_number, :string
    field :date_of_birth, :date
    field :ssn, :string
    field :address_street1, :string
    field :address_street2, :string
    field :address_city, :string
    field :address_state, :string
    field :address_zip, :string
    field :monthly_income, :decimal
    field :income_type, :string
    field :bank_name, :string
    field :routing_number, :string
    field :account_number, :string
    field :agreed_to_terms, :boolean, default: false
    field :submitted_at, :utc_datetime

    timestamps(type: :utc_datetime)

    belongs_to :user, CustomerDashboard.Accounts.User, type: :integer
  end

  @doc false
  def changeset(application, attrs) do
    application
    |> cast(attrs, [
      :first_name,
      :last_name,
      :email,
      :phone_number,
      :date_of_birth,
      :ssn,
      :address_street1,
      :address_street2,
      :address_city,
      :address_state,
      :address_zip,
      :monthly_income,
      :income_type,
      :bank_name,
      :routing_number,
      :account_number,
      :agreed_to_terms,
      :status,
      :submitted_at,
      :user_id
    ])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:ssn, is: 9, message: "must be 9 digits")
    |> validate_format(:ssn, ~r/^\d+$/, message: "must contain only digits")
    |> validate_length(:routing_number, is: 9, message: "must be 9 digits")
    |> validate_format(:routing_number, ~r/^\d+$/, message: "must contain only digits")
  end

  def page_1_changeset(application, attrs) do
    application
    |> cast(attrs, [:first_name, :last_name])
    |> validate_required([:first_name, :last_name])
  end

  def page_2_changeset(application, attrs) do
    application
    |> cast(attrs, [:email, :phone_number])
    |> validate_required([:email, :phone_number])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
  end

  def page_3_changeset(application, attrs) do
    application
    |> cast(attrs, [:date_of_birth, :ssn])
    |> validate_required([:date_of_birth, :ssn])
    |> validate_length(:ssn, is: 9, message: "must be 9 digits")
    |> validate_format(:ssn, ~r/^\d+$/, message: "must contain only digits")
  end

  def page_4_changeset(application, attrs) do
    application
    |> cast(attrs, [
      :address_street1,
      :address_street2,
      :address_city,
      :address_state,
      :address_zip
    ])
    |> validate_required([:address_street1, :address_city, :address_state, :address_zip])
  end

  def page_5_changeset(application, attrs) do
    application
    |> cast(attrs, [:monthly_income])
    |> validate_required([:monthly_income])
    |> validate_number(:monthly_income, greater_than: 0)
  end

  def page_6_changeset(application, attrs) do
    application
    |> cast(attrs, [:income_type])
    |> validate_required([:income_type])
    |> validate_inclusion(:income_type, [
      "Employment",
      "Self-Employment",
      "Other Taxable Income",
      "Other Non-Taxable Income"
    ])
  end

  def page_7_changeset(application, attrs) do
    application
    |> cast(attrs, [:bank_name, :routing_number, :account_number])
    |> validate_required([:bank_name, :routing_number, :account_number])
    |> validate_length(:routing_number, is: 9, message: "must be 9 digits")
    |> validate_format(:routing_number, ~r/^\d+$/, message: "must contain only digits")
  end

  def page_9_changeset(application, attrs) do
    application
    |> cast(attrs, [:agreed_to_terms])
    |> validate_required([:agreed_to_terms])
    |> validate_acceptance(:agreed_to_terms)
  end

  def submit_changeset(application, attrs) do
    application
    |> cast(attrs, [:user_id])
    |> validate_required([:user_id])
    |> change(%{
      status: "submitted",
      submitted_at: DateTime.truncate(DateTime.utc_now(), :second)
    })
  end
end
