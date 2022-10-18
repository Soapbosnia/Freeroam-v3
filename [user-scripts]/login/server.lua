local function attemptLogin(username, password)
    local user = exports.users:getUserByUsername(username)

    if user then
        local actualPassword = exports.users:getUserPassword(user.id)

        if (md5(password) == actualPassword) then
            triggerEvent("onUserLogin", source, source, user)
            triggerClientEvent(source, "hideLoginSections", source)
            setElementData(source, "logged-in", true)
            exports.spawner:loadPlayer(source)
        end
    end
end
addEvent("attemptLogin", true)
addEventHandler("attemptLogin", root, attemptLogin)

local function attemptRegister(username, password, email, nickname)
    -- TODO: Check if username, email, or nickname is already taken
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