#!/usr/bin/lua

local testFramework = require('tests/framework')
local printTable    = require('lib/tableprinter')
local statistics    = require('lib/statistics')

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
        local actual = statistics.frequencies(input.dataset, input.feature, input.normalized)

        -- this should never happen
        if not expected[i] then
            io.stderr:write("test does not have expected result associated!")
            os.exit(-1)
        end

        if not testFramework.equals(actual, expected[i]) then
            table.insert(errors, {
                actual = actual,
                expected = printTable(expected[i]),
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
        1.00000000,
        0.00000000,
        1.5612781244591,
        1.9056390622296,
    }

    local errors = {}

    for i, input in ipairs(inputs) do
        local actual = statistics.entropy(input)

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

function statisticsTests.testEntropySet()

    local inputs = {
        {
            set = {
                { ['previsione'] = 'Nuvoloso'  , ['temperatura'] = 'Alta' , ['umidita'] = 'Alta'   , ['vento'] = 'No', ['giocato'] = 'Si', },
            },
            feature = 'giocato'
        },
        {
            set = {
                { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Alta' , ['umidita'] = 'Alta'   , ['vento'] = 'No', ['giocato'] = 'No', },
                { ['previsione'] = 'Nuvoloso'  , ['temperatura'] = 'Bassa', ['umidita'] = 'Normale', ['vento'] = 'Si', ['giocato'] = 'Si', },
            },
            feature = 'giocato'
        },
        {
            set = {
                { ['previsione'] = 'Pioggia'   , ['temperatura'] = 'Bassa', ['umidita'] = 'Normale', ['vento'] = 'Si', ['giocato'] = 'No', },
                { ['previsione'] = 'Nuvoloso'  , ['temperatura'] = 'Bassa', ['umidita'] = 'Normale', ['vento'] = 'Si', ['giocato'] = 'Si', },
                { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Mite' , ['umidita'] = 'Alta'   , ['vento'] = 'No', ['giocato'] = 'No', },
                { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Bassa', ['umidita'] = 'Normale', ['vento'] = 'No', ['giocato'] = 'Si', },
                { ['previsione'] = 'Pioggia'   , ['temperatura'] = 'Mite' , ['umidita'] = 'Normale', ['vento'] = 'No', ['giocato'] = 'Si', },
                { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Mite' , ['umidita'] = 'Normale', ['vento'] = 'Si', ['giocato'] = 'Si', },
                { ['previsione'] = 'Nuvoloso'  , ['temperatura'] = 'Mite' , ['umidita'] = 'Alta'   , ['vento'] = 'Si', ['giocato'] = 'Si', },
                { ['previsione'] = 'Nuvoloso'  , ['temperatura'] = 'Alta' , ['umidita'] = 'Normale', ['vento'] = 'No', ['giocato'] = 'Si', },
                { ['previsione'] = 'Pioggia'   , ['temperatura'] = 'Mite' , ['umidita'] = 'Alta'   , ['vento'] = 'Si', ['giocato'] = 'No', },
            },
            feature = 'giocato'
        }
    }

    local expected = {
        '0.00000000',
        '1.00000000',
        '0.91829583',
    }

    local errors = {}

    for i, input in ipairs(inputs) do
        local actual = string.format('%.8f', statistics.entropySet(input.set, input.feature))

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

function statisticsTests.testWeightedMeanEntropySets()

    local inputs = {
        {
            sets = {
                {
                    { ['previsione'] = 'Nuvoloso', ['temperatura'] = 'Alta', ['umidita'] = 'Alta', ['vento'] = 'No', ['giocato'] = 'Si', },
                },
                {
                    { ['previsione'] = 'Nuvoloso', ['temperatura'] = 'Bassa', ['umidita'] = 'Normale', ['vento'] = 'Si', ['giocato'] = 'Si', },
                },
                {
                    { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Mite', ['umidita'] = 'Normale', ['vento'] = 'Si', ['giocato'] = 'Si', },
                }
            },
            feature = 'giocato'
        },
        {
            sets = {
                {
                    { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Alta', ['umidita'] = 'Alta', ['vento'] = 'No', ['giocato'] = 'No', },
                    { ['previsione'] = 'Nuvoloso', ['temperatura'] = 'Bassa', ['umidita'] = 'Normale', ['vento'] = 'Si', ['giocato'] = 'Si', },
                },
                {
                    { ['previsione'] = 'Nuvoloso', ['temperatura'] = 'Bassa', ['umidita'] = 'Normale', ['vento'] = 'Si', ['giocato'] = 'Si', },
                    { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Mite', ['umidita'] = 'Alta', ['vento'] = 'No', ['giocato'] = 'No', },
                },
                {
                    { ['previsione'] = 'Nuvoloso', ['temperatura'] = 'Alta', ['umidita'] = 'Normale', ['vento'] = 'No', ['giocato'] = 'Si', },
                    { ['previsione'] = 'Pioggia', ['temperatura'] = 'Mite', ['umidita'] = 'Alta', ['vento'] = 'Si', ['giocato'] = 'No', },
                }
            },
            feature = 'giocato'
        },
        {
            sets = {
                {
                    { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Alta' , ['umidita'] = 'Alta'   , ['vento'] = 'No', ['giocato'] = 'No', },
                    { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Alta' , ['umidita'] = 'Alta'   , ['vento'] = 'Si', ['giocato'] = 'No', },
                    { ['previsione'] = 'Nuvoloso'  , ['temperatura'] = 'Alta' , ['umidita'] = 'Alta'   , ['vento'] = 'No', ['giocato'] = 'Si', },
                    { ['previsione'] = 'Pioggia'   , ['temperatura'] = 'Mite' , ['umidita'] = 'Alta'   , ['vento'] = 'No', ['giocato'] = 'Si', },
                    { ['previsione'] = 'Pioggia'   , ['temperatura'] = 'Bassa', ['umidita'] = 'Normale', ['vento'] = 'No', ['giocato'] = 'Si', },
                    { ['previsione'] = 'Pioggia'   , ['temperatura'] = 'Bassa', ['umidita'] = 'Normale', ['vento'] = 'Si', ['giocato'] = 'No', },
                    { ['previsione'] = 'Nuvoloso'  , ['temperatura'] = 'Bassa', ['umidita'] = 'Normale', ['vento'] = 'Si', ['giocato'] = 'Si', },
                    { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Mite' , ['umidita'] = 'Alta'   , ['vento'] = 'No', ['giocato'] = 'No', },
                    { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Bassa', ['umidita'] = 'Normale', ['vento'] = 'No', ['giocato'] = 'Si', },
                    { ['previsione'] = 'Pioggia'   , ['temperatura'] = 'Mite' , ['umidita'] = 'Normale', ['vento'] = 'No', ['giocato'] = 'Si', },
                    { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Mite' , ['umidita'] = 'Normale', ['vento'] = 'Si', ['giocato'] = 'Si', },
                    { ['previsione'] = 'Nuvoloso'  , ['temperatura'] = 'Mite' , ['umidita'] = 'Alta'   , ['vento'] = 'Si', ['giocato'] = 'Si', },
                    { ['previsione'] = 'Nuvoloso'  , ['temperatura'] = 'Alta' , ['umidita'] = 'Normale', ['vento'] = 'No', ['giocato'] = 'Si', },
                    { ['previsione'] = 'Pioggia'   , ['temperatura'] = 'Mite' , ['umidita'] = 'Alta'   , ['vento'] = 'Si', ['giocato'] = 'No', },
                },
                {
                    { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Alta' , ['umidita'] = 'Alta'   , ['vento'] = 'No', ['giocato'] = 'Si', },
                    { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Alta' , ['umidita'] = 'Alta'   , ['vento'] = 'Si', ['giocato'] = 'No', },
                    { ['previsione'] = 'Nuvoloso'  , ['temperatura'] = 'Alta' , ['umidita'] = 'Alta'   , ['vento'] = 'No', ['giocato'] = 'No', },
                    { ['previsione'] = 'Pioggia'   , ['temperatura'] = 'Mite' , ['umidita'] = 'Alta'   , ['vento'] = 'No', ['giocato'] = 'No', },
                    { ['previsione'] = 'Pioggia'   , ['temperatura'] = 'Bassa', ['umidita'] = 'Normale', ['vento'] = 'No', ['giocato'] = 'No', },
                    { ['previsione'] = 'Pioggia'   , ['temperatura'] = 'Bassa', ['umidita'] = 'Normale', ['vento'] = 'Si', ['giocato'] = 'No', },
                    { ['previsione'] = 'Nuvoloso'  , ['temperatura'] = 'Bassa', ['umidita'] = 'Normale', ['vento'] = 'Si', ['giocato'] = 'No', },
                    { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Mite' , ['umidita'] = 'Alta'   , ['vento'] = 'No', ['giocato'] = 'No', },
                    { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Bassa', ['umidita'] = 'Normale', ['vento'] = 'No', ['giocato'] = 'No', },
                    { ['previsione'] = 'Pioggia'   , ['temperatura'] = 'Mite' , ['umidita'] = 'Normale', ['vento'] = 'No', ['giocato'] = 'No', },
                    { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Mite' , ['umidita'] = 'Normale', ['vento'] = 'Si', ['giocato'] = 'No', },
                    { ['previsione'] = 'Nuvoloso'  , ['temperatura'] = 'Mite' , ['umidita'] = 'Alta'   , ['vento'] = 'Si', ['giocato'] = 'No', },
                    { ['previsione'] = 'Nuvoloso'  , ['temperatura'] = 'Alta' , ['umidita'] = 'Normale', ['vento'] = 'No', ['giocato'] = 'No', },
                    { ['previsione'] = 'Pioggia'   , ['temperatura'] = 'Mite' , ['umidita'] = 'Alta'   , ['vento'] = 'Si', ['giocato'] = 'No', },
                },
                {
                    { ['previsione'] = 'Nuvoloso'  , ['temperatura'] = 'Alta' , ['umidita'] = 'Alta'   , ['vento'] = 'No', ['giocato'] = 'Si', },
                    { ['previsione'] = 'Pioggia'   , ['temperatura'] = 'Mite' , ['umidita'] = 'Alta'   , ['vento'] = 'No', ['giocato'] = 'Si', },
                    { ['previsione'] = 'Pioggia'   , ['temperatura'] = 'Bassa', ['umidita'] = 'Normale', ['vento'] = 'No', ['giocato'] = 'Si', },
                    { ['previsione'] = 'Pioggia'   , ['temperatura'] = 'Bassa', ['umidita'] = 'Normale', ['vento'] = 'Si', ['giocato'] = 'Si', },
                    { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Mite' , ['umidita'] = 'Alta'   , ['vento'] = 'No', ['giocato'] = 'No', },
                    { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Bassa', ['umidita'] = 'Normale', ['vento'] = 'No', ['giocato'] = 'Si', },
                    { ['previsione'] = 'Soleggiato', ['temperatura'] = 'Mite' , ['umidita'] = 'Normale', ['vento'] = 'Si', ['giocato'] = 'Si', },
                    { ['previsione'] = 'Nuvoloso'  , ['temperatura'] = 'Mite' , ['umidita'] = 'Alta'   , ['vento'] = 'Si', ['giocato'] = 'Si', },
                    { ['previsione'] = 'Nuvoloso'  , ['temperatura'] = 'Alta' , ['umidita'] = 'Normale', ['vento'] = 'No', ['giocato'] = 'Si', },
                }
            },
            feature = 'giocato'
        }
    }

    local expected = {
        '0.00000000',
        '1.00000000',
        '0.61866435',
    }
    
    local errors = {}

    for i, input in ipairs(inputs) do
        local actual = string.format('%.8f', statistics.weightedMeanEntropySets(input.sets, input.feature))

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
    { func = statisticsTests.testFrequencies,               name = "statisticsTests.testFrequencies" },
    { func = statisticsTests.testEntropy,                   name = "statisticsTests.testEntropy" },
    { func = statisticsTests.testEntropySet,                name = "statisticsTests.testEntropySet" },
    { func = statisticsTests.testWeightedMeanEntropySets,   name = "statisticsTests.testWeightedMeanEntropySets" },
}
