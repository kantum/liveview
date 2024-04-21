defmodule LiveviewWeb.Api.PostControllerTest do
  use LiveviewWeb.ConnCase

  import Liveview.BlogFixtures

  alias Liveview.Blog.Post

  @create_attrs %{
    body: "some body",
    title: "some title",
    word_count: 42
  }
  @update_attrs %{
    body: "some updated body",
    title: "some updated title",
    word_count: 43
  }
  @invalid_attrs %{body: nil, title: nil, word_count: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all posts", %{conn: conn} do
      conn = get(conn, ~p"/api/api/posts")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create post" do
    test "renders post when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/posts", post: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/api/posts/#{id}")

      assert %{
               "id" => ^id,
               "body" => "some body",
               "title" => "some title",
               "word_count" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/posts", post: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update post" do
    setup [:create_post]

    test "renders post when data is valid", %{conn: conn, post: %Post{id: id} = post} do
      conn = put(conn, ~p"/api/api/posts/#{post}", post: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/api/posts/#{id}")

      assert %{
               "id" => ^id,
               "body" => "some updated body",
               "title" => "some updated title",
               "word_count" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, post: post} do
      conn = put(conn, ~p"/api/api/posts/#{post}", post: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete post" do
    setup [:create_post]

    test "deletes chosen post", %{conn: conn, post: post} do
      conn = delete(conn, ~p"/api/api/posts/#{post}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/api/posts/#{post}")
      end
    end
  end

  defp create_post(_) do
    post = post_fixture()
    %{post: post}
  end
end
