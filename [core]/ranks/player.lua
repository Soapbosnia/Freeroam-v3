local function onLogin(player, account)
    local rank = getUserRank(account)
    exports.cache:set(player, "rank", rank)
end
addEvent("onUserLogin", true)
addEventHandler("onUserLogin", root, onLogin)

local function onLogout(player, account)
    exports.cache:set(player, "rank", 3)
end
addEvent("onUserLogout", true)
addEventHandler("onUserLogout", root, onLogout)

local function onQuit()
    local account = exports.cache:get(source, "account")
    if account then
        exports.cache:clear(source, "rank")
    end
end
addEventHandler("onPlayerQuit", root, onQuit)