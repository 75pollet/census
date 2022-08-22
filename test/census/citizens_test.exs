defmodule Census.CitizensTest do
  use Census.DataCase

  alias Census.Citizens

  describe "citizens" do
    alias Census.Citizens.Citizen

    import Census.CitizensFixtures

    @invalid_attrs %{dob: nil, city: nil, county: nil, email_address: nil, first_name: nil, last_name: nil, national_id: nil, occupation: nil}

    test "list_citizens/0 returns all citizens" do
      citizen = citizen_fixture()
      assert Citizens.list_citizens() == [citizen]
    end

    test "get_citizen!/1 returns the citizen with given id" do
      citizen = citizen_fixture()
      assert Citizens.get_citizen!(citizen.id) == citizen
    end

    test "create_citizen/1 with valid data creates a citizen" do
      valid_attrs = %{dob: ~U[2022-08-21 10:25:00Z], city: "some city", county: "some county", email_address: "some email_address", first_name: "some first_name", last_name: "some last_name", national_id: "some national_id", occupation: "some occupation"}

      assert {:ok, %Citizen{} = citizen} = Citizens.create_citizen(valid_attrs)
      assert citizen.dob == ~U[2022-08-21 10:25:00Z]
      assert citizen.city == "some city"
      assert citizen.county == "some county"
      assert citizen.email_address == "some email_address"
      assert citizen.first_name == "some first_name"
      assert citizen.last_name == "some last_name"
      assert citizen.national_id == "some national_id"
      assert citizen.occupation == "some occupation"
    end

    test "create_citizen/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Citizens.create_citizen(@invalid_attrs)
    end

    test "update_citizen/2 with valid data updates the citizen" do
      citizen = citizen_fixture()
      update_attrs = %{dob: ~U[2022-08-22 10:25:00Z], city: "some updated city", county: "some updated county", email_address: "some updated email_address", first_name: "some updated first_name", last_name: "some updated last_name", national_id: "some updated national_id", occupation: "some updated occupation"}

      assert {:ok, %Citizen{} = citizen} = Citizens.update_citizen(citizen, update_attrs)
      assert citizen.dob == ~U[2022-08-22 10:25:00Z]
      assert citizen.city == "some updated city"
      assert citizen.county == "some updated county"
      assert citizen.email_address == "some updated email_address"
      assert citizen.first_name == "some updated first_name"
      assert citizen.last_name == "some updated last_name"
      assert citizen.national_id == "some updated national_id"
      assert citizen.occupation == "some updated occupation"
    end

    test "update_citizen/2 with invalid data returns error changeset" do
      citizen = citizen_fixture()
      assert {:error, %Ecto.Changeset{}} = Citizens.update_citizen(citizen, @invalid_attrs)
      assert citizen == Citizens.get_citizen!(citizen.id)
    end

    test "delete_citizen/1 deletes the citizen" do
      citizen = citizen_fixture()
      assert {:ok, %Citizen{}} = Citizens.delete_citizen(citizen)
      assert_raise Ecto.NoResultsError, fn -> Citizens.get_citizen!(citizen.id) end
    end

    test "change_citizen/1 returns a citizen changeset" do
      citizen = citizen_fixture()
      assert %Ecto.Changeset{} = Citizens.change_citizen(citizen)
    end
  end
end
