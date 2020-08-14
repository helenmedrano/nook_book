defmodule NookBook.Data.GenericCache do
  alias NookBook.Data.Repo

  # part of elixir - must be spelled this way
  @behaviour NookBook.Data.TableBehaviour
  # Erlang record data type - tuples (atom name, any data type)
  require Record

  Record.defrecord(:generic_cache, key: nil, value: nil)

  def table_name(), do: :generic_cache
  # set(1 value under each key), bag(multiple values under each key)
  def table_type(), do: :set
  # follows record definition above
  def table_fields(), do: [:key, :value]
  # auto index off second item
  def table_indexes(), do: []

  def get(key) do
    case Repo.read(table_name(), key) do
      # processing atomic -> stripping down to the record VALUE only instead of the whole record
      # because we defined a table called GenericCache - it creates this fn
      {:atomic, [data]} -> generic_cache(data, :value)
      {:atomic, []} -> nil
    end
  end

  # mnesia will try and set a nil records - so define behavior NOT to do this
  def set(_key, nil), do: nil

  def set(key, value) do
    Repo.write(generic_cache(key: key, value: value))
    value
  end

  def remove(key) do
    Repo.delete(table_name(), key)
  end

  def clear() do
    Repo.clear(table_name())
  end

  def all() do
    table_name()
    |> Repo.all()
    |> case do
      {:atomic, list} ->
        list
        |> Enum.map(&generic_cache(&1, :value))

      _ ->
        []
    end
  end

  def filter(pattern) do
    # our filter is taking a pattern for the key and return all values that have that pattern
    # :_ erlang's match :_ = don't care ANY
    table_name()
    |> Repo.filter({table_name(), pattern, :_})
    |> case do
      {:atomic, list} ->
        list
        |> Enum.map(&generic_cache(&1, :value))

      _ -> 
        []
    end
  end
end
