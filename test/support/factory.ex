defmodule Kuruma.Factory do
  use ExMachina.Ecto, repo: Kuruma.Repo

  @hashed_password Argon2.hash_pwd_salt("foobar")

  def user_factory do
    %Kuruma.Users.User{
      email: sequence(:user_email, &"user-#{&1}@example.com"),
      password_hash: @hashed_password
    }
  end
end
