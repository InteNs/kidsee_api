defmodule KidseeApi.Email do
    use Bamboo.Phoenix, view: KidseeApiWeb.EmailView

    def reset_password(email_address, new_password) do
        new_email
        |> to(email_address)
        |> from("cedricremond@live.nl")
        |> subject("Wachtwoord reset")
        |> html_body("<h3>Het wachtwoord van je Kidsee accounts is gereset.</h3><br>
                     Je nieuwe wachtwoord is: #{new_password}<br>
                     Je kan je wachtwoord opnieuw instellen na het inloggen.")
      end
  end