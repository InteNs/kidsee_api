defmodule KidseeApiWeb.ContentTypeControllerTest do
  use KidseeApiWeb.ConnCase do
    import KidseeApi.ContentTypeFactory
  end
  describe "index" do
    test "lists all content_types", %{conn: conn} do
      conn = get(conn, content_type_path(conn, :index))
      assert json_response(conn, 200)
    end
  end

  describe "create" do
    test "renders content_type when data is valid", %{conn: conn} do
      conn_create = post conn, content_type_path(conn, :create), build(:jsonapi_content_type)
      assert %{"id" => id} = json_response(conn_create, 201)["data"]

      conn_get = get conn, content_type_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, content_type_path(conn, :create), json_api_params_for(:invalid_content_type)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update" do
    setup do [content_type: insert(:content_type)] end

    test "renders content_type when data is valid", %{conn: conn, content_type: content_type} do
      conn_patch = patch conn, content_type_path(conn, :update, content_type), build(:jsonapi_content_type)
      assert %{"id" => id} = json_response(conn_patch, 200)["data"]

      conn_get = get conn, content_type_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, content_type: content_type} do
      conn = patch conn, content_type_path(conn, :update, content_type), json_api_params_for(:invalid_content_type)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete" do
    setup do [content_type: insert(:content_type)] end
    test "deletes chosen content_type", %{conn: conn, content_type: content_type} do
      conn_delete = delete conn, content_type_path(conn, :delete, content_type)
      assert response(conn_delete, 204)

      assert_error_sent 404, fn ->
        get conn, content_type_path(conn, :show, content_type)
      end
    end
  end
end
