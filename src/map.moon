import pairs from _G

-- boolean all(table map, function func)
-- Returns if all of the values pass the provided function
export any = (map, func) ->
    for key, value in pairs(map)
        unless func(value, key, map) then return false

    return true

-- boolean any(table map, function func)
-- Returns if any of the values pass the provided function
export any = (map, func) ->
    for key, value in pairs(map)
        if func(value, key, map) then return true

    return false

-- table<any, any> assign(table map, table ...sources)
-- Returns a clone of the provided map, with all key, values of the source tables assigned
export assign = (map, ...) ->
    map = clone(map)

    sources = {...}
    for source in *sources
        for key, value in pairs(source)
            map[key] = value

    return map

-- table<any, any> clone(table map)
-- Returns a clone of the provided map
export clone = (map) ->
    return {key, value for key, value in pairs(map)}

-- void each(table map, function func)
-- Calls the provided function on each value of the map
export each = (map, func) ->
    for key, value in pairs(map)
        each(value, key, map)

-- table<any, any> filter(table map, function func)
-- Returns a clone of the map, with the values that pass the provided function
export filter = (map, func) ->
    return {key, value for key, value in pairs(map) when func(value, key, map)}

-- any[] keys(table map)
-- Returns an array of the keys in the map
export keys = (map) ->
    return [key for key, value in pairs(map)]

-- table<any, any> make_lookup(table map)
-- Returns a reverse value-lookup of the supplied map
-- ```lua
-- -- This:
-- local map = {a = 1, b = 2, c = 3}
-- local lookup = {[1] = "a", [2] = "b", [3] = "c"}
--
-- -- Is the same as:
-- local map = {a = 1, b = 2, c = 3}
-- local lookup = make_lookup(map)
-- ```
export make_lookup = (map) ->
    return {value, key for key, value in pairs(map)}

-- any[] map(table array, function func)
-- Returns a re-mapped clone of the map
export map = (map, func) ->
    return [func(value, key, array) for key, value in pairs(array)]

-- table<any, any> pick(table map, any[] keys)
-- Returns a clone of the map with only the given keys
export pick = (map, keys) ->
    new_map = {}

    for key in *keys
        new_map[key] = map[key]

    return new_map

-- any prop(any key, table map)
-- Returns matching key value of the map
export prop = (key, map) ->
    return map[key]

-- function prop_match(any prop, function or any check)
-- Returns a function that checks if the given key value mtches the provided `check` value or passes the `check` function
-- ```lua
-- local accounts = {
--     {name = "Lucy", cash = 322},
--     {name = "Mike", cash = 15},
--     {name = "Chuck", cash = 100}
-- }
--
-- -- Define a prop check that makes sure the user's account has more than $50 in cash
-- local checker = prop("cash", function (value, key, map)
--     return value > 50
-- end)
--
-- -- Run a filter with the checker, should only have the `Lucy` and `Chuck` accounts
-- local valid_accounts = filter(accounts, checker)
-- ```
export prop_match = (prop, check) ->
    unless type(check) == "function"
        _check = check

        check = (value, _, _) -> value == _check

    return (map) ->
        for key, value in pairs(map)
            if check(value, key, map) then return true

        return false

-- table<any, any> reject(table map, function func)
-- Returns a clone of the map, with values that fail the provided function
export reject = (map, func) ->
    return {key, value for key, value in pairs(map) when not func(value, key, map)}

-- any[] values(table map)
-- Returns an array of the values in the map
export values = (map) ->
    return [value for key, value in pairs(map)]