#!/usr/bin/lua

local testFramework = {}

function testFramework.equals(t1, t2)
    if type(t1) ~= type(t2) then return false end 
    if type(t1) == "nil" or type(t1) == "number" or type(t1) == "string" or 
            type(t1) == "boolean" then
        return t1 == t2
    elseif type(t1) == "table" then
        local visited = {}
        for key, value in pairs(t1) do
            if not t2[key] or t2[key] ~= value then
                return false
            end
            visited[key] = true
        end
        for key, value in pairs(t2) do
            if not visited[key] and (not t1[key] or t1[key] ~= value) then
                return false
            end
        end
    end
    return true
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
