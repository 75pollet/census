defmodule Census.Repo.Migrations.CreateCitizens do
  use Ecto.Migration

  def change do
    create table(:citizens) do
      add :first_name, :string
      add :last_name, :string
      add :national_id, :string
      add :county, :string
      add :city, :string
      add :dob, :utc_datetime
      add :occupation, :string
      add :email_address, :string

      timestamps()
    end

    create unique_index(:citizens, [:email_address])
    create unique_index(:citizens, [:national_id])
  end
end
