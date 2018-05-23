defmodule KidseeApiWeb.UserAnswerControllerTest do
  use KidseeApiWeb.ConnCase do
    import KidseeApi.UserAnswerFactory
  end
  describe "index" do
    test "lists all user_answers", %{conn: conn} do
      conn = get(conn, user_answer_path(conn, :index))
      assert json_response(conn, 200)
    end
  end

  describe "create" do
    test "renders user_answer when data is valid", %{conn: conn} do
      conn_create = post conn, user_answer_path(conn, :create), build(:jsonapi_user_answer)
      assert %{"id" => id} = json_response(conn_create, 201)["data"]

      conn_get = get conn, user_answer_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, user_answer_path(conn, :create), json_api_params_for(:invalid_user_answer)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update" do
    setup do [user_answer: insert(:user_answer)] end

    test "renders user_answer when data is valid", %{conn: conn, user_answer: user_answer} do
      conn_patch = patch conn, user_answer_path(conn, :update, user_answer), build(:jsonapi_user_answer)
      assert %{"id" => id} = json_response(conn_patch, 200)["data"]

      conn_get = get conn, user_answer_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, user_answer: user_answer} do
      conn = patch conn, user_answer_path(conn, :update, user_answer), json_api_params_for(:invalid_user_answer)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete" do
    setup do [user_answer: insert(:user_answer)] end
    test "deletes chosen user_answer", %{conn: conn, user_answer: user_answer} do
      conn_delete = delete conn, user_answer_path(conn, :delete, user_answer)
      assert response(conn_delete, 204)

      assert_error_sent 404, fn ->
        get conn, user_answer_path(conn, :show, user_answer)
      end
    end
  end
end
