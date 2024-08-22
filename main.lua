#!/usr/bin/lua

local data = {
    { ["name"] = "marco", ["cognome"] = "montali", ["anni"] = 20, },
    { ["name"] = "davide", ["cognome"] = "montali", ["anni"] = 20, },
}

local function frequencies(dataset, feature, normalize)
    normalize = normalize or false

    local freqs = {}
    local n = 0
    for _, elem in ipairs(dataset) do
        local value = elem[feature]
        if not freqs[value] then
            freqs[value] = 1
        else
            freqs[value] = freqs[value] + 1
        end
        n = n + 1
    end 

    if normalize then
        for value, freq in pairs(freqs) do
            freqs[value] = freq / n 
        end
    end

    return freqs
end

local function entropy(freqs) 
    local sum = 0
    for _, frequency in ipairs(freqs) do
        sum = sum + (frequency * math.log(frequency, 2))
    end
    return -sum
end

local function groupEntropy(group, feature)
    local freqs = frequencies(group, feature, true) 
    return entropy(freqs)
end

local function meanEntropy(groups, feature)
    local sum = 0
    local n = 0
    for _, group in pairs(groups) do
        sum = sum + groupEntropy(group, feature)
        n = n + 1
    end

    return sum / n
end

local function split(set, feature)
    local groups = {}
    for _, elem in ipairs(set) do
        local value = elem[feature]
        if not groups[value] then
            groups[value] = { elem }
        else
            table.insert(groups[value], elem)
        end
    end
    return groups
end

--local groups = split(data, "anni")
--for feature, group in pairs(groups) do
--    print(feature, ":")
--    for _, elem in ipairs(group) do
--        for key, value in pairs(elem) do
--            io.stdout:write(key, ": ", value, ", ")
--        end
--        print()
--    end
--end
--
--local freqs = frequencies(data, "anni")
--for value, freq in pairs(freqs) do
--    print(value, ": ", freq)
--end
