#!/usr/bin/lua

local testFramework = require('tests.framework')

require('tests.lib.pretty')
require('tests.lib.statistics')
require('tests.src.treebuilder')

testFramework.test()
