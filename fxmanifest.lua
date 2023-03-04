-- For support, scripts & more join Discord @ https://discord.gg/rwWNDRBYS4

fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

author 'Lation#0001'
description 'A simple automated mechanic script for repairing and cleaning vehicles on the go'
version '1.0.1'

client_script 'client/*.lua'

server_script 'server/*.lua'

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
    '@es_extended/imports.lua'
}