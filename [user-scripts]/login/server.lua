local function attemptLogin(username, password)
    local user = exports.users:getUserByUsername(username)
    if (not user) then
        return
    end
    local actualPassword = user.password
    if (md5(password) ~= actualPassword) then
        return
    end
    triggerEvent("onUserLogin", source, source, user)
    triggerClientEvent(source, "hideLoginSections", source)
    setElementData(source, "logged-in", true)
    exports.spawner:loadPlayer(source)
end
addEvent("attemptLogin", true)
addEventHandler("attemptLogin", root, attemptLogin)

local function attemptRegister(username, password, email, nickname)
    if exports.users:getUserByUsername(username) then
        return
    end
    if exports.users:getUserByEmail(email) then
        return
    end
    if exports.users:getUserByNickname(nickname) then
        return
    end
    local rank = {id = 1}
    local serials = {{serial = getPlayerSerial(source), default = true}}
    local ips = {{ip = getPlayerIP(source), default = true}}

    exports.users:create(username, password, email, nickname, rank, serials, ips)
    attemptLogin(username, password)
end
addEvent("attemptRegister", true)
addEventHandler("attemptRegister", root, attemptRegister)

local function attemptLogout(command)
    if (command == "logout") then
        setElementData(source, "logged-in", nil)
        triggerEvent("onUserLogout", source, source)
        triggerClientEvent(source, "showLoginPanel", source)
        outputChatBox("You have been logged out.", source, 255, 255, 255)
    end
end
addEventHandler("onPlayerCommand", root, attemptLogout)