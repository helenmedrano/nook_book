# mnesia is transactional - recommended to make sure data is solid
# Use this module to interact with mnesia instead of using the mnesia atom

defmodule NookBook.Data.Repo do
  # returns list of records. When it's a bag - there will be multiple values under 1 key
  def read(table, key) do
    # transaction takes a function - calls other mnesia functions, but inside a transaction
    :mnesia.transaction(fn -> :mnesia.read(table, key) end)
  end

  # don't need the table name - record has the table name built in (first value in the tuple)
  def write(record) do
    :mnesia.transaction(fn -> :mnesia.write(record) end)
  end

  def delete(table, key) do
    :mnesia.transaction(fn -> :mnesia.delete({table, key}) end)
  end

  # usually don't want, but our table is a cache so we might want to clear it
  def clear(table) do
    # Clear table is not a transaction
    :mnesia.clear_table(table)
  end

  def all(table) do
    # wild pattern means ANYTHING - pattern specific to the table
    :mnesia.transaction(fn ->
      :mnesia.match_object(table, :mnesia.table_info(table, :wild_pattern), :read)
    end)
  end

  def filter(table, pattern) do
    :mnesia.transaction(fn ->
      :mnesia.match_object(table, pattern, :read)
    end)
  end
end
