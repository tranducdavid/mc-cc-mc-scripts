-- List top 10 visitors by the sum of all their stats, sorted in descending order

-- Ensure the colony API is available
if not colony.isValid() then
  print("No valid colony found.")
  return
end

-- Get the list of all visitors
local visitors = colony.getVisitors()
if not visitors then
  print("Failed to retrieve visitors.")
  return
end

-- Function to calculate the sum of all stats for a visitor
local function calculateTotalStats(visitor)
  local totalStats = 0
  for _, skillData in pairs(visitor.skills) do
      totalStats = totalStats + (skillData.level or 0)
  end
  return totalStats
end

-- Visitors by the sum of all their stats
local visitorsData = {}
for _, visitor in ipairs(visitors) do
  table.insert(visitorsData, {
      id = visitor.id,
      name = visitor.name,
      totalStats = calculateTotalStats(visitor)
  })
end

-- Sort the visitors by the sum of all their stats in descending order
table.sort(visitorsData, function(a, b)
  return a.totalStats > b.totalStats
end)

-- Print the top 10 visitors by the sum of their stats
for i = 1, math.min(10, #visitorsData) do
  local visitor = visitorsData[i]
  print(string.format("[%03d] %s", visitor.totalStats, visitor.name))
end

-- If no visitors were found, inform the user
if #visitorsData == 0 then
  print("No visitors found.")
end
