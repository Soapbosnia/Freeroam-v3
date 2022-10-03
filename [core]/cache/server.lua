local cache = {}

function set(key, value)
    cache[key] = value
end

function get(key)
    return cache[key]
end

function clear(key)
    cache[key] = nil
end