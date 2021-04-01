defmodule Kuruma.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @required ~w(email first_name last_name)a
  @cast @required ++ ~w(password password_confirmation)a

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password_hash, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @cast)
    |> validate_required(@required)
    |> EmailTldValidator.Ecto.validate_email()
    |> unique_constraint(:email, message: "此電子信箱已被使用")
    |> encrypt_password()
    |> validate_confirmation(:password, message: "與設定密碼輸入不相符")
    |> validate_format(
      :password,
      ~r/^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,100}$/,
      message: "密碼應至少包含一個大寫字母、一個小寫字母與一個數字。"
    )
  end

  def registration_changeset(user, attrs) do
    changeset(user, attrs)
    |> validate_required(:password)
  end

  defp encrypt_password(%{valid?: true} = changeset) do
    case get_change(changeset, :password) do
      nil ->
        changeset

      password ->
        change(changeset, Argon2.add_hash(password))
    end
  end

  defp encrypt_password(changeset), do: changeset
end
