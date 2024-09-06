#!/usr/bin/lua

local treebuilder = require('src.treebuilder')

local decisionTree = {}
local tree = nil

function decisionTree.fit(set, features, class)
    tree = treebuilder.buildTree(set, features, class)
end

function decisionTree.predict(record)
    if not tree then return end
    while tree.label == nil do
        local feature = tree.feature
        local v = record[feature]
        for value, node in pairs(tree.domain) do
            if v == value then
                tree = node
                break
            end
        end
    end
    return tree.label
end

return decisionTree
