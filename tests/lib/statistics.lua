#!/usr/bin/lua

local testFramework = require('tests.framework')
local statistics    = require('lib.statistics')

local statisticsTests = testFramework.newTestModule('statistics')

-- add statistics.frequencies() tests
do
    local inputs = {
        {
            {
                { name = 'apple' },
                { name = 'apple' },
                { name = 'apple' },
                { name = 'banana' },
                { name = 'banana' },
                { name = 'orange' },
                { name = 'banana' },
                { name = 'orange' },
            },
            'name',
            false,
        },
        {
            {
                { name = 'apple' },
                { name = 'apple' },
                { name = 'apple' },
                { name = 'banana' },
                { name = 'banana' },
                { name = 'orange' },
                { name = 'banana' },
                { name = 'orange' },
            },
            'name',
            true,
        },
    }

    local expected = {
        {
            {
                apple = 3,
                banana = 3,
                orange = 2,
            },
        },
        {
            {
                apple = 0.375,
                banana = 0.375,
                orange = 0.25,
            }
        }
    }

    statisticsTests.addTest(inputs, expected, statistics.frequencies, 'frequencies')
end

-- add statistics.entropy() tests
do
    local inputs = {
        {{ 0.5, 0.5, }},
        {{ 1, 0, }},
        {{ 0.375, 0.375, 0.25 }},
        {{ 0.25, 0.375, 0.25, 0.125 }},
    }

    local expected = {
        { 1.00000000 },
        { 0.00000000 },
        { 1.5612781244591 },
        { 1.9056390622296 },
    }

    statisticsTests.addTest(inputs, expected, statistics.entropy, 'entropy')
end

-- add statistics.entropySet() tests
do
    local inputs = {
        {
            {
                { previsione = 'Nuvoloso', temperatura = 'Alta', umidita = 'Alta', vento = 'No', giocato = 'Si', },
            },
            'giocato'
        },
        {
            {
                { previsione = 'Soleggiato', temperatura = 'Alta' , umidita = 'Alta'   , vento = 'No', giocato = 'No', },
                { previsione = 'Nuvoloso'  , temperatura = 'Bassa', umidita = 'Normale', vento = 'Si', giocato = 'Si', },
            },
            'giocato'
        },
        {
            {
                { previsione = 'Pioggia'   , temperatura = 'Bassa', umidita = 'Normale', vento = 'Si', giocato = 'No', },
                { previsione = 'Nuvoloso'  , temperatura = 'Bassa', umidita = 'Normale', vento = 'Si', giocato = 'Si', },
                { previsione = 'Soleggiato', temperatura = 'Mite' , umidita = 'Alta'   , vento = 'No', giocato = 'No', },
                { previsione = 'Soleggiato', temperatura = 'Bassa', umidita = 'Normale', vento = 'No', giocato = 'Si', },
                { previsione = 'Pioggia'   , temperatura = 'Mite' , umidita = 'Normale', vento = 'No', giocato = 'Si', },
                { previsione = 'Soleggiato', temperatura = 'Mite' , umidita = 'Normale', vento = 'Si', giocato = 'Si', },
                { previsione = 'Nuvoloso'  , temperatura = 'Mite' , umidita = 'Alta'   , vento = 'Si', giocato = 'Si', },
                { previsione = 'Nuvoloso'  , temperatura = 'Alta' , umidita = 'Normale', vento = 'No', giocato = 'Si', },
                { previsione = 'Pioggia'   , temperatura = 'Mite' , umidita = 'Alta'   , vento = 'Si', giocato = 'No', },
            },
            'giocato'
        }
    }

    local expected = {
        { 0.00000000 },
        { 1.00000000 },
        { 0.91829583405449 },
    }

    statisticsTests.addTest(inputs, expected, statistics.entropySet, 'entropySet')
end

