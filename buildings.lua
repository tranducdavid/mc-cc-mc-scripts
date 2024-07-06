-- buildings.lua: Script to list buildings sorted by their level (lowest to highest) with pagination

-- Ensure the colony API is available
if not colony.isValid() then
  print("No valid colony found.")
  return
end

-- Get the page number from the command line arguments
local args = { ... }
local pageNumber = tonumber(args[1]) or 1

-- Get the list of all buildings
local buildings = colony.getBuildings()
if not buildings then
  print("Failed to retrieve buildings.")
  return
end

-- Sort buildings by their level in ascending order
table.sort(buildings, function(a, b)
  return a.level < b.level
end)

-- Function to format building details
local function formatBuilding(building)
  return string.format("%s %d (%d | %d)", building.type, building.level, building.location.x, building.location.z)
end

-- Pagination logic
local buildingsPerPage = 10
local totalPages = math.ceil(#buildings / buildingsPerPage)
if pageNumber > totalPages then
  pageNumber = totalPages
elseif pageNumber < 1 then
  pageNumber = 1
end

local startIndex = (pageNumber - 1) * buildingsPerPage + 1
local endIndex = math.min(startIndex + buildingsPerPage - 1, #buildings)

-- Print the paginated list of buildings
print(string.format("Page %d of %d", pageNumber, totalPages))
for i = startIndex, endIndex do
  print("- " .. formatBuilding(buildings[i]))
end

-- Print navigation hints
if pageNumber < totalPages then
  print("Type 'buildings.lua " .. (pageNumber + 1) .. "' for next page")
end
if pageNumber > 1 then
  print("Type 'buildings.lua " .. (pageNumber - 1) .. "' for previous page")
end
