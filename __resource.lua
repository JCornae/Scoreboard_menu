fx_version 'adamant'
games { 'gta5' }

ui_page "html/ui.html"

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

client_scripts {
	'client.lua'
}

files {
	"html/*"
}