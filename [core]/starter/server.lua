local priority = {
    "migrations",
    "cache",
    "pdo",
    "ranks",
    "users"
}

local function table.find(haystack, needle)
    for key, value in ipairs(haystack) do
        if (value == needle) then
            return i
        end
    end
    return false
end

local function getSortedResources(resources)
    local all = {}
    
    for key, name in ipairs(priority) do
        local resource = getResourceFromName(name)

        if resource then
            table.insert(all, resource)
        end
    end
    for key, resource in ipairs(resources) do
        if (not table.find(all, resource)) then
            table.insert(all, resource)
        end
    end
    return all
end

addEventHandler("onResourceStart", resourceRoot, function()
    local resources = getResources()
    local resources = getSortedResources(resources)

    for key, resource in ipairs(resources) do
        local name = getResourceName(resource)

        startResource(resource)

        if exports.migrations:usesMigrations(name) then
            local check = exports.migrations:check(name)

            if (not check) then
                exports.migrations:run(name)
            end
        end
    end
end)