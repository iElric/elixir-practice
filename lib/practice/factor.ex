defmodule Practice.Factor do
  define factor(x) do

  end

  define factor_helper(x, n, list) do
    cond do
      n < x and rem(x, acc) == 0 -> factor_helper()
    end
  end
end

