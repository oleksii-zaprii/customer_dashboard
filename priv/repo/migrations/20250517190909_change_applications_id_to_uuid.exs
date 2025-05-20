defmodule CustomerDashboard.Repo.Migrations.ChangeApplicationsIdToUuid do
  use Ecto.Migration

  def up do
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\""

    alter table(:applications) do
      add :uuid_id, :binary_id, null: false, default: fragment("uuid_generate_v4()")
    end

    create unique_index(:applications, [:uuid_id])

    execute "ALTER TABLE applications DROP CONSTRAINT applications_pkey"
    execute "ALTER TABLE applications ADD PRIMARY KEY (uuid_id)"

    alter table(:applications) do
      remove :id
    end

    rename table(:applications), :uuid_id, to: :id
  end

  def down do
    alter table(:applications) do
      add :int_id, :serial, primary_key: true
    end

    rename table(:applications), :id, to: :uuid_id
    execute "ALTER TABLE applications DROP CONSTRAINT applications_pkey"
    execute "ALTER TABLE applications ADD PRIMARY KEY (int_id)"
    rename table(:applications), :int_id, to: :id

    alter table(:applications) do
      remove :uuid_id
    end
  end
end
