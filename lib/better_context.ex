defmodule BetterContext do
  @moduledoc """
  Helpers functions and macros to improve the Contexts in Phoenix applications.
  """

  @doc """
  Creates the CRUD functions for a model in the context. If the model name is `Post`, the generated functions will be

      list_posts
      get_post(post_id)
      get_post!(post_id)
      create_post(attrs \\ %{})
      update_post(post, attrs)
      delete_post(post)
      change_post(post, attrs \\ %{})
  """
  defmacro crud(module, repo, options \\ []) do
    model_name =
      Code.eval_quoted(module)
      |> elem(0)
      |> Module.split()
      |> List.last()
      |> Macro.underscore()

    plural_name = Keyword.get(options, :plural, pluralize(model_name))

    quote bind_quoted: [model_name: model_name, plural_name: plural_name, module: module, repo: repo] do
      def unquote(String.to_atom("list_" <> plural_name))() do
        unquote(repo).all(unquote(module))
      end

      def unquote(String.to_atom("get_" <> model_name))(instance_id) do
        unquote(repo).get(unquote(module), instance_id)
      end

      def unquote(String.to_atom("get_" <> model_name <> "!"))(instance_id) do
        unquote(repo).get!(unquote(module), instance_id)
      end

      def unquote(String.to_atom("create_" <> model_name))(attrs \\ %{}) do
        %unquote(module){}
        |> unquote(module).changeset(attrs)
        |> unquote(repo).insert()
      end

      def unquote(String.to_atom("update_" <> model_name))(%unquote(module){} = instance, attrs) do
        instance
        |> unquote(module).changeset(attrs)
        |> unquote(repo).update()
      end

      def unquote(String.to_atom("delete_" <> model_name))(%unquote(module){} = instance) do
        unquote(repo).delete(instance)
      end

      def unquote(String.to_atom("change_" <> model_name))(%unquote(module){} = instance, attrs \\ %{}) do
        unquote(module).changeset(instance, attrs)
      end
    end
  end

  defp pluralize(name) do
    cond do
      String.ends_with?(name, "s") -> name <> "es"
      true -> name <> "s"
    end
  end
end
