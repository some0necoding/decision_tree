#!/usr/bin/lua

local statistics = {}

function statistics.frequencies(dataset, feature, normalize)
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

function statistics.entropy(freqs) 
    local sum = 0
    for _, frequency in ipairs(freqs) do
        if frequency ~= 0 then
            sum = sum + (frequency * math.log(frequency, 2))
        end
    end
    return sum < 0 and -sum or 0
end

return statistics
