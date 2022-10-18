local tableName = "users"

function create(username, password, email, nickname, rank, serials, ips, created_on, protected)
    if (username and password and email and nickname and rank and serials and ips) then
        local created_on = created_on or getTimestamp()
        local protected = protected or 0
        local parameters = {
            {"username", username},
            {"password", md5(password)},
            {"email", email},
            {"nickname", nickname},
            {"rank", rank.id},
            {"serials", toJSON(serials)},
            {"ips", toJSON(ips)},
            {"created_on", created_on},
            {"protected", protected}
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