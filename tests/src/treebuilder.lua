#!/usr/bin/lua

local testFramework = require('tests.framework')
local treebuilder   = require('src.treebuilder')

local treebuilderTests = testFramework.newTestModule('treebuilder')

-- add treebuilder._split tests
do
    local inputs = {
        {
             {
                { sorgente = 1, oro = 0, durezza = 21.20138141309851 },
                { sorgente = 2, oro = 1, durezza = 21.317378433002634 },
             },
             'oro'
        },
        {
            {
                { sorgente = 1, oro = 0, durezza = 21.20138141309851 },
                { sorgente = 1, oro = 0, durezza = 25.29466190715501 },
                { sorgente = 1, oro = 4, durezza = 12.435278700238802 },
                { sorgente = 1, oro = 3, durezza = 16.14682761938843 },
                { sorgente = 1, oro = 0, durezza = 21.091516798421658 },
                { sorgente = 2, oro = 0, durezza = 14.284895183538534 },
                { sorgente = 2, oro = 1, durezza = 21.317378433002634 },
                { sorgente = 2, oro = 0, durezza = 23.485169190116025 },
                { sorgente = 2, oro = 2, durezza = 21.088551136727233 },
                { sorgente = 2, oro = 2, durezza = 21.099664095032068 },
                { sorgente = 3, oro = 0, durezza = 26.83436614380562 },
                { sorgente = 3, oro = 1, durezza = 23.337427003805104 },
                { sorgente = 3, oro = 1, durezza = 22.02596810802622 },
                { sorgente = 3, oro = 0, durezza = 24.527377878252434 },
                { sorgente = 3, oro = 2, durezza = 19.57740964352776 },
                { sorgente = 4, oro = 1, durezza = 17.69427179282107 },
                { sorgente = 4, oro = 1, durezza = 21.158071792723966 },
                { sorgente = 4, oro = 2, durezza = 18.072161369773397 },
                { sorgente = 4, oro = 2, durezza = 19.679970220863197 },
                { sorgente = 4, oro = 0, durezza = 24.604707497592372 },
                { sorgente = 5, oro = 5, durezza = 7.640821358922171 },
                { sorgente = 5, oro = 6, durezza = 8.112597931819712 },
                { sorgente = 5, oro = 1, durezza = 10.386547265915848 },
                { sorgente = 5, oro = 6, durezza = 5.476011486821928 },
                { sorgente = 5, oro = 1, durezza = 10.684412567549998 },
            },
            'oro'
        }
    }

    local expected = {
        {
            {
                {
                    { sorgente = 1, oro = 0, durezza = 21.20138141309851 },
                },
                {
                    { sorgente = 2, oro = 1, durezza = 21.317378433002634 },
                }
            }
        },
        {
            {
                {
                    { sorgente = 1, oro = 0, durezza = 21.20138141309851 },
                    { sorgente = 1, oro = 0, durezza = 25.29466190715501 },
                    { sorgente = 1, oro = 0, durezza = 21.091516798421658 },
                    { sorgente = 2, oro = 0, durezza = 14.284895183538534 },
                    { sorgente = 2, oro = 0, durezza = 23.485169190116025 },
                    { sorgente = 3, oro = 0, durezza = 26.83436614380562 },
                    { sorgente = 3, oro = 0, durezza = 24.527377878252434 },
                    { sorgente = 4, oro = 0, durezza = 24.604707497592372 },
                },
                {
                    { sorgente = 1, oro = 4, durezza = 12.435278700238802 },
                },
                {
                    { sorgente = 1, oro = 3, durezza = 16.14682761938843 },
                },
                {
                    { sorgente = 2, oro = 1, durezza = 21.317378433002634 },
                    { sorgente = 3, oro = 1, durezza = 23.337427003805104 },
                    { sorgente = 3, oro = 1, durezza = 22.02596810802622 },
                    { sorgente = 4, oro = 1, durezza = 17.69427179282107 },
                    { sorgente = 4, oro = 1, durezza = 21.158071792723966 },
                    { sorgente = 5, oro = 1, durezza = 10.386547265915848 },
                    { sorgente = 5, oro = 1, durezza = 10.684412567549998 },
                },
                {
                    { sorgente = 2, oro = 2, durezza = 21.088551136727233 },
                    { sorgente = 2, oro = 2, durezza = 21.099664095032068 },
                    { sorgente = 3, oro = 2, durezza = 19.57740964352776 },
                    { sorgente = 4, oro = 2, durezza = 18.072161369773397 },
                    { sorgente = 4, oro = 2, durezza = 19.679970220863197 },
                },
                {
                    { sorgente = 5, oro = 5, durezza = 7.640821358922171 },
                },
                {
                    { sorgente = 5, oro = 6, durezza = 8.112597931819712 },
                    { sorgente = 5, oro = 6, durezza = 5.476011486821928 },
                },
            }
        }
    }

    treebuilderTests.addTest(inputs, expected, treebuilder._split, '_split')
end

