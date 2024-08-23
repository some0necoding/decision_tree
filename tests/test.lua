#!/usr/bin/lua

local printTable = require('lib/tableprinter')

local testedModules = {
    { name = "tableprinter", tests = require('tests/lib/tableprinter') },
}

local function executeTests()
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
                    print(printTable(error.input))
                end
            end
        end
    end
end

executeTests()
