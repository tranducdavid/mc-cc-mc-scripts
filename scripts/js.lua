-- Table of job titles with their primary and secondary skills
local jobSkills = {
  ["Alchemist"] = {"Dexterity", "Mana"},
  ["Archer"] = {"Agility", "Adaptability"},
  ["Assistant Cook"] = {"Creativity", "Knowledge"},
  ["Baker"] = {"Knowledge", "Dexterity"},
  ["Beekeeper"] = {"Dexterity", "Adaptability"},
  ["Blacksmith"] = {"Strength", "Focus"},
  ["Builder"] = {"Adaptability", "Athletics"},
  ["Carpenter"] = {"Knowledge", "Dexterity"},
  ["Chicken Farmer"] = {"Adaptability", "Agility"},
  ["Composter"] = {"Stamina", "Athletics"},
  ["Concrete Mixer"] = {"Stamina", "Dexterity"},
  ["Cook"] = {"Adaptability", "Knowledge"},
  ["Courier"] = {"Agility", "Adaptability"},
  ["Cowhand"] = {"Athletics", "Stamina"},
  ["Crusher"] = {"Stamina", "Strength"},
  ["Druid"] = {"Mana", "Focus"},
  ["Dyer"] = {"Creativity", "Dexterity"},
  ["Enchanter"] = {"Mana", "Knowledge"},
  ["Farmer"] = {"Stamina", "Athletics"},
  ["Fisher"] = {"Focus", "Agility"},
  ["Fletcher"] = {"Dexterity", "Creativity"},
  ["Florist"] = {"Dexterity", "Agility"},
  ["Forester"] = {"Strength", "Focus"},
  ["Glassblower"] = {"Creativity", "Focus"},
  ["Doctor"] = {"Mana", "Knowledge"},
  ["Knight"] = {"Adaptability", "Stamina"},
  ["Library Student"] = {"Intelligence", "-"},
  ["Mechanic"] = {"Knowledge", "Agility"},
  ["Miner"] = {"Strength", "Stamina"},
  ["Nether Miner"] = {"Adaptability", "Strength"},
  ["Planter"] = {"Agility", "Dexterity"},
  ["Pupil"] = {"Intelligence & Knowledge", "Mana"},
  ["Quarrier"] = {"Strength", "Stamina"},
  ["Rabbit Herder"] = {"Agility", "Athletics"},
  ["Researcher"] = {"Knowledge", "Mana"},
  ["Shepherd"] = {"Focus", "Strength"},
  ["Sifter"] = {"Focus", "Strength"},
  ["Smelter"] = {"Athletics", "Strength"},
  ["Stonemason"] = {"Creativity", "Dexterity"},
  ["Stone Smelter"] = {"Athletics", "Dexterity"},
  ["Swineherd"] = {"Strength", "Athletics"},
  ["Teacher"] = {"Knowledge", "Mana"},
  ["Undertaker"] = {"Strength", "Mana"}
}

-- Get the job title from the command line arguments
local args = { ... }
if #args < 1 then
  print("Usage: get_skills_by_job <job>")
  return
end

local jobTitle = table.concat(args, " ")

-- Find the skills for the given job title
local skills = jobSkills[jobTitle]

-- Print the results
if skills then
  print("[" .. jobTitle .. "]: " .. skills[1] .. " | " .. skills[2])
else
  print("Job '" .. jobTitle .. "' not found.")
end
