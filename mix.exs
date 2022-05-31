defmodule BetterContext.MixProject do
  use Mix.Project

  def project do
    [
      app: :better_context,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "better_context",
      source_url: "https://github.com/anujmiddha/better_context",
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "Adds code generators to Phoenix Contexts for common use cases"
  end

  defp package() do
    [
      # This option is only needed when you don't want to use the OTP application name
      name: "better_context",
      # These are the default files included in the package
      files: ~w(lib priv .formatter.exs mix.exs README* readme* LICENSE*
                license* CHANGELOG* changelog* src),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/anujmiddha/better_context"}
    ]
  end
end
