defmodule Membrane.Caps.Audio.Raw.Mixfile do
  use Mix.Project

  def project do
    [
      app: :membrane_caps_audio_raw,
      version: "0.1.0",
      elixir: "~> 1.6",
      description: "Membrane Multimedia Framework (raw audio format definition)",
      package: package(),
      name: "Membrane Caps: Audio.Raw",
      source_url: link(),
      homepage_url: "https://membraneframework.org",
      preferred_cli_env: [espec: :test, format: :test],
      deps: deps()
    ]
  end

  defp link do
    "https://github.com/membraneframework/membrane-caps-audio-raw"
  end

  defp package do
    [
      maintainers: ["Membrane Team"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => link()}
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.18", only: :dev, runtime: false},
      {:espec, "~> 1.5", only: :test},
      {:bimap, "~> 0.1"},
      {:membrane_core, git: "git@github.com:membraneframework/membrane-core.git"}
    ]
  end
end
