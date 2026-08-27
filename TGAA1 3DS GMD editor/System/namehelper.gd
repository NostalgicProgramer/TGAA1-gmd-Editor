extends Sprite2D

const CONFIG_PERSONAJES = {
	#===========Sistema==============
	"E041 0 10": { "texto": "Modo oculto", "visible": false },
	"E041 0 12": { "texto": "Modo oculto", "visible": false },
	"E041 0 68": { "texto": "Modo oculto", "visible": false },
	"E041 21 68": { "texto": "Modo oculto", "visible": false },
	"E041 1 68": { "texto": "Modo oculto", "visible": false },
	
	#===========Desconocidos==============
	
	"E041 0 14": { "texto": "¿?", "visible": true },
	"E041 19 14": { "texto": "¿?", "visible": true },
	"E041 17 15": { "texto": "¿?", "visible": true },
	"E041 23 14": { "texto": "¿?", "visible": true },
	"E041 13 14": { "texto": "¿?", "visible": true },
	"E041 20 14": { "texto": "¿?", "visible": true },
	"E041 0 15": { "texto": "¿?", "visible": true },
	"E041 4 15": { "texto": "¿?", "visible": true },
	"E041 25 15": { "texto": "¿?", "visible": true },
	"E041 14 70": { "texto": "¿?", "visible": true },
	"E041 21 70": { "texto": "¿?", "visible": true },
	"E041 13 70": { "texto": "¿?", "visible": true },
	"E041 3 71": { "texto": "¿?", "visible": true },
	"E041 24 71": { "texto": "¿?", "visible": true },
	"E041 39 70": { "texto": "¿?", "visible": true },
	"E041 0 71": { "texto": "¿?", "visible": true },
	"E041 47 70": { "texto": "¿?", "visible": true },
	
	#===========Nombres==============
	
	"E041 13 11": { "texto": "Mikotoba", "visible": true },
	"E041 2 1": { "texto": "Holmes", "visible": true },
	"E041 21 14": { "texto": "Kazuma", "visible": true },
	"E041 30 24": { "texto": "Alguacil", "visible": true },
	"E041 75 24": { "texto": "Alguacil", "visible": true },
	"E041 22 15": { "texto": "Juez", "visible": true },
	"E041 0 4": { "texto": "Juez", "visible": true },
	"E041 15 15": { "texto": "Juez", "visible": true },
	"E041 1 0": { "texto": "Ryunosuke", "visible": true },
	"E041 0 0": { "texto": "Ryunosuke", "visible": true },
	"E041 14 13": { "texto": "Stronghart", "visible": true },
	"E041 3 2": { "texto": "Susato", "visible": true },
	"E041 9 2": { "texto": "Susato", "visible": true },
	"E041 29 24": { "texto": "Alguacil", "visible": true },
	"E041 23 16": { "texto": "Auchi", "visible": true },
	"E041 25 19": { "texto": "Hosonaga", "visible": true },
	"E041 27 23": { "texto": "Nosa", "visible": true },
	"E041 26 22": { "texto": "Korekuta", "visible": true },
	"E041 24 17": { "texto": "Brett", "visible": true },
	"E041 39 25": { "texto": "Marinero", "visible": true },
	"E041 48 32": { "texto": "Beppo", "visible": true },
	"E041 49 33": { "texto": "Fairplay", "visible": true },
	"E041 50 34": { "texto": "Furst", "visible": true },
	"E041 47 31": { "texto": "McGilded", "visible": true },
	"E041 5 6": { "texto": "Gina", "visible": true },
	"E041 16 8": { "texto": "Van Zieks", "visible": true },
	"E041 36 28": { "texto": "Roylott", "visible": true },
	
	#===========Jurado==============
	
	"E041 51 35": { "texto": "Jurado N. 1", "visible": true },
	"E041 52 36": { "texto": "Jurado N. 2", "visible": true },
	"E041 53 37": { "texto": "Jurado N. 3", "visible": true },
	"E041 54 38": { "texto": "Jurado N. 4", "visible": true },
	"E041 55 39": { "texto": "Jurado N. 5", "visible": true },
	"E041 56 40": { "texto": "Jurado N. 6", "visible": true },
	
}

@onready var edit_principal = $"../../TextEdit"
@onready var label_nombre = $Label 

func _process(_delta):
	if edit_principal:
		_actualizar_previsualizacion()

func _actualizar_previsualizacion():
	var texto_sucio = edit_principal.text
	var comando_encontrado = false
	
	var i = 0
	while i < texto_sucio.length():
		if texto_sucio[i] == "<":
			var fin = texto_sucio.find(">", i)
			if fin != -1:
				var contenido = texto_sucio.substr(i + 1, fin - i - 1).strip_edges().to_upper()
				
				# Verificamos si el comando existe en tu diccionario
				if CONFIG_PERSONAJES.has(contenido):
					var config = CONFIG_PERSONAJES[contenido]
					
					# Aplicamos visibilidad
					self.visible = config.visible
					
					# Si es visible, actualizamos el texto
					if config.visible:
						label_nombre.text = config.texto
					
					comando_encontrado = true
				
				i = fin
			else:
				i += 1
		else:
			i += 1
	
	# Si no se encontró ningún comando en todo el texto, ocultamos el nodo
	if not comando_encontrado:
		self.visible = false
