#!/usr/bin/lua

local statistics = require('lib.statistics')

local treebuilder = {}

function treebuilder._split(set, feature)
    local groups = {}
    for _, elem in ipairs(set) do
        local value = elem[feature]
        groups[value] = groups[value] or {}
        groups[value][#groups[value] + 1] = elem
    end
    return groups
end

function treebuilder._splitByBestFeature(set, features, class)
    local bestSplit = { feature = nil, groups = nil }
    local bestFeatureIndex = nil
    local bestMeanEntropy = nil

    for i, feature in ipairs(features) do
        local groups = treebuilder._split(set, feature)
        local meanEntropy = statistics.weightedMeanEntropySets(groups, class)
        if not bestMeanEntropy or meanEntropy < bestMeanEntropy then
            bestFeatureIndex = i
            bestMeanEntropy = meanEntropy
            bestSplit.feature = feature
            bestSplit.groups = groups
        end
    end

    table.remove(features, bestFeatureIndex)
    return bestSplit
end

function treebuilder._getMostFrequentClass(set, class)
    local freqs = statistics.frequencies(set, class)
    local mostFrequentClass = { value = nil, freq = nil }

    for value, freq in pairs(freqs) do
        if not mostFrequentClass.value or freq > mostFrequentClass.freq then
            mostFrequentClass.value = value
            mostFrequentClass.freq = freq
        end
    end

    return mostFrequentClass.value
end

function treebuilder.buildTree(set, features, class)
    local node = {
        feature = nil,
        domain = nil,
        label = nil,
    }

    local entropy = statistics.entropySet(set, class)
    if entropy == 0 then
        node.label = set[1][class]
    elseif entropy > 0 and #features > 0 then
        local bestSplit = treebuilder._splitByBestFeature(set, features, class)
        for value, group in pairs(bestSplit.groups) do
            local childNode = treebuilder.buildTree(group, features, class)
            node.feature = bestSplit.feature
            node.domain = node.domain or {}
            node.domain[value] = childNode
        end
    elseif entropy > 0 and #features == 0 then
        node.label = treebuilder._getMostFrequentClass(set, class)
    end

    return node
end

return treebuilder
