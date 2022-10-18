local tableName = "users"
local tableFields = {
    {"id", "INT PRIMARY KEY AUTO_INCREMENT"},
    {"username", "TEXT"},
    {"password", "TEXT"},
    {"email", "TEXT"},
    {"nickname", "TEXT"},
    {"rank", "INT REFERENCES ranks(id)"},
    {"serials", "TEXT"},
    {"ips", "TEXT"},
    {"created_on", "TEXT"},
    {"protected", "INT"}
}
exports.sql:create(tableName, tableFields)
----------
-- Methods
----------
function setUserUsername(user, username)
    if (user and username) then
        return {true, exports.sql:update(tableName, {username = username}, {id = user.id})}
    end
    return {false, "Invalid arguments"}
end

function setUserPassword(user, password)
    if (user and password) then
        return {true, exports.sql:update(tableName, {password = password}, {id = user.id})}
    end
    return {false, "Invalid arguments"}
end

function setUserEmail(user, email)
    if (user and email) then
        return {true, exports.sql:update(tableName, {email = email}, {id = user.id})}
    end
    return {false, "Invalid arguments"}
end

function setUserNickname(user, nickname)
    if (user and nickname) then
        return {true, exports.sql:update(tableName, {nickname = nickname}, {id = user.id})}
    end
    return {false, "Invalid arguments"}
end

function setUserRank(user, rank)
    if (user and rank) then
        return {true, exports.sql:update(tableName, {rank = rank.id}, {id = user.id})}
    end
    return {false, "Invalid arguments"}
end

function setUserSerials(user, serials)
    if (user and serials) then
        return {true, exports.sql:update(tableName, {serials = toJSON(serials)}, {id = user.id})}
    end
    return {false, "Invalid arguments"}
end

function addUserSerial(user, serial)
    if (user and serial) then
        local serials = fromJSON(user.serials)
        table.insert(serials, {serial = serial, default = false})
        return setUserSerials(user, serials)
    end
    return {false, "Invalid arguments"}
end

function setUserIps(user, ips)
    if (user and ips) then
        return {true, exports.sql:update(tableName, {ips = toJSON(ips)}, {id = user.id})}
    end
    return {false, "Invalid arguments"}
end

function addUserIp(user, ip)
    if (user and ip) then
        local ips = fromJSON(user.ips)
        table.insert(ips, {ip = ip, default = false})
        return setUserIps(user, ips)
    end
    return {false, "Invalid arguments"}
end

function setUserProtected(user, protected)
    if user then
        return {true, exports.sql:update(tableName, {protected = protected}, {id = user.id})}
    end
    return {false, "Invalid arguments"}
end

function getUserById(id)
    return exports.sql:select(tableName, "*", {id = id})[1]
end

function getUserByUsername(username)
    return exports.sql:select(tableName, "*", {username = username})[1]
end

function getUserByEmail(email)
    return exports.sql:select(tableName, "*", {email = email})[1]
end

function getUserByNickname(nickname)
    return exports.sql:select(tableName, "*", {nickname = nickname})[1]
end

function getUserUsername(id)
    local user = getUserById(id)
    return user.username
end

function getUserPassword(id)
    local user = getUserById(id)
    return user.password
end

function getUserEmail(id)
    local user = getUserById(id)
    return user.email
end

function getUserNickname(id)
    local user = getUserById(id)
    return user.nickname
end

function getUserRank(id)
    local user = getUserById(id)
    return user.rank
end

function getUserSerials(id)
    local user = getUserById(id)
    return fromJSON(user.serials)
end

function getUserIps(id)
    local user = getUserById(id)
    return fromJSON(user.ips)
end

function getUserCreatedOn(id)
    local user = getUserById(id)
    return user.created_on
end

function isUserProtected(id)
    local user = getUserById(id)
    return user.protected
end