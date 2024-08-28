#!/usr/bin/lua

local testFramework = require('tests/framework')
local printTable    = require('lib/tableprinter')

local tableprinterTests = {}

function tableprinterTests.testPrintTable()

    local inputs = {
        {
            t = {
                'a string',
                'another string',
                'a third string'
            },
            indentSize = 4
        },
        {
            t = {
                person = {
                    name = 'marco'
                }
            },
            indentSize = 2
        },
    }

    local expected = {
        [[
{
    1: 'a string',
    2: 'another string',
    3: 'a third string',
}]],
        [[
{
  person: {
    name: 'marco',
  },
}]],
    }

    local errors = {}

    for i, input in ipairs(inputs) do
        local actual = printTable(input.t, input.indentSize)

        -- this should never happen
        if not expected[i] then
            io.stderr:write("test does not have expected result associated!")
            os.exit(-1)
        end

        if not testFramework.equals(actual, expected[i]) then
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
    { func = tableprinterTests.testPrintTable, name = "tableprinterTests.testPrintTable" },
}
