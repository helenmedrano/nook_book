defmodule NookBook.ACNH.Cache do
  alias NookBook.ACNH.API.Client, as: Client
  alias NookBook.Data.GenericCache, as: Cache

  def bugs() do
    {:bug, :_}
    |> Cache.filter()
    |> case do
      [] ->
        Client.bugs()
        |> Enum.map(&Cache.set({:bug, &1["id"]}, &1))

      list ->
        list
    end
    |> Enum.sort_by(fn record -> String.capitalize(record["name"]["name-USen"]) end)
  end

  def bug(id) do
    {:bug, id}
    |> Cache.get()
    |> case do
      nil ->
        record = Client.bug(id)
        Cache.set({:bug, id}, record)

      record ->
        record
    end
  end

  def bug_icon(id) do
    {:bug_icon, id}
    |> Cache.get()
    |> case do
      nil ->
        record = Client.bug_icon(id)
        Cache.set({:bug_icon, id}, record)

      record ->
        record
    end
  end

  def bug_image(id) do
    {:bug_image, id}
    |> Cache.get()
    |> case do
      nil ->
        record = Client.bug_image(id)
        Cache.set({:bug_image, id}, record)

      record ->
        record
    end
  end

end

