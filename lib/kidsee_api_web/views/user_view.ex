defmodule KidseeApiWeb.UserView do
  use KidseeApiWeb, :view
  alias KidseeApiWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      email: user.email,
      password: user.password,
      birthdate: user.birthdate,
      city: user.city,
      avatar: user.avatar,
      school: user.school}
  end
end
