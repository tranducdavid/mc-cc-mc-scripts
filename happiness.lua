-- Ensure the colony API is available
if not colony.isValid() then
  print("No valid colony found.")
  return
end

-- Get the list of all citizens
local citizens = colony.getCitizens()
if not citizens then
  print("Failed to retrieve citizens.")
  return
end

-- Sort citizens by their happiness in ascending order
table.sort(citizens, function(a, b)
  return a.happiness < b.happiness
end)

-- Function to format citizen details
local function formatCitizen(citizen)
  local profession = citizen.job or "Unemployed"
  return string.format("[%02d] %s - %.1f (%s)", citizen.id, citizen.name, citizen.happiness, profession)
end

-- Print the top 10 most unhappy citizens
print("Top 10 Most Unhappy Villagers:")
for i = 1, math.min(10, #citizens) do
  print(formatCitizen(citizens[i]))
end
