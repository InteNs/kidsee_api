defmodule KidseeApiWeb.AnswerTypeControllerTest do
  use KidseeApiWeb.ConnCase do
    import KidseeApi.AnswerTypeFactory
  end
  describe "index" do
    test "lists all answer_types", %{conn: conn} do
      conn = get(conn, answer_type_path(conn, :index))
      assert json_response(conn, 200)
    end
  end

  describe "create" do
    test "renders answer_type when data is valid", %{conn: conn} do
      conn_create = post conn, answer_type_path(conn, :create), build(:jsonapi_answer_type)
      assert %{"id" => id} = json_response(conn_create, 201)["data"]

      conn_get = get conn, answer_type_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, answer_type_path(conn, :create), json_api_params_for(:invalid_answer_type)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update" do
    setup do [answer_type: insert(:answer_type)] end

    test "renders answer_type when data is valid", %{conn: conn, answer_type: answer_type} do
      conn_patch = patch conn, answer_type_path(conn, :update, answer_type), build(:jsonapi_answer_type)
      assert %{"id" => id} = json_response(conn_patch, 200)["data"]

      conn_get = get conn, answer_type_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, answer_type: answer_type} do
      conn = patch conn, answer_type_path(conn, :update, answer_type), json_api_params_for(:invalid_answer_type)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete" do
    setup do [answer_type: insert(:answer_type)] end
    test "deletes chosen answer_type", %{conn: conn, answer_type: answer_type} do
      conn_delete = delete conn, answer_type_path(conn, :delete, answer_type)
      assert response(conn_delete, 204)

      assert_error_sent 404, fn ->
        get conn, answer_type_path(conn, :show, answer_type)
      end
    end
  end
end
