defmodule KidseeApi.Repo do
  use Ecto.Repo, otp_app: :kidsee_api
  use Scrivener, page_size: 20

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end

  def preload_schema(schema, type \\ nil) do
    case type do
      nil -> apply(schema, :preload, [schema])
      _   -> apply(schema, :preload, [schema, type])
    end
  end
end