-- add statistics.weightedMeanEntropySets() tests
do
    local inputs = {
        {
            {
                {
                    { previsione = 'Nuvoloso', temperatura = 'Alta', umidita = 'Alta', vento = 'No', giocato = 'Si', },
                },
                {
                    { previsione = 'Nuvoloso', temperatura = 'Bassa', umidita = 'Normale', vento = 'Si', giocato = 'Si', },
                },
                {
                    { previsione = 'Soleggiato', temperatura = 'Mite', umidita = 'Normale', vento = 'Si', giocato = 'Si', },
                }
            },
            'giocato'
        },
        {
            {
                {
                    { previsione = 'Soleggiato', temperatura = 'Alta' , umidita = 'Alta'   , vento = 'No', giocato = 'No', },
                    { previsione = 'Nuvoloso'  , temperatura = 'Bassa', umidita = 'Normale', vento = 'Si', giocato = 'Si', },
                },
                {
                    { previsione = 'Nuvoloso'  , temperatura = 'Bassa', umidita = 'Normale', vento = 'Si', giocato = 'Si', },
                    { previsione = 'Soleggiato', temperatura = 'Mite' , umidita = 'Alta'   , vento = 'No', giocato = 'No', },
                },
                {
                    { previsione = 'Nuvoloso', temperatura = 'Alta', umidita = 'Normale', vento = 'No', giocato = 'Si', },
                    { previsione = 'Pioggia' , temperatura = 'Mite', umidita = 'Alta'   , vento = 'Si', giocato = 'No', },
                }
            },
            'giocato'
        },
        {
            {
                {
                    { previsione = 'Soleggiato', temperatura = 'Alta' , umidita = 'Alta'   , vento = 'No', giocato = 'No', },
                    { previsione = 'Soleggiato', temperatura = 'Alta' , umidita = 'Alta'   , vento = 'Si', giocato = 'No', },
                    { previsione = 'Nuvoloso'  , temperatura = 'Alta' , umidita = 'Alta'   , vento = 'No', giocato = 'Si', },
                    { previsione = 'Pioggia'   , temperatura = 'Mite' , umidita = 'Alta'   , vento = 'No', giocato = 'Si', },
                    { previsione = 'Pioggia'   , temperatura = 'Bassa', umidita = 'Normale', vento = 'No', giocato = 'Si', },
                    { previsione = 'Pioggia'   , temperatura = 'Bassa', umidita = 'Normale', vento = 'Si', giocato = 'No', },
                    { previsione = 'Nuvoloso'  , temperatura = 'Bassa', umidita = 'Normale', vento = 'Si', giocato = 'Si', },
                    { previsione = 'Soleggiato', temperatura = 'Mite' , umidita = 'Alta'   , vento = 'No', giocato = 'No', },
                    { previsione = 'Soleggiato', temperatura = 'Bassa', umidita = 'Normale', vento = 'No', giocato = 'Si', },
                    { previsione = 'Pioggia'   , temperatura = 'Mite' , umidita = 'Normale', vento = 'No', giocato = 'Si', },
                    { previsione = 'Soleggiato', temperatura = 'Mite' , umidita = 'Normale', vento = 'Si', giocato = 'Si', },
                    { previsione = 'Nuvoloso'  , temperatura = 'Mite' , umidita = 'Alta'   , vento = 'Si', giocato = 'Si', },
                    { previsione = 'Nuvoloso'  , temperatura = 'Alta' , umidita = 'Normale', vento = 'No', giocato = 'Si', },
                    { previsione = 'Pioggia'   , temperatura = 'Mite' , umidita = 'Alta'   , vento = 'Si', giocato = 'No', },
                },
                {
                    { previsione = 'Soleggiato', temperatura = 'Alta' , umidita = 'Alta'   , vento = 'No', giocato = 'Si', },
                    { previsione = 'Soleggiato', temperatura = 'Alta' , umidita = 'Alta'   , vento = 'Si', giocato = 'No', },
                    { previsione = 'Nuvoloso'  , temperatura = 'Alta' , umidita = 'Alta'   , vento = 'No', giocato = 'No', },
                    { previsione = 'Pioggia'   , temperatura = 'Mite' , umidita = 'Alta'   , vento = 'No', giocato = 'No', },
                    { previsione = 'Pioggia'   , temperatura = 'Bassa', umidita = 'Normale', vento = 'No', giocato = 'No', },
                    { previsione = 'Pioggia'   , temperatura = 'Bassa', umidita = 'Normale', vento = 'Si', giocato = 'No', },
                    { previsione = 'Nuvoloso'  , temperatura = 'Bassa', umidita = 'Normale', vento = 'Si', giocato = 'No', },
                    { previsione = 'Soleggiato', temperatura = 'Mite' , umidita = 'Alta'   , vento = 'No', giocato = 'No', },
                    { previsione = 'Soleggiato', temperatura = 'Bassa', umidita = 'Normale', vento = 'No', giocato = 'No', },
                    { previsione = 'Pioggia'   , temperatura = 'Mite' , umidita = 'Normale', vento = 'No', giocato = 'No', },
                    { previsione = 'Soleggiato', temperatura = 'Mite' , umidita = 'Normale', vento = 'Si', giocato = 'No', },
                    { previsione = 'Nuvoloso'  , temperatura = 'Mite' , umidita = 'Alta'   , vento = 'Si', giocato = 'No', },
                    { previsione = 'Nuvoloso'  , temperatura = 'Alta' , umidita = 'Normale', vento = 'No', giocato = 'No', },
                    { previsione = 'Pioggia'   , temperatura = 'Mite' , umidita = 'Alta'   , vento = 'Si', giocato = 'No', },
                },
                {
                    { previsione = 'Nuvoloso'  , temperatura = 'Alta' , umidita = 'Alta'   , vento = 'No', giocato = 'Si', },
                    { previsione = 'Pioggia'   , temperatura = 'Mite' , umidita = 'Alta'   , vento = 'No', giocato = 'Si', },
                    { previsione = 'Pioggia'   , temperatura = 'Bassa', umidita = 'Normale', vento = 'No', giocato = 'Si', },
                    { previsione = 'Pioggia'   , temperatura = 'Bassa', umidita = 'Normale', vento = 'Si', giocato = 'Si', },
                    { previsione = 'Soleggiato', temperatura = 'Mite' , umidita = 'Alta'   , vento = 'No', giocato = 'No', },
                    { previsione = 'Soleggiato', temperatura = 'Bassa', umidita = 'Normale', vento = 'No', giocato = 'Si', },
                    { previsione = 'Soleggiato', temperatura = 'Mite' , umidita = 'Normale', vento = 'Si', giocato = 'Si', },
                    { previsione = 'Nuvoloso'  , temperatura = 'Mite' , umidita = 'Alta'   , vento = 'Si', giocato = 'Si', },
                    { previsione = 'Nuvoloso'  , temperatura = 'Alta' , umidita = 'Normale', vento = 'No', giocato = 'Si', },
                }
            },
            'giocato'
        }
    }

    local expected = {
        { 0.00000000 },
        { 1.00000000 },
        { 0.61866435154978 },
    }

    statisticsTests.addTest(inputs, expected, statistics.weightedMeanEntropySets, 'weightedMeanEntropySets')
end
