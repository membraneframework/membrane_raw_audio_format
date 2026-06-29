defmodule Membrane.RawAudio.Mixfile do
  use Mix.Project

  @version "0.12.3"
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
      dialyzer: dialyzer(),
      homepage_url: "https://membrane.stream",
      aliases: [docs: ["docs", &append_llms_links/1]]
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md", "LICENSE"],
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
      {:membrane_core, "~> 1.0"},
      {:bimap, "~> 1.1"},
      {:bunch, "~> 1.0"},
      {:ex_doc, ">= 0.40.0", only: :dev, runtime: false},
      {:credo, ">= 0.0.0", only: :dev, runtime: false},
      {:dialyxir, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp dialyzer() do
    opts = [
      flags: [:error_handling]
    ]

    if System.get_env("CI") == "true" do
      # Store PLTs in cacheable directory for CI
      File.mkdir_p!(Path.join([__DIR__, "priv", "plts"]))
      [plt_local_path: "priv/plts", plt_core_path: "priv/plts"] ++ opts
    else
      opts
    end
  end

  defp append_llms_links(_args) do
    output_dir = docs()[:output] || "doc"
    path = Path.join(output_dir, "llms.txt")

    if File.exists?(path) do
      existing = File.read!(path)

      footer = """


      ## See Also

      - [Membrane Framework AI Skill](https://hexdocs.pm/membrane_core/skill.md)
      - [Membrane Core](https://hexdocs.pm/membrane_core/llms.txt)
      """

      File.write!(path, String.trim_trailing(existing) <> footer)
    else
      IO.warn("#{path} not found — llms.txt was not generated, check your ex_doc configuration")
    end
  end
end
