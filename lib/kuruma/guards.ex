defmodule Guards do
  defguard is_id(id) when is_binary(id) or is_integer(id)
end
