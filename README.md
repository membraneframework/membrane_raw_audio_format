# Membrane Multimedia Framework: Raw audio format definition

[![Hex.pm](https://img.shields.io/hexpm/v/membrane_caps_audio_raw.svg)](https://hex.pm/packages/membrane_caps_audio_raw)
[![API Docs](https://img.shields.io/badge/api-docs-yellow.svg?style=flat)](https://hexdocs.pm/membrane_caps_audio_raw)
[![CircleCI](https://circleci.com/gh/membraneframework/membrane_caps_audio_raw/tree/master.svg?style=svg)](https://circleci.com/gh/membraneframework/membrane_caps_audio_raw/tree/master)

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
{:membrane_raw_audio_format, "~> 0.6.0"}
```



## Copyright and License

Copyright 2018, [Software Mansion](https://swmansion.com/?utm_source=git&utm_medium=readme&utm_campaign=membrane)

[![Software Mansion](https://logo.swmansion.com/logo?color=white&variant=desktop&width=200&tag=membrane-github)](https://swmansion.com/?utm_source=git&utm_medium=readme&utm_campaign=membrane)

Licensed under the [Apache License, Version 2.0](LICENSE)
