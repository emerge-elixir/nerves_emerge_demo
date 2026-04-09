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
            [Background.gradient(color(:fuchsia, 800), color(:sky, 800))],
            [Background.gradient(color(:lime, 800), color(:fuchsia, 950), 180)],
            [Background.gradient(color(:fuchsia, 800), color(:sky, 800))]
          ],
          5000,
          :linear,
          :loop
        ),
        width(fill()),
        height(fill())
      ],
      [
        el(
          [
          Animation.animate([
          [Transform.alpha(0.01)],
          [Transform.alpha(1.0)]
          ],
          50_000,
          :ease_in
          ),
          center_x(), center_y(), padding(20), Font.size(20), Font.color(color(:white))],
          text("Stop staring at the animations and build something :)")
        ),
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
