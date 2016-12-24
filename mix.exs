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


  def application, do: []
  defp deps, do: []
end
