defmodule NervesEmergeDemoTest do
  use ExUnit.Case, async: false

  test "counter state handles increment and decrement events" do
    {:ok, app} =
      start_supervised(%{
        id: NervesEmergeDemo.State,
        start: {NervesEmergeDemo.State, :start_link, [[name: :test_counter_state]]}
      })

    assert %{count: 0} = Solve.subscribe(app, :counter)

    :ok = Solve.dispatch(app, :counter, :increment, %{})

    assert_receive %Solve.Message{
      type: :update,
      payload: %Solve.Update{
        app: ^app,
        controller_name: :counter,
        exposed_state: %{count: 1}
      }
    }

    :ok = Solve.dispatch(app, :counter, :decrement, %{})

    assert_receive %Solve.Message{
      type: :update,
      payload: %Solve.Update{
        app: ^app,
        controller_name: :counter,
        exposed_state: %{count: 0}
      }
    }
  end
end
