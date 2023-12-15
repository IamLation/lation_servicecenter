-- Visit us on Discord: https://discord.gg/9EbY4nM5uu

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'iamlation'
description 'A simple automated mechanic resource for FiveM'
version '2.1.0'

client_scripts {
    'bridge/client.lua',
    'client/*.lua',
}

server_scripts {
    'bridge/server.lua',
    'server/*.lua',
}

shared_scripts {
    'config.lua',
    'strings.lua',
    '@ox_lib/init.lua'
}