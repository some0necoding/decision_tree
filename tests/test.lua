#!/usr/bin/lua

dofile('main.lua')

local function compareDatasets(d1, d2)
    for i, elem1 in ipairs(d1) do
        local elem2 = d2[i]
        if not elem2 then
            return false
        end
        for key, value in pairs(elem1) do
            if not elem2[key] or elem2[key] ~= value then
                return false
            end
        end
    end 

    return true
end

local function testCompareDatasets()

    local inputs = {
        {
            { ["name"] = "apple" },
            { ["name"] = "apple" },
            { ["name"] = "apple" },
            { ["name"] = "banana" },
            { ["name"] = "banana" },
            { ["name"] = "orange" },
            { ["name"] = "banana" },
            { ["name"] = "orange" },
        },
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

    for _, input in ipairs(inputs) do
        if not compareDatasets(input, input) then
            return false
        end
    end

    for i = 1, #inputs - 1 do
        local d1 = inputs[i] 
        local d2 = inputs[i + 1] 
        if compareDatasets(d1, d2) then
            return false
        end
    end

    return true
end

local function testFrequencies()

    local input = {
        { ["name"] = "apple" },
        { ["name"] = "apple" },
        { ["name"] = "apple" },
        { ["name"] = "banana" },
        { ["name"] = "banana" },
        { ["name"] = "orange" },
        { ["name"] = "banana" },
        { ["name"] = "orange" },
    }

    local output = {
        ["apple"] = 3,
        ["banana"] = 3,
        ["orange"] = 2,
    }

    local normalizedOutput = {
        ["apple"] = 0.375,
        ["banana"] = 0.375,
        ["orange"] = 0.25,
    }


    
end

local tests = {
    { func = testCompareDatasets, name = "testCompareDatasets" },
}

local function executeTest()
    for _, test in pairs(tests) do
        if test.func() then
            print("PASS ", test.name)
        else
            print("FAIL ", test.name)
        end
    end
end

executeTest()
