
function uppercase_first_letter(str)
  return (str:gsub("^%l", string.upper))
end

function uppercase(str)
  return (str:gsub("%l", string.upper))
end

function name_to_localised_str(name)
  local words = {}
  for word in string.gmatch(name, "[^_%s]+") do
      table.insert(words, uppercase_first_letter(word))
  end
  return table.concat(words, " ")
end