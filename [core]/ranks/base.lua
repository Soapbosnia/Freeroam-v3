local tableName = "ranks"
local tableFields = {
    {"id", "INT PRIMARY KEY AUTO_INCREMENT"},
    {"position", "INT"},
    {"alias", "TEXT"},
    {"name", "TEXT"},
    {"color", "TEXT"},
    {"permissions", "TEXT"},
    {"default", "INT"}
}
exports.sql:create(tableName, tableFields)
-------------
-- Methods --
-------------
function setRankPosition(rank, position)
    if (rank and position) then
        return {true, exports.sql:update(tableName, {position = position}, {id = rank.id})}
    end
    return {false, "Invalid arguments"}
end

function setRankAlias(rank, alias)
    if (rank and alias) then
        return {true, exports.sql:update(tableName, {alias = alias}, {id = rank.id})}
    end
    return {false, "Invalid arguments"}
end

function setRankName(rank, name)
    if (rank and name) then
        return {true, exports.sql:update(tableName, {name = name}, {id = rank.id})}
    end
    return {false, "Invalid arguments"}
end

function setRankColor(rank, color)
    if (rank and color) then
        return {true, exports.sql:update(tableName, {color = toJSON(color)}, {id = rank.id})}
    end
    return {false, "Invalid arguments"}
end

function setRankPermissions(rank, permissions)
    if (rank and permissions) then
        return {true, exports.sql:update(tableName, {permissions = toJSON(permissions)}, {id = rank.id})}
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

function setRankDefault(rank, default)
    if rank then
        return {true, exports.sql:update(tableName, {default = default}, {id = rank.id})}
    end
    return {false, "Invalid arguments"}
end

function getRankById(id)
    return exports.sql:select(tableName, "*", {id = id})[1]
end

function getRankByPosition(position)
    return exports.sql:select(tableName, "*", {position = position})[1]
end

function getRankByAlias(alias)
    return exports.sql:select(tableName, "*", {alias = alias})[1]
end

function getRankByName(name)
    return exports.sql:select(tableName, "*", {name = name})[1]
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

function hasRankPermission(id, permission)
    local rank = getRankById(id)
    local permissions = fromJSON(rank.permissions)

    if permissions["*"] then
        return true
    else
        return permissions[permission]
    end
end

function isRankDefault(id)
    local rank = getRankById(id)
    return rank.default == 1
end

addEventHandler("onResourceStart", resourceRoot, function()
    local ranks = exports.sql:select(tableName, "*", {})
    local default = exports.sql:select(tableName, "*", {default = 1})
    if ranks then
        exports.cache:set("ranks", "list", ranks)
        exports.cache:set("ranks", "default", default)
    end
end)

addEventHandler("onResourceStop", resourceRoot, function()
    exports.cache:clear("ranks")
end)