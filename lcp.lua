-- Load the job skills table from the external file
local jobSkills = dofile("scripts/data/jobSkills.lua")

-- Get the job to filter by from the command line arguments
local args = { ... }
if #args < 1 then
    print("Usage: lcp <job>")
    return
end

local jobToFilter = table.concat(args, " ")

-- Ensure the colony API is available
if not colony.isValid() then
    print("No valid colony found.")
    return
end

-- Get the list of all colonists
local colonists = colony.getCitizens()
if not colonists then
    print("Failed to retrieve colonists.")
    return
end

-- Colonists by the relevant skills
local colonistsData = {}
for _, colonist in ipairs(colonists) do
    local skills = jobSkills[jobToFilter]
    if skills then
        local primarySkillValue = colonist.skills[skills[1]].level or 0
        local secondarySkillValue = colonist.skills[skills[2]].level or 0
        table.insert(colonistsData, {
            id = colonist.id,
            name = colonist.name,
            primarySkill = string.format("%2d", primarySkillValue),
            secondarySkill = string.format("%2d", secondarySkillValue),
            totalSkill = primarySkillValue + secondarySkillValue
        })
    end
end

-- Sort the colonists by the sum of their primary and secondary skills in descending order
table.sort(colonistsData, function(a, b)
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

-- Print the first 10 colonists with their skills
for i = 1, math.min(10, #colonistsData) do
    local colonist = colonistsData[i]
    print("[" .. colonist.primarySkill .. "|" .. colonist.secondarySkill .. "] " .. colonist.name)
end

-- If no colonists were found with the specified job, inform the user
if #colonistsData == 0 then
    print("Not found")
end
