#!/usr/bin/lua

local pretty      = require('lib.pretty')
local treebuilder = require('src.treebuilder')

local data = {
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
}

local tree = treebuilder.buildTree(data, { 'previsione', 'temperatura', 'umidita', 'vento' }, 'giocato')
pretty.print(tree)
