defmodule CensusWeb.CitizenLiveTest do
  use CensusWeb.ConnCase

  import Phoenix.LiveViewTest
  import Census.CitizensFixtures

  @create_attrs %{
    dob: %{day: 21, hour: 10, minute: 25, month: 8, year: 2022},
    city: "some city",
    county: "some county",
    email_address: "some email_address",
    first_name: "some first_name",
    last_name: "some last_name",
    national_id: "some national_id",
    occupation: "some occupation"
  }
  @update_attrs %{
    dob: %{day: 22, hour: 10, minute: 25, month: 8, year: 2022},
    city: "some updated city",
    county: "some updated county",
    email_address: "some updated email_address",
    first_name: "some updated first_name",
    last_name: "some updated last_name",
    national_id: "some updated national_id",
    occupation: "some updated occupation"
  }
  @invalid_attrs %{
    dob: %{day: 30, hour: 10, minute: 25, month: 2, year: 2022},
    city: nil,
    county: nil,
    email_address: nil,
    first_name: nil,
    last_name: nil,
    national_id: nil,
    occupation: nil
  }

  defp create_citizen(_) do
    citizen = citizen_fixture()
    %{citizen: citizen}
  end

  describe "Index" do
    setup [:create_citizen]

    test "lists all citizens", %{conn: conn, citizen: citizen} do
      {:ok, _index_live, html} = live(conn, Routes.citizen_index_path(conn, :index))

      assert html =~ "Listing Citizens"
      assert html =~ citizen.city
    end

    test "saves new citizen", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.citizen_index_path(conn, :index))

      assert index_live |> element("a", "New Citizen") |> render_click() =~
               "New Citizen"

      assert_patch(index_live, Routes.citizen_index_path(conn, :new))

      assert index_live
             |> form("#citizen-form", citizen: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#citizen-form", citizen: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.citizen_index_path(conn, :index))

      assert html =~ "Citizen created successfully"
      assert html =~ "some city"
    end

    test "updates citizen in listing", %{conn: conn, citizen: citizen} do
      {:ok, index_live, _html} = live(conn, Routes.citizen_index_path(conn, :index))

      assert index_live |> element("#citizen-#{citizen.id} a", "Edit") |> render_click() =~
               "Edit Citizen"

      assert_patch(index_live, Routes.citizen_index_path(conn, :edit, citizen))

      assert index_live
             |> form("#citizen-form", citizen: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#citizen-form", citizen: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.citizen_index_path(conn, :index))

      assert html =~ "Citizen updated successfully"
      assert html =~ "some updated city"
    end

    test "deletes citizen in listing", %{conn: conn, citizen: citizen} do
      {:ok, index_live, _html} = live(conn, Routes.citizen_index_path(conn, :index))

      assert index_live |> element("#citizen-#{citizen.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#citizen-#{citizen.id}")
    end
  end

  describe "Show" do
    setup [:create_citizen]

    test "displays citizen", %{conn: conn, citizen: citizen} do
      {:ok, _show_live, html} = live(conn, Routes.citizen_show_path(conn, :show, citizen))

      assert html =~ "Show Citizen"
      assert html =~ citizen.city
    end

    test "updates citizen within modal", %{conn: conn, citizen: citizen} do
      {:ok, show_live, _html} = live(conn, Routes.citizen_show_path(conn, :show, citizen))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Citizen"

      assert_patch(show_live, Routes.citizen_show_path(conn, :edit, citizen))

      assert show_live
             |> form("#citizen-form", citizen: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#citizen-form", citizen: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.citizen_show_path(conn, :show, citizen))

      assert html =~ "Citizen updated successfully"
      assert html =~ "some updated city"
    end
  end
end
