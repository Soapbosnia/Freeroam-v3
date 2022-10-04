local function onLogin(player, account)
    exports.cache:set(player, "account", account)
end
addEvent("onUserLogin", true)
addEventHandler("onUserLogin", root, onLogin)

local function onLogout(player, account)
    exports.cache:clear(player, "account")
end
addEvent("onUserLogout", true)
addEventHandler("onUserLogout", root, onLogout)

local function onQuit()
    local account = exports.cache:get(source, "account")
    if account then
        exports.cache:clear(source, "account")
    end
end
addEventHandler("onPlayerQuit", root, onQuit)