function createRank(position, alias, name, color, permissions)
    if (position and alias and name and color and permissions) then
        return {true, exports.pdo.insert(tableName, {position = position, alias = alias, name = name, color = toJSON(color), permissions = toJSON(permissions)})}
    end
    return {false, "Invalid arguments"}
end

function updateRank(id, key, value)
    if (id and key and value) then
        return {true, exports.pdo.update(tableName, {[key] = value}, {id = id})}
    end
    return {false, "Invalid arguments"}
end

function deleteRank(id)
    if id then
        return {true, exports.pdo.delete(tableName, {id = id})}
    end
    return {false, "Invalid arguments"}
end