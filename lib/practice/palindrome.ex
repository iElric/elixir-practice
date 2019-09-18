defmodule Practice.Palindrome do

  def palindrome?(str) do
    str === String.reverse(str)
  end

end
