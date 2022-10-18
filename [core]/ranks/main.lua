function create(position, alias, name, color, permissions, default)
    if (position and alias and name and color and permissions) then
        local parameters = {
            {"position", position},
            {"alias", alias},
            {"name", name},
            {"color", toJSON(color)},
            {"permissions", toJSON(permissions)},
            {"default", default}
        }
        return {true, exports.sql:insert(tableName, parameters)}
    end
    return {false, "Invalid arguments"}
end

function update(id, key, value)
    if (id and key and value) then
        return {true, exports.sql:update(tableName, {{key, value}}, {{"id", id}})}
    end
    return {false, "Invalid arguments"}
end

function delete(id)
    if id then
        return {true, exports.sql:delete(tableName, {{"id", id}})}
    end
    return {false, "Invalid arguments"}
end

function getDefault()
    local inCache = exports.cache:get("ranks", "default")
    local result = inCache or exports.sql:select(tableName, "*", {{"default", 1}})[1]
    return result
end