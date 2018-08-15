defmodule AlvaroWeb.TwitterController do
  use AlvaroWeb, :controller

  def index(conn, _params) do
    with {:ok, %{"access_token" => access_token, "token_type" => token_type}} <- Alvaro.Accounts.auth(),
         {:ok, response} <- Alvaro.Accounts.get_borrower(access_token, token_type)
    do
      conn
      |> put_status(200)
      |> json(response)
    else
      _ ->
        conn
        |> put_status(500)
        |> text "ERROR"
    end
  end
end
