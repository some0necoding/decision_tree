#!/usr/bin/lua

local printTable = require('lib/tableprinter')
local statistics = require('lib/statistics')

local statisticsTests = {}

function statisticsTests.testFrequencies()

    local inputs = {
        {
            dataset = {
                { ["name"] = "apple" },
                { ["name"] = "apple" },
                { ["name"] = "apple" },
                { ["name"] = "banana" },
                { ["name"] = "banana" },
                { ["name"] = "orange" },
                { ["name"] = "banana" },
                { ["name"] = "orange" },
            },
            feature = "name",
            normalized = false,
        },
        {
            dataset = {
                { ["name"] = "apple" },
                { ["name"] = "apple" },
                { ["name"] = "apple" },
                { ["name"] = "banana" },
                { ["name"] = "banana" },
                { ["name"] = "orange" },
                { ["name"] = "banana" },
                { ["name"] = "orange" },
            },
            feature = "name",
            normalized = true,
        },
    }

    local expected = {
        {
            ["apple"] = 3,
            ["banana"] = 3,
            ["orange"] = 2,
        },
        {
            ["apple"] = 0.375,
            ["banana"] = 0.375,
            ["orange"] = 0.25,
        }
    }

    local errors = {}

    for i, input in ipairs(inputs) do
        local actual = printTable(statistics.frequencies(input.dataset, input.feature, input.normalized))

        -- this should never happen
        if not expected[i] then
            io.stderr:write("test does not have expected result associated!")
            os.exit(-1)
        end

        local e = printTable(expected[i])
        if actual ~= e then
            table.insert(errors, {
                actual = actual,
                expected = e,
                input = printTable(input)
            }) 
        end
    end

    return errors
end

function statisticsTests.testEntropy()

    local inputs = {
        { 0.5, 0.5, },
        { 1, 0, },
        { 0.375, 0.375, 0.25 },
        { 0.25, 0.375, 0.25, 0.125 },
    }

    local expected = {
        '1.00000000',
        '0.00000000',
        '1.56127812',
        '1.90563906',
    }

    local errors = {}

    for i, input in ipairs(inputs) do
        local actual = string.format('%.8f', statistics.entropy(input))

        -- this should never happen
        if not expected[i] then
            io.stderr:write("test does not have expected result associated!")
            os.exit(-1)
        end

        if actual ~= expected[i] then
            table.insert(errors, {
                actual = actual,
                expected = expected[i],
                input = printTable(input)
            }) 
        end
    end

    return errors
end

return {
    { func = statisticsTests.testFrequencies,     name = "statisticsTests.testFrequencies" },
    { func = statisticsTests.testEntropy,         name = "statisticsTests.testEntropy" },
}
