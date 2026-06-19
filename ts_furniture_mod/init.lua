-- twi_mods/ts_furniture_mod/init.lua
-- Modifications to ts_furniture

-- Solve craft recipe conflict with banisters: use slab to craft

local function get_slab_name(name)
    -- Check Circular Saw registry
    if core.global_exists("circular_saw") and circular_saw.known_nodes[name] then
        local modname, subname = unpack(circular_saw.known_nodes[name])
        local iname = modname .. ":slab_" .. subname

        if core.registered_items[iname] then
            return iname
        end
    end

    -- Brute-force-ish method of mimicking crafting
    local slab_craft_result = core.get_craft_result({
        method = "normal",
        width = 3,
        items = { name, name, name },
    })
    local slab_item = slab_craft_result.item

    if not slab_item:is_empty() then
        return slab_item:get_name()
    end
end

for name in pairs(core.registered_nodes) do
    if string.sub(name, 1, 13) == "ts_furniture:" then
        local craft = core.get_craft_recipe(name)

        if craft.method == "normal" then
            local new_craft_recipe = table.copy(craft.items)
            for i = 1, math.max(craft.width * craft.width, #new_craft_recipe) do
                local citem = ItemStack(new_craft_recipe[i])
                local cname = citem:get_name()

                if not citem:is_empty() and cname ~= "group:stick" then

                    local slab_item = get_slab_name(cname)
                    if slab_item then
                        new_craft_recipe[i] = slab_item .. " " .. citem:get_count()
                    else
                        new_craft_recipe = nil
                        break
                    end
                end
            end

            if new_craft_recipe then
                core.clear_craft({ output = name })

                local recipe_table = {}
                for i = 1, craft.width do
                    recipe_table[i] = {}
                    for j = 1, craft.width do
                        recipe_table[i][j] = new_craft_recipe[(i - 1) * craft.width + j] or ""
                    end
                end

                print(dump(recipe_table))

                core.register_craft({
                    type = "shaped",
                    output = craft.output,
                    recipe = recipe_table,
                })
            end
        end
    end
end
