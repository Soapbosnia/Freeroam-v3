function run(script, file)
    local file = file or "default"

    if script then
        local handle = fileOpen(":"..script.."/migrations/"..file..".json")

        if handle then
            local size = fileGetSize(handle)
            local data = fileRead(handle, size)
            
            if data then
                local data = fromJSON(data)

                for key, value in pairs(data) do
                    fileClose(handle)
                    return {true, exports[script]:create(unpack(value))}
                end
            end
            fileClose(handle)
        end
    end
    return {false, "Unexpected error occured"}
end

function usesMigrations(script)
    local handle = fileOpen(":"..script.."/migrations/default.json")
    if handle then
        fileClose(handle)
        return true
    end
    return false
end

function check(script)
    local handle = fileOpen("data/run.json")

    if handle then
        local size = fileGetSize(handle)
        local data = fileRead(handle, size)

        if data then
            local data = fromJSON(data)

            if data then
                if data[script] then
                    fileClose(handle)
                    return true
                end
            end
        end
        fileClose(handle)
    end
    return false
end

local function migrateCommand(player, command, script, file)
    if script then
        if type(player == "string") then
            if (player == "Console") then
                if (not usesMigrations(script)) then
                    return outputConsole("The resource "..script.." does not use migrations")
                end
                local result = run(script, file)
                if result[1] then
                    outputConsole("[Migrations|("..script..")] Migration successful!")
                else
                    outputConsole("[Migrations|("..script..")] Migration failed: "..result[2])
                end
            end
        else
            local rank = exports.cache:get(player, "rank")
            local canMigrate = exports.ranks:hasRankPermission(rank, "script.migrate")

            if canMigrate then
                if (not usesMigrations(script)) then
                    return outputChatBox("The resource "..script.." does not use migrations")
                end
                local result = run(script, file)
                if result[1] then
                    outputChatBox("[Migrations|("..script..")] Migration successful!", player, 0, 255, 0)
                else
                    outputChatBox("[Migrations|("..script..")] Migration failed: "..result[2], player, 255, 0, 0)
                end
            else
                outputChatBox("You aren't authorized to use that command.", player, 255, 0, 0)
            end
        end
    end
    return outputChatBox("Usage: /migrate [script] [file(optional)]", player, 200, 0, 0)
end
addCommandHandler("migrate", migrateCommand)