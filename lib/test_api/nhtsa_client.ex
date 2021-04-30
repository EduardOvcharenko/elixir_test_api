defmodule TestApi.Nhtsa.Client do
  @behaviour TestApi.ClientBehaviour

  @url Application.get_env(:test_api, TestApi.Integrations.Nhtsa)[:url]
  @headers [{"Content-Type", "application/json"}]

  def get_brands do
    get() |> process_response_body()
  end

  defp get() do
    HTTPoison.get(@url, @headers)
  end

  defp process_response_body({:ok, %HTTPoison.Response{status_code: status_code, body: body}})
       when status_code in [200, 201, 204],
       do: parse_body(body)

  defp parse_body(body) do
    body
    |> Poison.decode!()
    |> Map.get("Results")
    |> Enum.map(fn %{"Make_ID" => _id, "Make_Name" => name} -> name end)
  end
end
