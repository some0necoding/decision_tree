#!/usr/bin/lua

local printTable = require('lib/tableprinter')
local statistics = require('lib/statistics')

local data = {
    { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Alta' , ['umidita'] = 'Alta'   , ['vento'] = 'No', ['giocato'] = 'No', },
    { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Alta' , ['umidita'] = 'Alta'   , ['vento'] = 'Si', ['giocato'] = 'No', },
    { ['previsione'] = 'Nuvoloso'  , ['temperatura'] = 'Alta' , ['umidita'] = 'Alta'   , ['vento'] = 'No', ['giocato'] = 'Si', },
    { ['previsione'] = 'Pioggia'   , ['temperatura'] = 'Mite' , ['umidita'] = 'Alta'   , ['vento'] = 'No', ['giocato'] = 'Si', },
    { ['previsione'] = 'Pioggia'   , ['temperatura'] = 'Bassa', ['umidita'] = 'Normale', ['vento'] = 'No', ['giocato'] = 'Si', },
    { ['previsione'] = 'Pioggia'   , ['temperatura'] = 'Bassa', ['umidita'] = 'Normale', ['vento'] = 'Si', ['giocato'] = 'No', },
    { ['previsione'] = 'Nuvoloso'  , ['temperatura'] = 'Bassa', ['umidita'] = 'Normale', ['vento'] = 'Si', ['giocato'] = 'Si', },
    { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Mite' , ['umidita'] = 'Alta'   , ['vento'] = 'No', ['giocato'] = 'No', },
    { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Bassa', ['umidita'] = 'Normale', ['vento'] = 'No', ['giocato'] = 'Si', },
    { ['previsione'] = 'Pioggia'   , ['temperatura'] = 'Mite' , ['umidita'] = 'Normale', ['vento'] = 'No', ['giocato'] = 'Si', },
    { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Mite' , ['umidita'] = 'Normale', ['vento'] = 'Si', ['giocato'] = 'Si', },
    { ['previsione'] = 'Nuvoloso'  , ['temperatura'] = 'Mite' , ['umidita'] = 'Alta'   , ['vento'] = 'Si', ['giocato'] = 'Si', },
    { ['previsione'] = 'Nuvoloso'  , ['temperatura'] = 'Alta' , ['umidita'] = 'Normale', ['vento'] = 'No', ['giocato'] = 'Si', },
    { ['previsione'] = 'Pioggia'   , ['temperatura'] = 'Mite' , ['umidita'] = 'Alta'   , ['vento'] = 'Si', ['giocato'] = 'No', },
}

local function entropy(set, feature)
    local freqs = statistics.frequencies(set, feature, true)
    i = 1
    for value, freq in pairs(freqs) do
        freqs[i] = freq
        i = i + 1
    end
    return statistics.entropy(freqs)
end

local function WeightedMeanEntropy(sets, feature)
    local sum = 0
    local totalElements = 0
    for _, set in pairs(sets) do
        local setElements = #set -- this assumes that a set is a sequence
        totalElements = totalElements + setElements
        sum = sum + (setElements * entropy(set, feature))
    end

    return sum / totalElements
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

local function splitByBestFeature(set, features, class)
    local best = {
        meanEntropy = nil,
        feature = nil,
        groups = nil,
    }

    local bestFeatureIndex = nil
    for i, feature in ipairs(features) do
        local groups = split(set, feature)
        local meanEntropy = WeightedMeanEntropy(groups, class)
        if not best.meanEntropy or meanEntropy < best.meanEntropy then
            best.meanEntropy = meanEntropy
            best.feature = feature
            best.groups = groups
            bestFeatureIndex = i
        end
    end

    table.remove(features, bestFeatureIndex)
    return best
end

local function getMostFrequentClass(set, class)
    local freqs = statistics.frequencies(set, class)
    local mostFrequentClass = { value = nil, freq = nil }

    for value, freq in pairs(freqs) do
        if not mostFrequentClass.value or freq > mostFrequentClass.freq then
            mostFrequentClass.value = value
            mostFrequentClass.freq = freq
        end
    end

    return mostFrequentClass
end

local function buildTree(set, features, class)
    local node = {
        feature = nil,
        domain = nil,
        label = nil,
    }

    local e = entropy(set, class)
    if e == 0 then
        node.label = set[1][class]
    elseif e > 0 and #features > 0 then
        local bestSplit = splitByBestFeature(set, features, class)
        for value, group in pairs(bestSplit.groups) do
            local childNode = buildTree(group, features, class)
            node.feature = bestSplit.feature
            if not node.domain then
                node.domain = {}
            end
            node.domain[value] = childNode
        end
    elseif e > 0 and #features == 0 then
        node.label = getMostFrequentClass(set, class)
    end

    return node
end

local tree = buildTree(data, { "previsione", "temperatura", "umidita", "vento" }, "giocato")
print(printTable(tree))
