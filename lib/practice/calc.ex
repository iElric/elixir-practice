defmodule Practice.Calc do

  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  # convert the list to keyword list
  def tag_tokens(list) do
    Enum.map(
      list,
      fn (s) ->
        if s in ["+", "-", "*", "/"] do
          {:op, s}
        else
          {:num, parse_float(s)}
        end
      end
    )
  end

  # use recursion to do * and /
  def multiply_divide(keyword_list) do
    case keyword_list do
      # base case:
      [] ->
        []
      # if the keywords_list starts with num * num, calculate that and insert at the beginning
      [{:num, operand1}, {:op, "*"}, {:num, operand2} | rest] ->
        multiply_divide([{:num, operand1 * operand2}] ++ rest)
      # if the keywords_list starts with num / num, calculate that and insert at the beginning
      [{:num, operand1}, {:op, "/"}, {:num, operand2} | rest] ->
        multiply_divide([{:num, operand1 / operand2}] ++ rest)
      # [{:num, operand1}, _, {:num, operand2} | rest] -> multiply_divide([{:num, operand2} ++ rest])
      # notice the above code will cause a bug because it did not handle the situation when the
      # keyword list has only one num
      [head | rest] -> [head] ++ multiply_divide(rest)
    end
  end

  # sane logic as above
  def add_subtract(keyword_list) do
    case keyword_list do
      # base case
      [] ->
        []
      [{:num, operand1}, {:op, "+"}, {:num, operand2} | rest] ->
        add_subtract([{:num, operand1 + operand2}] ++ rest)
      [{:num, operand1}, {:op, "-"}, {:num, operand2} | rest] ->
        add_subtract([{:num, operand1 - operand2}] ++ rest)
      [head | rest] -> [head] ++ add_subtract(rest)
    end
  end


  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    [{:num, res}] = expr
    |> String.split(~r/\s+/)
    |> tag_tokens
    |> multiply_divide
    |> add_subtract
    res
    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end
end

