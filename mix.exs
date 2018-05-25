defmodule Membrane.Caps.Audio.Raw.Mixfile do
  use Mix.Project

  def project do
    [
      app: :membrane_caps_audio_raw,
      version: "0.0.1",
      elixir: "~> 1.6",
      description: "Membrane Multimedia Framework (raw audio format definition)",
      package: package(),
      name: "Membrane Caps: Audio.Raw",
      source_url: "https://github.com/membraneframework/membrane-caps-audio-raw",
      preferred_cli_env: [espec: :test, format: :test],
      deps: deps()
    ]
  end

  defp package do
    [
      maintainers: ["Membrane Team"],
      licenses: ["Apache 2.0"]
    ]
  end

  defp deps do
    [
      {:espec, "~> 1.5", only: :test},
      {:ex_doc, "~> 0.18", only: :dev},
      {:bimap, "~> 0.1"},
      {:membrane_core, git: "git@github.com:membraneframework/membrane-core.git"}
    ]
  end
end
