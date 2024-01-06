-- twi_mods/dumpnodes/init.lua
-- minetestmapper development mod (node dumper)
--[[
	A list of original contributors can be found at https://github.com/minetest/minetestmapper/blob/master/AUTHORS

	Copyright (c) 2013-2014, Miroslav Bendík and various contributors (see AUTHORS)
	All rights reserved.

	Redistribution and use in source and binary forms, with or without
	modification, are permitted provided that the following conditions are met:

	1. Redistributions of source code must retain the above copyright notice, this
	list of conditions and the following disclaimer.
	2. Redistributions in binary form must reproduce the above copyright notice,
	this list of conditions and the following disclaimer in the documentation
	and/or other materials provided with the distribution.

	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
	ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
	DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
	ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
	LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
	ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
	SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

local function get_tile(tiles, n)
	local tile = tiles[n]
	if type(tile) == 'table' then
		return tile.name or tile.image
	end
	return tile
end

local function pairs_s(dict)
	local keys = {}
	for k in pairs(dict) do
		keys[#keys + 1] = k
	end
	table.sort(keys)
	return ipairs(keys)
end

minetest.register_chatcommand("dumpnodes", {
	description = "Dump node and texture list for use with minetestmapper",
	privs = { server = true },
	func = function()
		local ntbl = {}
		for _, nn in pairs_s(minetest.registered_nodes) do
			local prefix, name = nn:match('(.*):(.*)')
			if prefix == nil or name == nil then
				print("ignored(1): " .. nn)
			else
				if ntbl[prefix] == nil then
					ntbl[prefix] = {}
				end
				ntbl[prefix][name] = true
			end
		end
		local out, err = io.open(minetest.get_worldpath() .. "/nodes.txt", 'wb')
		if not out then
			return true, err
		end
		local n = 0
		for _, prefix in pairs_s(ntbl) do
			out:write('# ' .. prefix .. '\n')
			for _, name in pairs_s(ntbl[prefix]) do
				local nn = prefix .. ":" .. name
				local nd = minetest.registered_nodes[nn]
				local tiles = nd.tiles or nd.tile_images
				if tiles == nil or nd.drawtype == 'airlike' then
					print("ignored(2): " .. nn)
				else
					local tex = get_tile(tiles, 1)
					tex = (tex .. '^'):match('%(*(.-)%)*^') -- strip modifiers
					if tex:find("[combine", 1, true) then
						tex = tex:match('.-=([^:]-)') -- extract first texture
					end
					out:write(nn .. ' ' .. tex .. '\n')
					n = n + 1
				end
			end
			out:write('\n')
		end
		out:close()
		return true, n .. " nodes dumped."
	end,
})
