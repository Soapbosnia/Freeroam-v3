local cache = {}

function set(element, key, value)
    if (not cache[element]) then
        cache[element] = {}
    end
    cache[element][key] = value
end

function get(element, key)
    if (cache[element]) then
        return {true, cache[element][key]}
    end
    return {nil, "Cache storage for the specified element does not exist"}
end

function clear(element, key)
    if key then
        cache[element][key] = nil
    else
        cache[element] = nil
    end
end