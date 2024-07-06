-- Load the job skills table from the external file
local jobSkills = dofile("mc-cc-mc-scripts/data/jobSkills.lua")

-- Get the job to filter by from the command line arguments
local args = { ... }
if #args < 1 then
    print("Usage: lv <job>")
    return
end

local jobToFilter = table.concat(args, " ")

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

-- Visitors by the relevant skills
local visitorsData = {}
for _, visitor in ipairs(visitors) do
    local skills = jobSkills[jobToFilter]
    if skills then
        local primarySkillValue = visitor.skills[skills[1]].level or 0
        local secondarySkillValue = visitor.skills[skills[2]].level or 0
        table.insert(visitorsData, {
            id = visitor.id,
            name = visitor.name,
            primarySkill = string.format("%2d", primarySkillValue),
            secondarySkill = string.format("%2d", secondarySkillValue),
            totalSkill = primarySkillValue + secondarySkillValue
        })
    end
end

-- Sort the visitors by the sum of their primary and secondary skills in descending order
table.sort(visitorsData, function(a, b)
    return a.totalSkill > b.totalSkill
end)

-- Find the skills for the given job title
local skills = jobSkills[jobToFilter]

-- Print the results
if skills then
    print(skills[1] .. " | " .. skills[2])
else
    print("Job '" .. jobToFilter .. "' not found.")
end

-- Print the visitors with their skills
for _, visitor in ipairs(visitorsData) do
    print("[" .. visitor.primarySkill .. "|" .. visitor.secondarySkill .. "] " .. visitor.name)
end

-- If no visitors were found with the specified job, inform the user
if #visitorsData == 0 then
    print("Not found")
end
