function create(position, alias, name, color, permissions, default)
    if (position and alias and name and color and permissions) then
        return {true, exports.pdo:insert(tableName, {position = position, alias = alias, name = name, color = toJSON(color), permissions = toJSON(permissions), default = default})}
    end
    return {false, "Invalid arguments"}
end

function update(id, key, value)
    if (id and key and value) then
        return {true, exports.pdo:update(tableName, {[key] = value}, {id = id})}
    end
    return {false, "Invalid arguments"}
end

function delete(id)
    if id then
        return {true, exports.pdo:delete(tableName, {id = id})}
    end
    return {false, "Invalid arguments"}
end

function getDefault()
    local inCache = exports.cache:get("ranks", "default")
    if inCache then
        return inCache
    else
        local result = exports.pdo:select("ranks", "*", {default = 1})
        return result
    end
end