defmodule Census.Citizens do
  @moduledoc """
  The Citizens context.
  """

  import Ecto.Query, warn: false
  alias Census.Repo

  alias Census.Citizens.Citizen

  @doc """
  Returns the list of citizens.

  ## Examples

      iex> list_citizens()
      [%Citizen{}, ...]

  """
  def list_citizens do
    Repo.all(Citizen)
  end

  @doc """
  Gets a single citizen.

  Raises `Ecto.NoResultsError` if the Citizen does not exist.

  ## Examples

      iex> get_citizen!(123)
      %Citizen{}

      iex> get_citizen!(456)
      ** (Ecto.NoResultsError)

  """
  def get_citizen!(id), do: Repo.get!(Citizen, id)

  @doc """
  Creates a citizen.

  ## Examples

      iex> create_citizen(%{field: value})
      {:ok, %Citizen{}}

      iex> create_citizen(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_citizen(attrs \\ %{}) do
    %Citizen{}
    |> Citizen.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a citizen.

  ## Examples

      iex> update_citizen(citizen, %{field: new_value})
      {:ok, %Citizen{}}

      iex> update_citizen(citizen, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_citizen(%Citizen{} = citizen, attrs) do
    citizen
    |> Citizen.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a citizen.

  ## Examples

      iex> delete_citizen(citizen)
      {:ok, %Citizen{}}

      iex> delete_citizen(citizen)
      {:error, %Ecto.Changeset{}}

  """
  def delete_citizen(%Citizen{} = citizen) do
    Repo.delete(citizen)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking citizen changes.

  ## Examples

      iex> change_citizen(citizen)
      %Ecto.Changeset{data: %Citizen{}}

  """
  def change_citizen(%Citizen{} = citizen, attrs \\ %{}) do
    Citizen.changeset(citizen, attrs)
  end
end
