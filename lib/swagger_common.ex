defmodule SwaggerCommon do
  import PhoenixSwagger.Path
  alias PhoenixSwagger.Schema
  alias PhoenixSwagger.JsonApi
  alias PhoenixSwagger.Path.PathObject

  def content_type(path = %PathObject{}) do
    path
    |> produces("application/vnd.api+json")
    |> consumes("application/vnd.api+json")
  end

  def auth(path = %PathObject{}) do
    path
    |> parameter("Authorization", :header, :string, "JWT access token", required: true)
  end

  def validation(path = %PathObject{}) do
    path
    |> response(422, "unproccessable entity", Schema.ref(:error))
  end

  def body(path = %PathObject{}, name) do
    path
    |> parameter(name, :body, JsonApi.single(name), "#{name} attributes")
  end

  def definitions do
    use PhoenixSwagger
    %{
      error: swagger_schema do
        properties do
          title :string, "The title of the error"
          detail :string, "the full error message"
          source (Schema.new do
            properties do
              pointer :string, "the pointer to the attribute the error is from"
            end
          end)
        end
      end
    }
  end
end
