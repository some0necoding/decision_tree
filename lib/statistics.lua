#!/usr/bin/lua

local statistics = {}

function statistics.frequencies(set, feature, normalize)
    normalize = normalize or false

    local freqs = {}
    local n = 0
    for _, elem in ipairs(set) do
        local value = elem[feature]
        if not freqs[value] then
            freqs[value] = 1
        else
            freqs[value] = freqs[value] + 1
        end

        if normalize then
            n = n + 1
        end
    end 

    if normalize then
        for value, freq in pairs(freqs) do
            freqs[value] = freq / n 
        end
    end

    return freqs
end

function statistics.entropy(freqs) 
    local sum = 0
    for _, frequency in ipairs(freqs) do
        if frequency ~= 0 then
            sum = sum + (frequency * math.log(frequency, 2))
        end
    end
    return sum < 0 and -sum or 0
end

function statistics.entropySet(set, feature)
    local freqs = statistics.frequencies(set, feature, true)
    local i = 1
    for _, freq in pairs(freqs) do
        freqs[i] = freq
        i = i + 1
    end
    return statistics.entropy(freqs)
end

function statistics.weightedMeanEntropySets(sets, feature)
    local sum = 0
    local totalElements = 0
    for _, set in pairs(sets) do
        local setElements = #set -- this assumes that a set is a sequence
        totalElements = totalElements + setElements
        sum = sum + (setElements * statistics.entropySet(set, feature))
    end

    return sum / totalElements
end

return statistics
