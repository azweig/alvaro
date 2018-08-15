defmodule Alvaro.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Alvaro.Repo

  alias Alvaro.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def auth do
    headers = [
      {"Content-Type", "application/x-www-form-urlencoded"},
    ]
    body = {:form, [grant_type: "client_credentials",
    scope: "api",
    client_id: "app-sharestates-7255308",
    client_secret: "0317d3b7-9d5b-4632-bff5-2c3478435a4b"]}

    {:ok, %HTTPoison.Response{body: body}}= HTTPoison.post "https://auth.60uat.com/connect/token", body, headers
    Poison.decode body
  end

  def get_borrower(access_token, token_type) do
    IO.inspect("\(token_type) \(access_token)")
    %HTTPoison.Response{body: body} = HTTPoison.get! "https://api-orchestrator.60uat.com/borrowers/83bea73b-49f0-49a3-b174-1fb961901bd1", [{"Authorization", "#{token_type} #{access_token}"}]
    Poison.decode(body)
  end
end
