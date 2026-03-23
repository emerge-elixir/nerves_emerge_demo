defmodule NervesEmergeDemo do
  @moduledoc false

  use Emerge
  use Solve.Lookup

  alias Emerge.UI.Animation
  alias Emerge.UI.Transform

  @impl Viewport
  def mount(opts) do
    {:ok, %{}, Keyword.merge([title: "Nerves Emerge Demo", drm_card: "/dev/dri/card1"], opts)}
  end

  @impl Viewport
  def render(_state) do
    counter = solve(NervesEmergeDemo.State, :counter)
    events = events(counter)

    column(
      [
        Animation.animate(
          [
            [Background.color(color(:gray, 950))],
            [Background.color(color(:gray, 800))],
            [Background.color(color(:gray, 950))]
          ],
          5000,
          :linear,
          :loop
        ),
        width(fill()),
        height(fill())
      ],
      [
        row(
          [
            center_y(),
            center_x(),
            Border.rounded(6),
            Background.color(color(:slate, 800)),
            padding(10),
            spacing(10),
            Animation.animate(
              [
                [Transform.move_x(-300)],
                [Transform.move_x(0)],
                [Transform.move_x(300)],
                [Transform.move_x(0)],
                [Transform.move_x(-300)]
              ],
              3000,
              :linear,
              :loop
            )
          ],
          [
            button("+", events[:increment]),
            el(
              [Background.color(color(:slate, 700)), center_y(), Font.color(color(:white))],
              text("Count: #{counter.count}")
            ),
            button("-", events[:decrement])
          ]
        ),
        row(
          [
            center_y(),
            center_x(),
            Border.rounded(6),
            Background.color(color(:slate, 800)),
            padding(10),
            spacing(10)
          ],
          [
            button("+", events[:increment]),
            el(
              [Background.color(color(:slate, 700)), center_y(), Font.color(color(:white))],
              text("Count: #{counter.count}")
            ),
            button("-", events[:decrement])
          ]
        )
      ]
    )
  end

  def button(text, on_press) do
    Input.button(
      [
        padding(20),
        Border.rounded(6),
        Background.color(color(:slate)),
        Font.center(),
        Font.size(20),
        Event.on_press(on_press),
        center_y()
      ],
      text(text)
    )
  end

  @impl Solve.Lookup
  def handle_solve_updated(_updated, state) do
    {:ok, Viewport.rerender(state)}
  end
end
