defmodule KidseeApiWeb.RatingControllerTest do
  use KidseeApiWeb.ConnCase do
    import KidseeApi.RatingFactory
  end
  describe "index" do
    test "lists all ratings", %{conn: conn} do
      conn = get(conn, rating_path(conn, :index))
      assert json_response(conn, 200)
    end
  end

  describe "create" do
    test "renders rating when data is valid", %{conn: conn} do
      conn_create = post conn, rating_path(conn, :create), build(:jsonapi_rating)
      assert %{"id" => id} = json_response(conn_create, 201)["data"]

      conn_get = get conn, rating_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, rating_path(conn, :create), json_api_params_for(:invalid_rating)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update" do
    setup do [rating: insert(:rating)] end

    test "renders rating when data is valid", %{conn: conn, rating: rating} do
      conn_patch =(patch conn, rating_path(conn, :update, rating), build(:jsonapi_rating))
      assert %{"id" => id} = json_response(conn_patch, 200)["data"]

      conn_get = get conn, rating_path(conn, :show, id)
      assert json_response(conn_get, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, rating: rating} do
      conn = patch conn, rating_path(conn, :update, rating), json_api_params_for(:invalid_rating)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete" do
    setup do [rating: insert(:rating)] end
    test "deletes chosen rating", %{conn: conn, rating: rating} do
      conn_delete = delete conn, rating_path(conn, :delete, rating)
      assert response(conn_delete, 204)

      assert_error_sent 404, fn ->
        get conn, rating_path(conn, :show, rating)
      end
    end
  end
end
