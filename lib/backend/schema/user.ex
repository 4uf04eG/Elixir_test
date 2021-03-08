defmodule Backend.Logic.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Backend.Repo
  alias Backend.Logic.AuthToken

  schema "user" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :login, :string
    field :middle_name, :string
    field :password, :string
    has_many :tokens, AuthToken

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :middle_name, :email, :login, :password])
    |> validate_required([:first_name, :last_name, :email, :login, :password])
    |> unique_constraint(:login, downcase: true)
    |> hash_password()
  end

  alias Backend.Authenticator
  alias Backend.Logic.User
  alias Comeonin.Bcrypt

  def sign_in(login, password) do
    case Bcrypt.check_pass(Repo.get_by(User, login: login), password, hash_key: :password) do
      {:ok, user} ->
        token = Authenticator.generate_token(user)
        Repo.insert(Ecto.build_assoc(user, :tokens, %{token: token}))
      err -> err
    end
  end

  def sign_out(conn) do
    case Authenticator.get_auth_token(conn) do
      {:ok, token} ->
        case Repo.get_by(AuthToken, %{token: token}) do
          nil -> {:error, :not_found}
          auth_token -> Repo.delete(auth_token)
        end
      error -> error
    end
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{
        valid?: true,
        changes: %{
          password: pass
        }
      } ->
        put_change(changeset, :password, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
