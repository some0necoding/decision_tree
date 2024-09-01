#!/usr/bin/lua

local testFramework = require('tests.framework')
local pretty        = require('lib.pretty')

local prettyTests = testFramework.newTestModule('pretty')

do
    local inputs = {
        {
            10
        },
        {
            1.0987345
        },
        {
            'a string'
        },
        {
            true
        },
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
            '10'
        },
        {
            '1.0987345'
        },
        {
            '\'a string\''
        },
        {
            'true'
        },
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

    prettyTests.addTest(inputs, expected, pretty.tostring, 'tostring')
end
