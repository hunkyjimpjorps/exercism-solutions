defmodule ScaleGenerator do
  @sharp_scales ~w/C G D A E B a e b/

  @sharp_chromatic ~w/C C# D D# E F F# G G# A A# B/
  @flat_chromatic ~w/C Db D Eb E F Gb G Ab A Bb B/

  @steps %{"m" => 1, "M" => 2, "A" => 3, "x" => 0}

  @doc """
  Find the note for a given interval (`step`) in a `scale` after the `tonic`.

  "m": one semitone
  "M": two semitones (full tone)
  "A": augmented second (three semitones)

  Given the `tonic` "D" in the `scale` (C C# D D# E F F# G G# A A# B C), you
  should return the following notes for the given `step`:

  "m": D#
  "M": E
  "A": F
  """
  @spec step(scale :: list(String.t()), tonic :: String.t(), step :: String.t()) ::
          list(String.t())
  def step(scale, tonic, step) do
    scale
    |> Stream.cycle()
    |> Stream.drop_while(&(&1 != tonic))
    |> Enum.at(@steps[step])
  end

  @doc """
  The chromatic scale is a musical scale with thirteen pitches, each a semitone
  (half-tone) above or below another.

  Notes with a sharp (#) are a semitone higher than the note below them, where
  the next letter note is a full tone except in the case of B and E, which have
  no sharps.

  Generate these notes, starting with the given `tonic` and wrapping back
  around to the note before it, ending with the tonic an octave higher than the
  original. If the `tonic` is lowercase, capitalize it.

  "C" should generate: ~w(C C# D D# E F F# G G# A A# B C)
  """
  @spec chromatic_scale(tonic :: String.t()) :: list(String.t())
  def chromatic_scale(tonic \\ "C") do
    cycle_to_tonic_and_take(@sharp_chromatic, tonic)
  end

  @doc """
  Sharp notes can also be considered the flat (b) note of the tone above them,
  so the notes can also be represented as:

  A Bb B C Db D Eb E F Gb G Ab

  Generate these notes, starting with the given `tonic` and wrapping back
  around to the note before it, ending with the tonic an octave higher than the
  original. If the `tonic` is lowercase, capitalize it.

  "C" should generate: ~w(C Db D Eb E F Gb G Ab A Bb B C)
  """
  @spec flat_chromatic_scale(tonic :: String.t()) :: list(String.t())
  def flat_chromatic_scale(tonic \\ "C") do
    cycle_to_tonic_and_take(@flat_chromatic, tonic)
  end

  defp cycle_to_tonic_and_take(scale, tonic) do
    scale
    |> Stream.cycle()
    |> Stream.drop_while(&(String.upcase(&1) != String.upcase(tonic)))
    |> Enum.take(13)
  end

  @doc """
  Certain scales will require the use of the flat version, depending on the
  `tonic` (key) that begins them, which is C in the above examples.

  For any of the following tonics, use the flat chromatic scale:

  F Bb Eb Ab Db Gb d g c f bb eb

  For all others, use the regular chromatic scale.
  """
  @spec find_chromatic_scale(tonic :: String.t()) :: list(String.t())
  def find_chromatic_scale(tonic) do
    if tonic in @sharp_scales or String.at(tonic, 1) == "#",
      do: chromatic_scale(tonic),
      else: flat_chromatic_scale(tonic)
  end

  @doc """
  The `pattern` string will let you know how many steps to make for the next
  note in the scale.

  For example, a C Major scale will receive the pattern "MMmMMMm", which
  indicates you will start with C, make a full step over C# to D, another over
  D# to E, then a semitone, stepping from E to F (again, E has no sharp). You
  can follow the rest of the pattern to get:

  C D E F G A B C
  """
  @spec scale(tonic :: String.t(), pattern :: String.t()) :: list(String.t())
  def scale(tonic, pattern) do
    steps =
      ("x" <> pattern)
      |> String.graphemes()
      |> Enum.scan(0, &(@steps[&1] + &2))

    tonic
    |> find_chromatic_scale()
    |> Enum.zip(0..12)
    |> Enum.filter(&(elem(&1, 1) in steps))
    |> Enum.map(&elem(&1, 0))
  end
end
