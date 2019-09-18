defmodule Practice.Factor do

  def parse_int(text) do
    {num, _} = Integer.parse(text)
    num
  end

  def factor(x) do
    factor_helper(x, 2, [])
  end

  def factor_helper(x, n, list) do
    cond do
      n < x and rem(x, n) == 0 -> factor_helper(div(x, n), n, list ++ [n])
      n >= x -> list ++ [n]
      true -> factor_helper(x, n + 1, list)
    end
  end
end

