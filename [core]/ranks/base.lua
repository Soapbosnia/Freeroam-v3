local tableName = "ranks"
local tableFields = {
    ["id"] = "INT PRIMARY KEY AUTOINCREMENT",
    ["position"] = "INT",
    ["alias"] = "TEXT",
    ["name"] = "TEXT",
    ["color"] = "TEXT",
    ["permissions"] = "TEXT"
}
exports.pdo:create(tableName, tableFields)
-------------
-- Methods --
-------------
function setRankPosition(rank, position)
    if (rank and position) then
        return {true, exports.pdo.update(tableName, {position = position}, {id = rank.id})}
    end
    return {false, "Invalid arguments"}
end

function setRankAlias(rank, alias)
    if (rank and alias) then
        return {true, exports.pdo.update(tableName, {alias = alias}, {id = rank.id})}
    end
    return {false, "Invalid arguments"}
end

function setRankName(rank, name)
    if (rank and name) then
        return {true, exports.pdo.update(tableName, {name = name}, {id = rank.id})}
    end
    return {false, "Invalid arguments"}
end

function setRankColor(rank, color)
    if (rank and color) then
        return {true, exports.pdo.update(tableName, {color = toJSON(color)}, {id = rank.id})}
    end
    return {false, "Invalid arguments"}
end

function setRankPermissions(rank, permissions)
    if (rank and permissions) then
        return {true, exports.pdo.update(tableName, {permissions = toJSON(permissions)}, {id = rank.id})}
    end
    return {false, "Invalid arguments"}
end

function setRankPermission(rank, permission, value)
    if (rank and permission and value) then
        local permissions = fromJSON(rank.permissions)
        permissions[permission] = value
        return setRankPermissions(rank, permissions)
    end
    return {false, "Invalid arguments"}
end

function getRankById(id)
    return exports.pdo.select(tableName, "*", {id = id})
end

function getRankByPosition(position)
    return exports.pdo.select(tableName, "*", {position = position})
end

function getRankByAlias(alias)
    return exports.pdo.select(tableName, "*", {alias = alias})
end

function getRankByName(name)
    return exports.pdo.select(tableName, "*", {name = name})
end

function getRankAlias(id)
    local rank = getRankById(id)
    return rank.alias
end

function getRankAlias(id)
    local rank = getRankById(id)
    return rank.alias
end

function getRankName(id)
    local rank = getRankById(id)
    return rank.name
end

function getRankColor(id)
    local rank = getRankById(id)
    return fromJSON(rank.color)
end

function getRankPermissions(id)
    local rank = getRankById(id)
    return fromJSON(rank.permissions)
end

function getRankPermission(id, permission)
    local rank = getRankById(id)
    local permissions = fromJSON(rank.permissions)
    return permissions[permission]
end