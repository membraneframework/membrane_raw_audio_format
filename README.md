# Membrane Multimedia Framework: Raw audio format definition

This package provides raw audio format definition (so-called caps) for the
[Membrane Multimedia Framework](https://membraneframework.org).

Beyond general data structures it contains some useful helper functions for
manipulating raw audio samples.

## Installation

Unless you're developing an Membrane Element it's unlikely that you need to
use this package directly in your app, as normally it is going to be fetched as
a dependency of any element that operates on raw audio.

However, if you are developing an Element or need to add it due to any other
reason, just add the following line to your `deps` in the `mix.exs` and run
`mix deps.get`.

```elixir
{:membrane_caps_audio_raw, "~> 0.1"}
```
