defmodule Membrane.RawAudio.Mixfile do
  use Mix.Project

  @version "0.11.0"
  @github_link "https://github.com/membraneframework/membrane_raw_audio_format"

  def project do
    [
      app: :membrane_raw_audio_format,
      version: @version,
      elixir: "~> 1.12",
      description: "Raw audio format definition for Membrane Multimedia Framework",
      package: package(),
      name: "Membrane: raw audio format",
      source_url: @github_link,
      docs: docs(),
      deps: deps(),
      dialyzer: dialyzer()
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md", "LICENSE"],
      formatters: ["html"],
      source_ref: "v#{@version}",
      nest_modules_by_prefix: [Membrane.RawAudio]
    ]
  end

  defp package do
    [
      maintainers: ["Membrane Team"],
      licenses: ["Apache-2.0"],
      links: %{
        "GitHub" => @github_link,
        "Membrane Framework Homepage" => "https://membraneframework.org"
      }
    ]
  end

  defp deps do
    [
      {:membrane_core, "~> 0.12.0"},
      {:bimap, "~> 1.1"},
      {:bunch, "~> 1.0"},
      {:ex_doc, "~> 0.28", only: :dev, runtime: false},
      {:credo, "~> 1.6", only: :dev, runtime: false},
      {:dialyxir, "~> 1.1", only: :dev, runtime: false}
    ]
  end

  defp dialyzer() do
    opts = [
      flags: [:error_handling]
    ]

    if System.get_env("CI") == "true" do
      # Store PLTs in cacheable directory for CI
      [plt_local_path: "priv/plts", plt_core_path: "priv/plts"] ++ opts
    else
      opts
    end
  end
end
