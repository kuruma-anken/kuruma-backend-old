defmodule KurumaWeb.Api.Resolvers.SessionResolvers do
  alias Kuruma.Users
  alias Kuruma.Users.User
  alias Kuruma.Token

  def sign_in(%{email: email, password: password}, _) do
    case Users.authenticate_user_by_email_password(email, password) do
      {:ok, %User{} = user} ->
        {:ok,
         %{success: true, data: %{user: user, access_token: Token.issue_token_for_user(user)}}}

      _ ->
        {:ok, %{success: false, errors: %{"message" => "您所輸入的電子郵件或密碼有誤。"}}}
    end
  end

  def sign_out(_, _) do
    {:ok, %{success: true, user_signed_out: true, user: nil}}
  end
end