-- add treebuilder._splitByBestFeature tests
do
    local inputs = {
        {
            {
                { sorgente = 1, oro = 0, durezza = 21.20138141309851 },
                { sorgente = 2, oro = 1, durezza = 21.317378433002634 },
            },
            { 'sorgente', 'durezza' },
            'oro'
        },
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
            { 'previsione', 'temperatura', 'umidita', 'vento' },
            'giocato'
        },
        {
            {
                { previsione = 'Soleggiato', temperatura = 'Alta' , umidita = 'Alta'   , vento = 'No', giocato = 'No', },
                { previsione = 'Soleggiato', temperatura = 'Alta' , umidita = 'Alta'   , vento = 'Si', giocato = 'No', },
                { previsione = 'Soleggiato', temperatura = 'Mite' , umidita = 'Alta'   , vento = 'No', giocato = 'No', },
                { previsione = 'Soleggiato', temperatura = 'Bassa', umidita = 'Normale', vento = 'No', giocato = 'Si', },
                { previsione = 'Soleggiato', temperatura = 'Mite' , umidita = 'Normale', vento = 'Si', giocato = 'Si', },
            },
            { 'temperatura', 'umidita', 'vento' },
            'giocato'
        }
    }

    local expected = {
        {
            {
                feature = 'sorgente',
                groups = {
                    {
                        { sorgente = 1, oro = 0, durezza = 21.20138141309851 },
                    },
                    {
                        { sorgente = 2, oro = 1, durezza = 21.317378433002634 },
                    }
                }
            }
        },
        {
            {
                feature = 'previsione',
                groups = {
                    {
                        { previsione = 'Soleggiato', temperatura = 'Alta' , umidita = 'Alta'   , vento = 'No', giocato = 'No', },
                        { previsione = 'Soleggiato', temperatura = 'Alta' , umidita = 'Alta'   , vento = 'Si', giocato = 'No', },
                        { previsione = 'Soleggiato', temperatura = 'Mite' , umidita = 'Alta'   , vento = 'No', giocato = 'No', },
                        { previsione = 'Soleggiato', temperatura = 'Bassa', umidita = 'Normale', vento = 'No', giocato = 'Si', },
                        { previsione = 'Soleggiato', temperatura = 'Mite' , umidita = 'Normale', vento = 'Si', giocato = 'Si', },
                    },
                    {
                        { previsione = 'Nuvoloso'  , temperatura = 'Alta' , umidita = 'Alta'   , vento = 'No', giocato = 'Si', },
                        { previsione = 'Nuvoloso'  , temperatura = 'Bassa', umidita = 'Normale', vento = 'Si', giocato = 'Si', },
                        { previsione = 'Nuvoloso'  , temperatura = 'Mite' , umidita = 'Alta'   , vento = 'Si', giocato = 'Si', },
                        { previsione = 'Nuvoloso'  , temperatura = 'Alta' , umidita = 'Normale', vento = 'No', giocato = 'Si', },
                    },
                    {
                        { previsione = 'Pioggia'   , temperatura = 'Mite' , umidita = 'Alta'   , vento = 'No', giocato = 'Si', },
                        { previsione = 'Pioggia'   , temperatura = 'Bassa', umidita = 'Normale', vento = 'No', giocato = 'Si', },
                        { previsione = 'Pioggia'   , temperatura = 'Bassa', umidita = 'Normale', vento = 'Si', giocato = 'No', },
                        { previsione = 'Pioggia'   , temperatura = 'Mite' , umidita = 'Normale', vento = 'No', giocato = 'Si', },
                        { previsione = 'Pioggia'   , temperatura = 'Mite' , umidita = 'Alta'   , vento = 'Si', giocato = 'No', },
                    }
                }
            }
        },
        {
            {
                feature = 'umidita',
                groups = {
                    {
                        { previsione = 'Soleggiato', temperatura = 'Alta' , umidita = 'Alta'   , vento = 'No', giocato = 'No', },
                        { previsione = 'Soleggiato', temperatura = 'Alta' , umidita = 'Alta'   , vento = 'Si', giocato = 'No', },
                        { previsione = 'Soleggiato', temperatura = 'Mite' , umidita = 'Alta'   , vento = 'No', giocato = 'No', },
                    },
                    {
                        { previsione = 'Soleggiato', temperatura = 'Bassa', umidita = 'Normale', vento = 'No', giocato = 'Si', },
                        { previsione = 'Soleggiato', temperatura = 'Mite' , umidita = 'Normale', vento = 'Si', giocato = 'Si', },
                    },
                }
            }
        },
    }

    treebuilderTests.addTest(inputs, expected, treebuilder._splitByBestFeature, '_splitByBestFeature')
end

-- add treebuilder._getMostFrequentClass tests
do
    local inputs = {
        {
            {
                { previsione = 'Soleggiato', temperatura = 'Alta' , umidita = 'Alta'   , vento = 'No', giocato = 'No', },
                { previsione = 'Soleggiato', temperatura = 'Alta' , umidita = 'Alta'   , vento = 'Si', giocato = 'No', },
                { previsione = 'Nuvoloso'  , temperatura = 'Alta' , umidita = 'Alta'   , vento = 'No', giocato = 'Si', },
            },
            'previsione'
        },
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
            'temperatura'
        },
    }

    local expected = {
        {
            'Soleggiato'
        },
        {
            'Mite'
        }
    }

    treebuilderTests.addTest(inputs, expected, treebuilder._getMostFrequentClass, '_getMostFrequentClass')
end

-- add treebuilder.buildTree tests
do
    local inputs = {
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
            { 'previsione', 'temperatura', 'umidita', 'vento' },
            'giocato'
        }
    }

    local expected = {
        {
            {
                feature = 'previsione',
                domain = {
                    Soleggiato = {
                        feature = 'umidita',
                        domain = {
                            Normale = {
                                label = 'Si',
                            },
                            Alta = {
                                label = 'No',
                            },
                        },
                    },
                    Nuvoloso = {
                        label = 'Si',
                    },
                    Pioggia = {
                        feature = 'vento',
                        domain = {
                            No = {
                                label = 'Si',
                            },
                            Si = {
                                label = 'No',
                            },
                        },
                    },
                },
            },
        },
    }

    treebuilderTests.addTest(inputs, expected, treebuilder.buildTree, 'buildTree')
end
