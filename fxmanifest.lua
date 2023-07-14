-- Visit us on Discord: https://discord.gg/9EbY4nM5uu

fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

author 'iamlation'
description 'A simple automated mechanic resource for FiveM'
version '2.0.0'

client_script 'client/*.lua'

server_script 'server/*.lua'

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}