-- Load the job skills table from the external file
local jobSkills = dofile("scripts/data/jobSkills.lua")

-- Get the job to filter by from the command line arguments
local args = { ... }
if #args < 1 then
    print("Usage: lc <job>")
    return
end

local jobToFilter = table.concat(args, " ")

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

-- Filter citizens by the specified job and get their skills
local filteredCitizens = {}
for _, citizen in ipairs(citizens) do
    if citizen.job == jobToFilter then
        local skills = jobSkills[jobToFilter]
        if skills then
            local primarySkillValue = citizen.skills[skills[1]].level or 0
            local secondarySkillValue = citizen.skills[skills[2]].level or 0
            table.insert(filteredCitizens, {
                id = citizen.id,
                name = citizen.name,
                primarySkill = string.format("%2d", primarySkillValue),
                secondarySkill = string.format("%2d", secondarySkillValue),
                totalSkill = primarySkillValue + secondarySkillValue
            })
        end
    end
end

-- Sort the filtered citizens by the sum of their primary and secondary skills in descending order
table.sort(filteredCitizens, function(a, b)
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


-- Print the filtered citizens with their skills
for _, citizen in ipairs(filteredCitizens) do
    print("[" .. citizen.primarySkill .. "|" .. citizen.secondarySkill .. "] " .. citizen.name)
end

-- If no citizens were found with the specified job, inform the user
if #filteredCitizens == 0 then
    print("Not found")
end
