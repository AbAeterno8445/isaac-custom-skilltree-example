--[[
    In this example mod, a skill tree is added to Tainted Isaac.
    "Example node 1" nodes have the "Adds 5 coins when starting a run" modifier, the rest are for show and don't have modifiers.
    Modifier value name is "runStartCoins", which can be found in each node's 'modifiers' table, and is what will be applied on the run.
]]

CustomSkillTree = RegisterMod("CustomSkillTree", 1)

function CustomSkillTree:initSkillTree()
    if PST == nil then
        return
    end

    -- Initialize images to be used by the new custom nodes
    local newNodesSprite = Sprite("gfx/testCustom.anm2", true)
    PST.SkillTreesAPI.InitCustomNodeImage("myNewMod", newNodesSprite)

    -- Initialize tree with generated JSON for Tainted Isaac
    PST.SkillTreesAPI.AddCharacterTree("T. Isaac", true, [[
        {
        "8": "{\"pos\":[0,0],\"type\":5000,\"size\":\"Small\",\"name\":\"Example node 1\",\"description\":[\"Adds 5 coins when starting a run.\"],\"modifiers\":{\"runStartCoins\":5},\"adjacent\":[9],\"alwaysAvailable\":true,\"customID\":\"myNewMod\"}",
        "9": "{\"pos\":[0,-1],\"type\":5000,\"size\":\"Small\",\"name\":\"Example node 1\",\"description\":[\"Adds 5 coins when starting a run.\"],\"modifiers\":{\"runStartCoins\":5},\"adjacent\":[8,13,10],\"customID\":\"myNewMod\"}",
        "10": "{\"pos\":[0,-2],\"type\":5000,\"size\":\"Small\",\"name\":\"Example node 1\",\"description\":[\"Adds 5 coins when starting a run.\"],\"modifiers\":{\"runStartCoins\":5},\"adjacent\":[9,11],\"customID\":\"myNewMod\"}",
        "11": "{\"pos\":[0,-3],\"type\":5000,\"size\":\"Small\",\"name\":\"Example node 1\",\"description\":[\"Adds 5 coins when starting a run.\"],\"modifiers\":{\"runStartCoins\":5},\"adjacent\":[10,15,12],\"customID\":\"myNewMod\"}",
        "12": "{\"pos\":[0,-4],\"type\":5000,\"size\":\"Small\",\"name\":\"Example node 1\",\"description\":[\"Adds 5 coins when starting a run.\"],\"modifiers\":{\"runStartCoins\":5},\"adjacent\":[11,17],\"customID\":\"myNewMod\"}",
        "13": "{\"pos\":[-1,-1],\"type\":5001,\"size\":\"Small\",\"name\":\"Example node 2\",\"description\":[\"\"],\"modifiers\":{},\"adjacent\":[9,14],\"customID\":\"myNewMod\"}",
        "14": "{\"pos\":[-2,-1],\"type\":5001,\"size\":\"Small\",\"name\":\"Example node 2\",\"description\":[\"\"],\"modifiers\":{},\"adjacent\":[13],\"customID\":\"myNewMod\"}",
        "15": "{\"pos\":[1,-3],\"type\":5002,\"size\":\"Small\",\"name\":\"Example node 3\",\"description\":[\"\"],\"modifiers\":{},\"adjacent\":[11,16],\"customID\":\"myNewMod\"}",
        "16": "{\"pos\":[2,-3],\"type\":5002,\"size\":\"Small\",\"name\":\"Example node 3\",\"description\":[\"\"],\"modifiers\":{},\"adjacent\":[15],\"customID\":\"myNewMod\"}",
        "17": "{\"pos\":[-1,-5],\"type\":5003,\"size\":\"Small\",\"name\":\"Example node 4\",\"description\":[\"\"],\"modifiers\":{},\"adjacent\":[12,18],\"customID\":\"myNewMod\"}",
        "18": "{\"pos\":[-2,-6],\"type\":5003,\"size\":\"Small\",\"name\":\"Example node 4\",\"description\":[\"\"],\"modifiers\":{},\"adjacent\":[17],\"customID\":\"myNewMod\"}"
        }
    ]]);

    -- Initialize a new category for our modifier
    local myCategory = "myCustomModCategory"
    PST.SkillTreesAPI.AddModifierCategory(myCategory, "My Custom Mod Category", KColor(0.5, 1, 0.5, 1))

    -- Initialize our modifier's description
    PST.SkillTreesAPI.AddModifierDescription("runStartCoins", myCategory, "Adds %d coins when starting a run.", false, 1)

    print("Initialized custom test tree.")
end
CustomSkillTree:initSkillTree()


-- Run start callback, add coins based on the total modifier
function CustomSkillTree:onRunBegins(isContinued)
    if PST == nil or isContinued then
        return
    end

    -- Fetch the sum total of our modifier from the current run's tree snapshot
    local myModTotal = PST.SkillTreesAPI.GetSnapshotMod("runStartCoins", 0)
    if myModTotal > 0 then
        Isaac.GetPlayer():AddCoins(myModTotal)
    end
end
CustomSkillTree:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, CustomSkillTree.onRunBegins)