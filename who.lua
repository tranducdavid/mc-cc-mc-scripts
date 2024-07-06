-- Ensure the colony API is available
if not colony.isValid() then
  print("No valid colony found.")
  return
end

-- Get the name prefix to search for from the command line arguments
local args = { ... }
if #args < 1 then
  print("Usage: who <name prefix>")
  return
end

local namePrefix = table.concat(args, " "):lower()

-- Get the list of all citizens
local citizens = colony.getCitizens()
if not citizens then
  print("Failed to retrieve citizens.")
  return
end

-- Find citizens whose names start with the specified prefix
local matchedCitizens = {}
for _, citizen in ipairs(citizens) do
  if citizen.name:lower():find("^" .. namePrefix) then
      table.insert(matchedCitizens, citizen)
  end
end

-- Check for ambiguity or no matches
if #matchedCitizens == 0 then
  print("No citizens found with the name prefix '" .. namePrefix .. "'.")
  return
elseif #matchedCitizens > 1 then
  print("Multiple citizens found with the name prefix '" .. namePrefix .. "':")
  for _, citizen in ipairs(matchedCitizens) do
      print("- " .. citizen.name)
  end
  print("Please be more specific.")
  return
end

-- Get the matched citizen
local citizen = matchedCitizens[1]

-- Print the details of the matched citizen
print("Name: " .. citizen.name)
print("Job: " .. (citizen.job or "Unemployed"))
print("Skills:")
for skillName, skillData in pairs(citizen.skills) do
  print(" - " .. skillName .. ": Level " .. skillData.level)
end
