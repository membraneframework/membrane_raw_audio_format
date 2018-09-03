defmodule Membrane.Caps.Audio.Raw.Mixfile do
  use Mix.Project

  @version "0.1.1"

  def project do
    [
      app: :membrane_caps_audio_raw,
      version: @version,
      elixir: "~> 1.6",
      description: "Membrane Multimedia Framework (raw audio format definition)",
      package: package(),
      name: "Membrane Caps: Audio.Raw",
      source_url: link(),
      docs: docs(),
      preferred_cli_env: [espec: :test, format: :test],
      deps: deps()
    ]
  end

  defp link do
    "https://github.com/membraneframework/membrane-caps-audio-raw"
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"],
      source_ref: "v#{@version}"
    ]
  end

  defp package do
    [
      maintainers: ["Membrane Team"],
      licenses: ["Apache 2.0"],
      links: %{
        "GitHub" => link(),
        "Membrane Framework Homepage" => "https://membraneframework.org"
      }
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.18", only: :dev, runtime: false},
      {:espec, "~> 1.5", only: :test},
      {:bimap, "~> 0.1"},
      {:bunch, "~> 0.1"},
      {:membrane_core, "~> 0.1.1"}
    ]
  end
end
