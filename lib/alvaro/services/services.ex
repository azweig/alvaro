defmodule Alvaro.Services do
  @moduledoc """
  The Services context.
  """

  def auth do
    headers = [
      {"Content-Type", "application/x-www-form-urlencoded"},
    ]
    body = {:form, [
      grant_type: "client_credentials",
      scope: "api",
      client_id: "app-sharestates-7255308",
      client_secret: "0317d3b7-9d5b-4632-bff5-2c3478435a4b"
    ]}

    "https://auth.60uat.com/connect/token"
    |> HTTPoison.post(body, headers)
    |> httpoison_response_body()
    |> Poison.decode()
  end

  def get_borrower(access_token, token_type) do
    headers = [
      {"Authorization", "#{token_type} #{access_token}"}
    ]

    "https://api-orchestrator.60uat.com/borrowers/83bea73b-49f0-49a3-b174-1fb961901bd1"
    |> HTTPoison.get(headers)
    |> httpoison_response_body()
    |> Poison.decode()
  end

  defp httpoison_response_body({:ok, %HTTPoison.Response{body: body}}), do: body
end
