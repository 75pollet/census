defmodule Census.Citizens.Citizen do
  use Ecto.Schema
  import Ecto.Changeset

  schema "citizens" do
    field :dob, :utc_datetime
    field :city, :string
    field :county, :string
    field :email_address, :string
    field :first_name, :string
    field :last_name, :string
    field :national_id, :string
    field :occupation, :string

    timestamps()
  end

  @doc false
  def changeset(citizen, attrs) do
    citizen
    |> cast(attrs, [
      :first_name,
      :last_name,
      :national_id,
      :county,
      :city,
      :dob,
      :occupation,
      :email_address
    ])
    |> validate_required([
      :first_name,
      :last_name,
      :national_id,
      :county,
      :city,
      :dob,
      :occupation,
      :email_address
    ])
    |> unique_constraint(:email_address)
    |> unique_constraint(:national_id)
  end
end
