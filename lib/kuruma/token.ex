defmodule Kuruma.Token do
  @moduledoc """
  Interface functions for decoding and issuing JWT tokens
  compatible with APIs implemented in other languages.
  """

  use Joken.Config

  @default_secret "KoWKWJDKSpfrvescHJbB8ukPqMBEN56uAen/lfhN0ucsaZfeuu77qfT5VPC+RD/b"
  @validity 86400

  def token_config do
    default_claims(skip: [:iss, :aud, :jti, :nbf])
  end

  def signer, do: Joken.Signer.create("HS256", @default_secret)

  def sign_access_token(payload) when is_map(payload) do
    claims = Map.put_new(payload, "exp", :os.system_time(:seconds) + @validity)
    {:ok, token, _} = generate_and_sign(claims, signer())
    token
  end

  def decode_access_token(token) when is_binary(token) do
    verify_and_validate(token, signer())
  end
end
