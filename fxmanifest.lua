fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author "DokaDoka"
description "DokaDoka's EUP Menu"
version "1.0.0"

dependencies {
    'es_extended',
}

shared_scripts { 
    '@es_extended/imports.lua',
}

server_scripts {
	'server/*.lua',
}

client_scripts {
    'config.lua',
    'client/*.lua',
}
