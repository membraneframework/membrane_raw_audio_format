defmodule Membrane.Caps.Audio.Raw.Mixfile do
  use Mix.Project

  def project do
    [app: :membrane_caps_audio_raw,
     version: "0.0.1",
     elixir: "~> 1.3",
     description: "Membrane Multimedia Framework (raw audio format definition)",
     maintainers: ["Marcin Lewandowski"],
     licenses: ["MIT"],
     name: "Membrane Caps: Audio.Raw",
     source_url: "https://github.com/membraneframework/membrane-caps-audio-raw",
     preferred_cli_env: [espec: :test],
     deps: deps()]
  end


  defp deps do
    [
      {:espec, "~> 1.1.2", only: :test},
      {:ex_doc, "~> 0.14", only: :dev},
      {:bimap, "~> 0.1"},
      {:membrane_core, git: "git@github.com:membraneframework/membrane-core.git"},
    ]
  end
end
