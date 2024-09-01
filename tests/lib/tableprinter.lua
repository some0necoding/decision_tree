#!/usr/bin/lua

local testFramework = require('tests.framework')
local printTable    = require('lib.tableprinter')

local tableprinterTests = testFramework.newTestModule('tableprinter')

do
    local inputs = {
        {
            {
                'a string',
                'another string',
                'a third string'
            },
            4
        },
        {
            {
                person = {
                    name = 'marco'
                }
            },
            2
        },
    }

    local expected = {
        {
            [[
{
    1: 'a string',
    2: 'another string',
    3: 'a third string',
}]]
        },
        {
            [[
{
  person: {
    name: 'marco',
  },
}]]
        },
    }

    tableprinterTests.addTest(inputs, expected, printTable, 'printTable')
end
