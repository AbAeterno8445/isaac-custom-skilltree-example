CustomSkillTree = RegisterMod("CustomSkillTree", 1)
CustomSkillTree.newTree = {}

function CustomSkillTree:initSkillTree()
    if PST == nil then
        return
    end

    -- Initialize images to be used by the new custom nodes
    local newNodesSprite = Sprite("gfx/testCustom.anm2", true)
    PST.SkillTreesAPI.InitCustomNodeImage("myNewMod", newNodesSprite)

    -- Initialize tree with generated JSON for Tainted Isaac
    PST.SkillTreesAPI.AddCharacterTree("T. Isaac", [[
        {
        "1": "{\"pos\":[0,-1],\"type\":5000,\"size\":\"Small\",\"name\":\"test\",\"description\":[\"test 1\"],\"modifiers\":{},\"adjacent\":[3],\"customID\":\"myNewMod\"}",
        "3": "{\"pos\":[1,0],\"type\":5001,\"size\":\"Small\",\"name\":\"\",\"description\":[\"\"],\"modifiers\":{},\"adjacent\":[1,4],\"customID\":\"myNewMod\"}",
        "4": "{\"pos\":[0,1],\"type\":5002,\"size\":\"Small\",\"name\":\"\",\"description\":[\"\"],\"modifiers\":{},\"adjacent\":[3,5,6],\"customID\":\"myNewMod\"}",
        "5": "{\"pos\":[0,2],\"type\":5003,\"size\":\"Small\",\"name\":\"\",\"description\":[\"\"],\"modifiers\":{},\"adjacent\":[4],\"customID\":\"myNewMod\"}",
        "6": "{\"pos\":[-1,0],\"type\":7,\"size\":\"Small\",\"name\":\"Respec Chance\",\"description\":[\"+10% chance to gain a respec point\",\"when completing a floor.\"],\"modifiers\":{\"respecChance\":10},\"adjacent\":[4,7]}",
        "7": "{\"pos\":[-2,0],\"type\":7,\"size\":\"Small\",\"name\":\"Respec Chance\",\"description\":[\"+10% chance to gain a respec point\",\"when completing a floor.\"],\"modifiers\":{\"respecChance\":10},\"adjacent\":[6]}"
        }
    ]]);

    print("Initialized custom test tree.")
end

CustomSkillTree:initSkillTree()