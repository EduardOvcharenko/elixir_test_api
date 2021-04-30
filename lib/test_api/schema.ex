defmodule TestApi.Schema do
  @moduledoc """
  The Schema context.
  """

  import Ecto.Query, warn: false
  alias TestApi.Repo

  alias TestApi.Schema.CarBrand

  @doc """
  Returns the list of car_brand.

  ## Examples

      iex> list_car_brand()
      [%CarBrand{}, ...]

  """
  def list_car_brand do
    Repo.all(CarBrand)
  end

  @doc """
  Gets a single car_brand.

  Raises `Ecto.NoResultsError` if the Car brand does not exist.

  ## Examples

      iex> get_car_brand!(123)
      %CarBrand{}

      iex> get_car_brand!(456)
      ** (Ecto.NoResultsError)

  """
  def get_car_brand!(id), do: Repo.get!(CarBrand, id)

  @doc """
  Creates a car_brand.

  ## Examples

      iex> create_car_brand(%{field: value})
      {:ok, %CarBrand{}}

      iex> create_car_brand(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_car_brand(attrs \\ %{}) do
    %CarBrand{}
    |> CarBrand.changeset(attrs)
    |> Repo.insert(returning: [:id])
  end

  @doc """
  Updates a car_brand.

  ## Examples

      iex> update_car_brand(car_brand, %{field: new_value})
      {:ok, %CarBrand{}}

      iex> update_car_brand(car_brand, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_car_brand(%CarBrand{} = car_brand, attrs) do
    car_brand
    |> CarBrand.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a car_brand.

  ## Examples

      iex> delete_car_brand(car_brand)
      {:ok, %CarBrand{}}

      iex> delete_car_brand(car_brand)
      {:error, %Ecto.Changeset{}}

  """
  def delete_car_brand(%CarBrand{} = car_brand) do
    Repo.delete(car_brand)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking car_brand changes.

  ## Examples

      iex> change_car_brand(car_brand)
      %Ecto.Changeset{data: %CarBrand{}}

  """
  def change_car_brand(%CarBrand{} = car_brand, attrs \\ %{}) do
    CarBrand.changeset(car_brand, attrs)
  end

  alias TestApi.Schema.CarData

  defp add_brand_filter(conditions, params) do
    brand_name = Map.get(params, "car_brand")

    if brand_name != nil do
      dynamic([c, b], c.car_brand == ^brand_name and ^conditions)
    else
      conditions
    end
  end

  defp add_body_type_filter(conditions, params) do
    body_type = Map.get(params, "body_type")

    if body_type != nil do
      dynamic([c, b], c.body_type == ^body_type and ^conditions)
    else
      conditions
    end
  end

  defp add_is_electric_filter(conditions, params) do
    is_electric = Map.get(params, "is_electric")

    if is_electric != nil do
      dynamic([c, b], c.is_electric == ^is_electric and ^conditions)
    else
      conditions
    end
  end

  def list_car_data(params) do
    conditions =
      dynamic(true)
      |> add_body_type_filter(params)
      |> add_brand_filter(params)
      |> add_is_electric_filter(params)

    CarData
    |> where([car], ^conditions)
    |> Repo.all()
  end

  def list_car_data do
    Repo.all(CarData)
  end

  @doc """
  Gets a single car_data.

  Raises `Ecto.NoResultsError` if the Car data does not exist.

  ## Examples

      iex> get_car_data!(123)
      %CarData{}

      iex> get_car_data!(456)
      ** (Ecto.NoResultsError)

  """
  def get_car_data!(id), do: Repo.get!(CarData, id)

  @doc """
  Creates a car_data.

  ## Examples

      iex> create_car_data(%{field: value})
      {:ok, %CarData{}}

      iex> create_car_data(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_car_data(attrs \\ %{}) do
    %CarData{}
    |> CarData.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a car_data.

  ## Examples

      iex> update_car_data(car_data, %{field: new_value})
      {:ok, %CarData{}}

      iex> update_car_data(car_data, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_car_data(%CarData{} = car_data, attrs) do
    car_data
    |> CarData.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a car_data.

  ## Examples

      iex> delete_car_data(car_data)
      {:ok, %CarData{}}

      iex> delete_car_data(car_data)
      {:error, %Ecto.Changeset{}}

  """
  def delete_car_data(%CarData{} = car_data) do
    Repo.delete(car_data)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking car_data changes.

  ## Examples

      iex> change_car_data(car_data)
      %Ecto.Changeset{data: %CarData{}}

  """
  def change_car_data(%CarData{} = car_data, attrs \\ %{}) do
    CarData.changeset(car_data, attrs)
  end
end
