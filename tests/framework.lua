#!/usr/bin/lua

local printTable = require('lib.tableprinter')
local testFramework = {}

function testFramework.equals(t1, t2)
    if type(t1) ~= type(t2) then return false end
    if type(t1) == "nil" or type(t1) == "string" or type(t1) == "boolean" then
        return t1 == t2
    elseif type(t1) == "number" then
        t1 = string.format('%.12f', t1)
        t2 = string.format('%.12f', t2)
        return t1 == t2
    elseif type(t1) == "table" then
        local visited = {}
        for key, value in pairs(t1) do
            if not t2[key] or not testFramework.equals(t2[key], value) then
                return false
            end
            visited[key] = true
        end
        for key, value in pairs(t2) do
            if not visited[key] and (not t1[key] or not testFramework.equals(t1[key], value)) then
                return false
            end
        end
    end
    return true
end

local function collect(...)
    local results = {}
    for _, result in ipairs({...}) do
        results[#results + 1] = result
    end
    return results
end

function testFramework.createTest(inputs, outputs, func)
    return function ()
        local errors = {}

        for i, input in ipairs(inputs) do
            local results = collect(func(table.unpack(input)))

            -- this should not happen
            if not outputs[i] then
                error("test does not have expected result associated!")
            end

            if not testFramework.equals(results, outputs[i]) then
                table.insert(errors, {
                    actual = results,
                    expected = outputs[i],
                    input = input
                })
            end
        end

        return errors
    end
end

local testedModules = {}

function testFramework.addTestedModule(name, tests)
    table.insert(testedModules, {
        name = name,
        tests = tests,
    })
end

function testFramework.test()
    for _, testedModule in pairs(testedModules) do
        print("== Testing " .. testedModule.name)
        for _, test in ipairs(testedModule.tests) do
            local errors = test.func()
            if #errors == 0 then
                print("--- PASS ", test.name)
            else
                print("!!! FAIL ", test.name)
                for _, error in ipairs(errors) do
                    print("actual:")
                    print(error.actual)
                    print("expected:")
                    print(error.expected)
                    print("inputs:")
                    print(error.input)
                end
            end
        end
    end
end

return testFramework
