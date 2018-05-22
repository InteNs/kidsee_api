defmodule KidseeApiWeb.AnswerControllerTest do
  use KidseeApiWeb.ConnCase do
    import KidseeApi.AnswerFactory
  end
  describe "index" do
    test "lists all answers", %{conn: conn} do
      conn = get(conn, answer_path(conn, :index))
      assert json_response(conn, 200)
    end
  end

  describe "create" do
    test "renders answer when data is valid", %{conn: conn} do
      conn_create = post conn, answer_path(conn, :create), build(:jsonapi_answer)
      assert %{"id" => id} = json_response(conn_create, 201)["data"]

      conn_get = get conn, answer_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, answer_path(conn, :create), json_api_params_for(:invalid_answer)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update" do
    setup do [answer: insert(:answer)] end

    test "renders answer when data is valid", %{conn: conn, answer: answer} do
      conn_patch = patch conn, answer_path(conn, :update, answer), build(:jsonapi_answer)
      assert %{"id" => id} = json_response(conn_patch, 200)["data"]

      conn_get = get conn, answer_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, answer: answer} do
      conn = patch conn, answer_path(conn, :update, answer), json_api_params_for(:invalid_answer)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete" do
    setup do [answer: insert(:answer)] end
    test "deletes chosen answer", %{conn: conn, answer: answer} do
      conn_delete = delete conn, answer_path(conn, :delete, answer)
      assert response(conn_delete, 204)

      assert_error_sent 404, fn ->
        get conn, answer_path(conn, :show, answer)
      end
    end
  end
end
