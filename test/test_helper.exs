Mix.Task.run "ecto.drop",    ["quiet", "-r", "Repo"]
Mix.Task.run "ecto.create",  ["quiet", "-r", "Repo"]
Mix.Task.run "ecto.migrate", ["-r", "Repo"]

ExUnit.start()

{:ok, _} = Repo.start_link

