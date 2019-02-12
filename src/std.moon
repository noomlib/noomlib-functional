import select, unpack from _G

-- function bind(function func, any value)
-- Returns a function with the first argument bound to the value
export bind = (func, value) ->
    return (...) -> func(value, ...)

-- function bind_n(function func, any ...values)
-- Returns a function with the first arguments bound to the provided values
export bind_n = (func, ...) ->
    values = pack(...)

    return (...) -> func(unpack(values), ...)

-- function constant(any value)
-- Returns a function that only returns the provided value
export constant = (value) ->
    return () -> value

-- function constant(any ...values)
-- Returns a function that only returns the provided values
export constant_n = (...) ->
    values = pack(...)

    return (...) -> unpack(...)

-- any identity(any value)
-- Returns the arguments supplied to the function
export identity = (...) ->
    return ...

-- function once(function func)
-- Returns a function that calls the supplied function once, then caching the return values
export once = (func) ->
    local values

    return (...) ->
        unless values then values = pack(func(...))

        return unpack(values)

-- any[] of(any value)
-- Returns an array with the only item being the supplied value
export of = (value) ->
    return {value}

-- any[] pack(any ...values)
-- Returns a table of the provided values, properly handling `nil` values
export pack = (...) ->
    return {n: select("#", ...), ...}