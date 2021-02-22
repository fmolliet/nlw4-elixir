defmodule Rocketpay.NumbersTest do # todo teste tem o nome do modulo
  use ExUnit.Case # isso explicita que é um arquivo de teste

  alias Rocketpay.Numbers

  describe "sum_from_file_pipe/1" do
    test "When there is a file with the given name, return the sums of numbers" do
      response = Numbers.sum_from_file_pipe("numbers")

      expected_response = {:ok, %{result: 37}}

      assert response == expected_response
    end

    test "When there is no file with the given name, return an error" do
      response = Numbers.sum_from_file_pipe("banana")

      expected_response = {:error, %{message: "Invalid File"}}

      assert response == expected_response
    end
  end
end
