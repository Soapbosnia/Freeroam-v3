local tableName = "users"
local tableFields = {
    ["id"] = "INT PRIMARY KEY AUTOINCREMENT",
    ["username"] = "TEXT",
    ["password"] = "TEXT",
    ["email"] = "TEXT",
    ["nickname"] = "TEXT",
    ["rank"] = "INT REFERENCES ranks(id)",
    ["serials"] = "TEXT",
    ["ips"] = "TEXT",
    ["created_on"] = "TEXT"
}
exports.pdo:create(tableName, tableFields)
----------
-- Methods
----------
function setUserUsername(user, username)
    if (user and username) then
        return {true, exports.pdo.update(tableName, {username = username}, {id = user.id})}
    end
    return {false, "Invalid arguments"}
end

function setUserPassword(user, password)
    if (user and password) then
        return {true, exports.pdo.update(tableName, {password = password}, {id = user.id})}
    end
    return {false, "Invalid arguments"}
end

function setUserEmail(user, email)
    if (user and email) then
        return {true, exports.pdo.update(tableName, {email = email}, {id = user.id})}
    end
    return {false, "Invalid arguments"}
end

function setUserNickname(user, nickname)
    if (user and nickname) then
        return {true, exports.pdo.update(tableName, {nickname = nickname}, {id = user.id})}
    end
    return {false, "Invalid arguments"}
end

function setUserRank(user, rank)
    if (user and rank) then
        return {true, exports.pdo.update(tableName, {rank = rank.id}, {id = user.id})}
    end
    return {false, "Invalid arguments"}
end

function setUserSerials(user, serials)
    if (user and serials) then
        return {true, exports.pdo.update(tableName, {serials = toJSON(serials)}, {id = user.id})}
    end
    return {false, "Invalid arguments"}
end

function addUserSerial(user, serial)
    if (user and serial) then
        local serials = fromJSON(user.serials)
        table.insert(serials, serial)
        return setUserSerials(user, serials)
    end
    return {false, "Invalid arguments"}
end

function setUserIps(user, ips)
    if (user and ips) then
        return {true, exports.pdo.update(tableName, {ips = toJSON(ips)}, {id = user.id})}
    end
    return {false, "Invalid arguments"}
end

function addUserIp(user, ip)
    if (user and ip) then
        local ips = fromJSON(user.ips)
        table.insert(ips, ip)
        return setUserIps(user, ips)
    end
    return {false, "Invalid arguments"}
end

function getUserById(id)
    return exports.pdo.select(tableName, "*", {id = id})
end

function getUserByUsername(username)
    return exports.pdo.select(tableName, "*", {username = username})
end

function getUserByEmail(email)
    return exports.pdo.select(tableName, "*", {email = email})
end

function getUserByNickname(nickname)
    return exports.pdo.select(tableName, "*", {nickname = nickname})
end

function getUserUsername(id)
    local user = getUserById(id)
    return return user.username
end

function getUserPassword(id)
    local user = getUserById(id)
    return return user.password
end

function getUserEmail(id)
    local user = getUserById(id)
    return return user.email
end

function getUserNickname(id)
    local user = getUserById(id)
    return return user.nickname
end

function getUserRank(id)
    local user = getUserById(id)
    return return user.rank
end

function getUserSerials(id)
    local user = getUserById(id)
    return return fromJSON(user.serials)
end

function getUserIps(id)
    local user = getUserById(id)
    return return fromJSON(user.ips)
end

function getUserCreatedOn(id)
    local user = getUserById(id)
    return return user.created_on
end