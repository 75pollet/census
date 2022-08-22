defmodule Census.CitizensFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Census.Citizens` context.
  """

  @doc """
  Generate a unique citizen email_address.
  """
  def unique_citizen_email_address, do: "some email_address#{System.unique_integer([:positive])}"

  @doc """
  Generate a unique citizen national_id.
  """
  def unique_citizen_national_id, do: "some national_id#{System.unique_integer([:positive])}"

  @doc """
  Generate a citizen.
  """
  def citizen_fixture(attrs \\ %{}) do
    {:ok, citizen} =
      attrs
      |> Enum.into(%{
        dob: ~U[2022-08-21 10:25:00Z],
        city: "some city",
        county: "some county",
        email_address: unique_citizen_email_address(),
        first_name: "some first_name",
        last_name: "some last_name",
        national_id: unique_citizen_national_id(),
        occupation: "some occupation"
      })
      |> Census.Citizens.create_citizen()

    citizen
  end
end
