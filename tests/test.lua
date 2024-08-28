#!/usr/bin/lua

local testFramework = require('tests.framework')

testFramework.addTestedModule("tableprinter", require('tests.lib.tableprinter'))
testFramework.addTestedModule("statistics",   require('tests.lib.statistics'))

testFramework.test()
