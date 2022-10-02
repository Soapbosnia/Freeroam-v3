function onStart()
    print("Called")
    local resources = getResources()
    for key, resource in ipairs(resources) do
        startResource(resource)
    end
end
addEventHandler("onResourceStart", resourceRoot, onStart)