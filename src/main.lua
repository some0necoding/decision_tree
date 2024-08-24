#!/usr/bin/lua

local statistics = require('lib/statistics')

local data = {
    { ["name"] = "marco", ["cognome"] = "montali", ["anni"] = 20, },
    { ["name"] = "davide", ["cognome"] = "montali", ["anni"] = 20, },
}

local function groupEntropy(group, feature)
    local freqs = statistics.frequencies(group, feature, true) 
    return statistics.entropy(freqs)
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
