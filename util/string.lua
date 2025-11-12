
function uppercase_first_letter(str)
  return (str:gsub("^%l", string.upper))
end

function uppercase(str)
  return (str:gsub("%l", string.upper))
end