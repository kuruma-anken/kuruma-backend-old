defmodule KurumaWeb.Api.SessionMutotionsTest do
  use KurumaWeb.ApiCase

  @mutation """
  mutation SignIn($email: String!, $password: String!) {
    signIn(email: $email, password: $password) {
      success
      errors
      data {
        user {
          id
        }
        accessToken
      }
    }
  }
  """

  describe "signIn mutation" do

    test "returns success, user, and accessToken when called with valid params" do
      user = insert(:user)
      vars = %{email: user.email, password: "foobar"}

      assert %{"signIn" => %{"success" => true, "data" => actual}} = mutate(@mutation, vars)
    end
  end
end
