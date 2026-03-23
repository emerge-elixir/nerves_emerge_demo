defmodule NervesEmergeDemo.State do
  @moduledoc false

  use Solve

  alias NervesEmergeDemo.CounterController

  @impl Solve
  def controllers() do
    [controller!(name: :counter, module: CounterController)]
  end
end
