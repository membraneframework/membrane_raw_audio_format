defmodule Membrane.Caps.Audio.Raw.Mixfile do
  use Mix.Project

  def project do
    [app: :membrane_caps_audio_raw,
     version: "0.0.1",
     elixir: "~> 1.3",
     description: "Membrane Multimedia Framework (Audio.Raw caps)",
     maintainers: ["Marcin Lewandowski"],
     licenses: ["LGPL"],
     name: "Membrane Caps: Audio.Raw",
     source_url: "https://bitbucket.org/radiokit/membrane-caps-audio-raw",
     preferred_cli_env: [espec: :test],
     deps: deps]
  end


  defp deps do
    [
      {:espec, "~> 1.1.2", only: :test},
      {:ex_doc, "~> 0.14", only: :dev},
    ]
  end
end
