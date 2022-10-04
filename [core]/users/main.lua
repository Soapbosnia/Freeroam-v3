function create(username, password, email, nickname, rank, serials, ips)
    if (username and password and email and nickname and rank and serials and ips) then
        local parameters = {
            username = username,
            password = password,
            email = email,
            nickname = nickname,
            rank = rank.id,
            serials = toJSON(serials),
            ips = toJSON(ips)
        }
        return {true, exports.pdo:insert(tableName, parameters)}
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