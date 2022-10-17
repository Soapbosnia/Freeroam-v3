local spawnpoints = {
	{1291.837890625, -790.33984375, 92.03125, 0, 0, 90.80615234375, "Madd Dogg's Mansion"},
	{-28.326366424561, -2469.8298339844, 23.655364990234, 0, 0, 318.82534790039, "Flint County"},
	{-1764.4951171875, 1029.1806640625, 18.415140151978, 0, 0, 179.84619140625, "Financial"},
	{-740.259765625, -2034.4716796875, 8.0078125, 0, 0, 4.88623046875, "Back o Beyond"}
}

function getSpawnpoints()
	return spawnpoints
end

function getRandomSpawnpoint()
	return spawnpoints[math.random(1, #spawnpoints)]
end

function getNearestSpawnpoint(x, y, z)
	local spawns = {}

	for index, value in ipairs(spawnpoints) do
		local sx, sy, sz, rx, ry, rz, name = unpack(value)
		local distance = getDistanceBetweenPoints3D(x, y, z, sx, sy, sz)

		table.insert(spawns, {sx, sy, sz, rx, ry, rz, name, distance})
	end
	table.sort(spawns, function (a, b) return a[8] < b[8] end)

	return spawns[1]
end

function loadPlayer(player)
    local x, y, z, rx, ry, rz, name = unpack(getRandomSpawnpoint())
    spawnPlayer(player, x, y, z, rz)
    fadeCamera(player, true)
    setCameraTarget(player, player)
end