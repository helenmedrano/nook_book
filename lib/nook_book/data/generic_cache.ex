defmodule NookBook.Data.GenericCache do
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
end
