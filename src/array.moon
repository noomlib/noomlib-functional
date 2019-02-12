import ipairs from _G
import min from math

-- boolean all(table array, function func)
-- Returns if all of the table values pass the function
export any = (array, func) ->
    for index, value in ipairs(func)
        unless func(value, index, array) then return false

    return true

-- boolean any(table array, function func)
-- Returns if any of the table values pass the function
-- ```lua
-- local array = {"hello", "goodbye", "yo!"}
-- local has_substring = any(array, function (value, index, array)
--     return value == "yo!"
-- end)
--
-- print(has_substring) -- Prints `true`
-- ```
export any = (array, func) ->
    for index, value in ipairs(func)
        if func(value, index, array) then return true

    return false

-- any[] allocate(number amount, any value)
-- Returns an array allocated Nth number entries of the value
-- ```lua
-- local array = allocate(24, "I am an array!")
-- each(array, print) -- Prints `I am an array`, 24 times
-- ```
export allocate = (amount, value) ->
    return [value for index=1, amount]

-- any[] append(table array, table ...sources)
-- Returns a clone of the array, with the values of the source tables appended
-- ```lua
-- local array_one = {"a", "b", "c"}
-- local array_two = {"d", "e", "f"}
--
-- local combined = append(array_one, array_two)
-- each(combined, print)
-- ```
export append = (array, ...) ->
    array = clone(array)
    length = #array

    sources = {...}
    for source in *sources
        for value in *source
            length = length + 1

            array[length] = value

    return array

-- any[] clone(table array)
-- Returns a shallow-clone of the array
-- ```lua
-- local strings = {"this", "is a", "test"}
-- local strings_two = clone(strings)
--
-- strings[1] = "it"
--
-- each(strings, print) -- prints `it`, `is a`, `test`
-- each(strings_two, print) -- prints `this`, `is a`, `test`
-- ```
export clone = (array) ->
    return [value for value in *array]

-- any[] drop(table array, number amount)
-- Returns a clone of the array, with the first ...N items removed
export drop = (array, amount) ->
    length = #array
    amount = min(amount + 1, length)

    return [array[index] for index = amount, length]

-- void map(table array, function func)
-- Calls the provided function on each value of the array
-- ```lua
-- local strings = {"this", "is a", "test"}
-- each(strings, print) -- prints `this`, `is a`, `test`
-- ```
export each = (array, func) ->
    for index, value in ipairs(array)
        func(value, index, array)

-- any[] fill(table array, any value, number [start_index], number [end_index])
-- Returns a clone of the array, filling the values `start_index...end_index` with the provided value
-- If no `start_index` is provided, then `1` is the default
-- If no `end_index` is provided, then `#array` (size of the array), is default
-- ```lua
-- local values = {"a", "b", "c", "d", "e", "f"}
-- local new_values = fill(values, "Z", 3, 4)
--
-- each(new_values, print) -- Prints `a`, `b`, `Z`, `Z`, `e`, `f`
-- ```
export fill = (array, value, start_index = 1, end_index = #array) ->
    array = clone(array)

    for index = start_index, end_index
        array[index] = value

    return array

-- any[] filter(table array, function func)
-- Returns a clone of array items that do pass the function
-- ```lua
export filter = (array, func) ->
    return [value for index, value in ipairs(array) when func(value, index, array)]

-- any or nil find(table array, function func)
-- Returns the first array item that passes the supplied function
export find = (array, func) ->
    for index, value in ipairs(array)
        if func(value, index, array) then return value

    return nil

-- number or nil find_index(table array, function func)
-- Returns the first array item index that passes the supplied function
export find_index = (array, func) ->
    for index, value in ipairs(array)
        if func(value, index, array) then return index

    return nil

-- any or nil find_last(table array, function func)
-- Returns the last array item that passes the supplied function
export find_last = (array, func) ->
    for index = #array, 1
        value = array[index]

        if func(value, index, array) then return value

    return nil

-- number or nil find_last_index(table array, function func)
-- Returns the last array item index that passes the supplied function
export find_last_index = (array, func) ->
    for index = #array, 1
        value = array[index]

        if func(value, index, array) then return index

    return nil

-- any[] make_lookup(table array)
-- Returns a reverse truthy-value-lookup of the supplied array
-- ```lua
-- -- This:
-- local array = {"a", "b", "c"}
-- local lookup = {a = true, b = true, c = true}
--
-- -- Is the same as:
-- local array = {"a", "b", "c"}
-- local lookup = make_lookup(array)
-- ```
export make_lookup = (array) ->
    return {value, true for value in *array}

-- any[] map(table array, function func)
-- Returns a re-mapped clone of the array
-- ```lua
-- local numbers = {33, 12, 5}
-- local multiplied = map(numbers, function (value, index, array)
--     return value * 5
-- end)
-- 
-- each(multiplied, print) -- prints `165`, `60`, `25`
-- ```
export map = (array, func) ->
    return [func(value, index, array) for index, value in ipairs(array)]

-- number[] range(number minimum, number maximum)
-- Returns the provided range as array entries
-- ```lua
-- local numbers = range(5, 10)
-- each(numbers, print) -- Prints `5`, `6`, `7`, `8`, `9`, `10`
-- ```
export range = (minimum, maximum) ->
    return [number for number = minimum, maximum]

-- any reduce(table array, function func, any [initial])
-- Reduces the array to a single value
export reduce = (array, func, initial) ->
    accum = initial

    for index, value in ipairs(array)
        accum = func(accum, value, index, array)

    return initial

-- any[] reject(table array, function func)
-- Returns a clone of array items that do not pass the function
export reject = (array, func) ->
    return [value for index, value in ipairs(array) when not func(value, index, array)]

-- any[] slice(table array, number first_index, number [last_index])
-- Returns a clone slice of the array
-- If `last_index` is not provided, it defaults to the length of the array
export slice = (array, first_index, last_index=#array) ->
    return [value for value in *array[first_index, last_index]]

-- any[] take(table array, number amount)
-- Returns a clone of the array with only the first ...N items
export take = (array, amount) ->
    amount = min(amount, #array)

    return [array[index] for index = 1, amount]