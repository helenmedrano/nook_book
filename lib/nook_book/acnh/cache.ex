defmodule NookBook.ACNH.Cache do
  alias NookBook.ACNH.Cache.Private

  def bugs() do
    Private.list_from_cache(:bug, :bugs)
  end

  def bug(id) do
    Private.record_from_cache(:bug, :bug, id)
  end

  def bug_icon(id) do
    Private.record_from_cache(:bug_icon, :bug_icon, id)
  end

  def bug_image(id) do
    Private.record_from_cache(:bug_image, :bug_image, id)
  end

  defmodule Private do
    alias NookBook.ACNH.API.Client, as: Client
    alias NookBook.Data.GenericCache, as: Cache

    def list_from_cache(namespace, function) do
      {namespace, :_}
      |> Cache.filter()
      |> case do
        [] ->
          apply(Client, function, [])
          |> Enum.reject(fn record -> is_nil(record["id"]) end)
          |> Enum.map(&Cache.set({:bug, &1["id"]}, &1))

        list ->
          list
      end
      |> Enum.sort_by(fn record -> String.capitalize(record["name"]["name-USen"]) end)
    end

    def record_from_cache(namespace, function, id) do
      {namespace, id}
      |> Cache.get()
      |> case do
        nil ->
          record = apply(Client, function, [id])
          Cache.set({namespace, id}, record)

        record ->
          record
      end
    end
  end
end

