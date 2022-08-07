

//-- Reader for loading DMM files at runtime -----------------------------------
/datum/loadedProperties
	var/info = ""
	var/sourceX = 0
	var/sourceY = 0
	var/sourceZ = 0
	var/maxX = 0
	var/maxY = 0
	var/maxZ = 0

dmm_suite

	/*-- read_map ------------------------------------
	Generates map instances based on provided DMM formatted text. If coordinates
	are provided, the map will start loading at those coordinates. Otherwise, any
	coordinates saved with the map will be used. Otherwise, coordinates will
	default to (1, 1, world.maxz+1)
	*/
	read_map(dmm_text as text, coordX as num, coordY as num, coordZ as num, tag as text, overwrite as num, angleOffset as num)
		if(angleOffset)
			angleOffset = MODULUS(round(angleOffset,90), 360)
		else
			angleOffset = 0
		var/datum/loadedProperties/props = new()
		props.sourceX = coordX
		props.sourceY = coordY
		props.sourceZ = coordZ
		props.info = tag
		// Split Key/Model list into lines
		var key_len
		var /list/grid_models[0]
		var startGridPos = findtext(dmm_text, "\n\n(1,1,") // Safe because \n not allowed in strings in dmm
		var startData = findtext(dmm_text, "\"")
		var linesText = copytext(dmm_text, startData + 1, startGridPos)
		var /list/modelLines = splittext(linesText, regex(@{"\n\""}))
		for(var/modelLine in modelLines) // "aa" = (/path{key = value; key = value},/path,/path)\n
			var endQuote = findtext(modelLine, quote, 2, 0)
			if(endQuote <= 1)
				continue
			var modelKey = copytext(modelLine, 1, endQuote)
			if(isnull(key_len))
				key_len = length(modelKey)
			var modelsStart = findtextEx(modelLine, "/") // Skip key and first three characters: "aa" = (
			var modelContents = copytext(modelLine, modelsStart, length(modelLine)) // Skip last character: )
			grid_models[modelKey] = modelContents
			sleep(-1)
		// Retrieve Comments, Determine map position (if not specified)
		var commentModel = modelLines[1] // The comment key will always be first.
		var bracketPos = findtextEx(commentModel, "}")
		commentModel = copytext(commentModel, findtextEx(commentModel, "=")+3, bracketPos) // Skip opening bracket
		var commentPathText = "[/obj/dmm_suite/comment]"
		if(copytext(commentModel, 1, length(commentPathText)+1) == commentPathText)
			var attributesText = copytext(commentModel, length(commentPathText)+2, -1) // Skip closing bracket
			var /list/paddedAttributes = splittext(attributesText, semicolon_delim) // "Key = Value"
			for(var/paddedAttribute in paddedAttributes)
				var equalPos = findtextEx(paddedAttribute, "=")
				var attributeKey = copytext(paddedAttribute, 1, equalPos-1)
				var attributeValue = copytext(paddedAttribute, equalPos+3, -1) // Skip quotes
				switch(attributeKey)
					if("coordinates")
						var /list/coords = splittext(attributeValue, comma_delim)
						if(!coordX) coordX = text2num(coords[1])
						if(!coordY)	coordY = text2num(coords[2])
						if(!coordZ) coordZ = text2num(coords[3])
		if(!coordX) coordX = 1
		if(!coordY) coordY = 1
		if(!coordZ) coordZ = world.maxz+1
		// Store quoted portions of text in text_strings, and replaces them with an index to that list.
		var gridText = copytext(dmm_text, startGridPos)
		var /list/gridLevels = list()
		var /regex/grid = regex(@{"\(([0-9]*),([0-9]*),([0-9]*)\) = \{"\n((?:\l*\n)*)"\}"}, "g")
		var /list/coordShifts = list()
		var/maxZFound = 1
		while(grid.Find(gridText))
			gridLevels.Add(copytext(grid.group[4], 1, -1)) // Strip last \n
			coordShifts.Add(list(list(grid.group[1], grid.group[2], grid.group[3])))
			maxZFound = max(maxZFound, text2num(grid.group[3]))
		// Create all Atoms at map location, from model key
		if ((coordZ+maxZFound-1) > world.maxz)
			world.maxz = coordZ+maxZFound-1
			//all_mobs_with_clients_by_z["[world.maxz]"] = list()
			log_debug("Z levels increased to [world.maxz].")
		var/xMax = 0
		var/yMax = 0
		for(var/posZ = 1 to gridLevels.len)
			CHECK_TICK_SAFE(50,FPS_SERVER)
			var zGrid = gridLevels[posZ]
			// Reverse Y coordinate
			var /list/yReversed = text2list(zGrid, "\n")
			var /list/yLines = list()
			for(var/posY = yReversed.len to 1 step -1)
				yLines.Add(yReversed[posY])
			//
			yMax = max(yMax,yLines.len+(coordY-1))
			if(world.maxy < yMax)
				var/old_value = world.maxy
				world.maxy = yMax
				log_debug("[tag] caused map resize (Y [old_value] to [world.maxy]) during prefab placement" )
			var exampleLine = pick(yLines)
			xMax = max(xMax,length(exampleLine)/key_len+(coordX-1))
			if(world.maxx < xMax)
				var/old_value = world.maxx
				world.maxx = xMax
				log_debug("[tag] caused map resize (X [old_value] to [world.maxx]) during prefab placement" )

			props.maxX = xMax
			props.maxY = yMax
			props.maxZ = world.maxz

			var/gridCoordX = text2num(coordShifts[posZ][1]) + coordX - 1
			var/gridCoordY = text2num(coordShifts[posZ][2]) + coordY - 1
			var/gridCoordZ = text2num(coordShifts[posZ][3]) + coordZ - 1

			if(overwrite)
				for(var/posY = 1 to yLines.len)
					var yLine = yLines[posY]
					for(var/posX = 1 to length(yLine)/key_len)

						var/grid_x = gridCoordX - 1
						var/grid_y = gridCoordY - 1

						var/offset_x = posX
						var/offset_y = posY

						var/turf/T = locate(grid_x + offset_x,grid_y + offset_y, gridCoordZ)
						for(var/k in T)
							var/datum/x = k
							if(overwrite & DMM_OVERWRITE_OBJS && istype(x, /obj))
								qdel(x)
								if(overwrite & DMM_OVERWRITE_MARKERS && istype(x,/obj/marker/))
									qdel(x)
							else if(overwrite & DMM_OVERWRITE_MOBS && istype(x, /mob))
								qdel(x)
							CHECK_TICK_SAFE(50,FPS_SERVER)

			var/y_length = length(yLines)
			for(var/posY=1,posY<=y_length,posY++)
				var yLine = yLines[posY]
				var/x_length = length(yLine)/key_len
				for(var/posX=1,posX<=x_length,posX++)

					var/grid_x = (gridCoordX - 1) //Origin loc.
					var/grid_y = (gridCoordY - 1) //Origin loc

					var/offset_x = posX
					var/offset_y = posY

					switch(angleOffset)
						if(0)
							offset_x = posX
							offset_y = posY
						if(90)
							offset_x = posY
							offset_y = x_length - posX
						if(180) //Works
							offset_x = x_length - posX //Negative x
							offset_y = y_length - posY //Negative y

						if(270)
							offset_x = y_length - posY
							offset_y = posX

					var keyPos = ((posX-1)*key_len)+1
					var modelKey = copytext(yLine, keyPos, keyPos+key_len)
					parse_grid(
						grid_models[modelKey], grid_x + offset_x, grid_y + offset_y, gridCoordZ, angleOffset
					)
					CHECK_TICK_SAFE(50,FPS_SERVER)

		if(tag)
			log_debug("dmm_suite loaded: [tag] ([xMax - coordX],[yMax - coordY]).")
		//
		return props

//-- Supplemental Methods ------------------------------------------------------

	var
		quote = "\""
		regex/comma_delim = new("\[\\s\\r\\n\]*,\[\\s\\r\\n\]*")
		regex/semicolon_delim = new("\[\\s\\r\\n\]*;\[\\s\\r\\n\]*")
		regex/key_value_regex = new("^\[\\s\\r\\n\]*(\[^=\]*?)\[\\s\\r\\n\]*=\[\\s\\r\\n\]*(.*?)\[\\s\\r\\n\]*$")

	proc
		parse_grid(models as text, xcrd, ycrd, zcrd, angleOffset)
			/* Method parse_grid() - Accepts a text string containing a comma separated list
				of type paths of the same construction as those contained in a .dmm file, and
				instantiates them.*/
			// Store quoted portions of text in text_strings, and replace them with an index to that list.
			var /list/originalStrings = list()
			var /regex/noStrings = regex("(\[\"\])(?:(?=(\\\\?))\\2(.|\\n))*?\\1")
			var stringIndex = 1
			var found
			do
				found = noStrings.Find(models, noStrings.next)
				if(found)
					var indexText = {""[stringIndex]""}
					stringIndex++
					var match = copytext(noStrings.match, 2, -1) // Strip quotes
					models = noStrings.Replace(models, indexText, found)
					originalStrings[indexText] = (match)
			while(found)
			// Identify each object's data, instantiate it, & reconstitues its fields.
			var /list/turfStackTypes = list()
			var /list/turfStackAttributes = list()
			for(var/atomModel in splittext(models, comma_delim))
				var bracketPos = findtext(atomModel, "{")
				var atomPath = text2path(copytext(atomModel, 1, bracketPos))
				var /list/attributes
				if(bracketPos)
					attributes = new()
					var attributesText = copytext(atomModel, bracketPos+1, -1)
					var /list/paddedAttributes = splittext(attributesText, semicolon_delim) // "Key = Value"
					for(var/paddedAttribute in paddedAttributes)
						key_value_regex.Find(paddedAttribute)
						attributes[key_value_regex.group[1]] = key_value_regex.group[2]
				if(!ispath(atomPath, /turf))
					loadModel(atomPath, attributes, originalStrings, xcrd, ycrd, zcrd, angleOffset)
				else
					turfStackTypes.Insert(1, atomPath)
					turfStackAttributes.Insert(1, null)
					turfStackAttributes[1] = attributes
			// Layer all turf appearances into final turf
			if(!turfStackTypes.len) return
			var /turf/topTurf = loadModel(turfStackTypes[1], turfStackAttributes[1], originalStrings, xcrd, ycrd, zcrd, angleOffset)
			for(var/turfIndex = 2 to turfStackTypes.len)
				var /mutable_appearance/underlay = new(turfStackTypes[turfIndex])
				loadModel(underlay, turfStackAttributes[turfIndex], originalStrings, xcrd, ycrd, zcrd, angleOffset)
				topTurf.underlays.Add(underlay)

		loadModel(atomPath, list/attributes, list/strings, xcrd, ycrd, zcrd, angleOffset)
			// Cancel if atomPath is a placeholder (DMM_IGNORE flags used to write file)
			if(ispath(atomPath, /turf/dmm_suite/clear_turf) || ispath(atomPath, /area/dmm_suite/clear_area))
				return
			// Parse all attributes and create preloader
			var /list/attributesMirror = list()
			var /turf/location = locate(xcrd, ycrd, zcrd)
			if(!location)
				log_error("dmm_suite reader bad loc! ([xcrd],[ycrd],[zcrd]).")
				return null


			for(var/attributeName in attributes)
				attributesMirror[attributeName] = loadAttribute(attributes[attributeName], strings)
			var /dmm_suite/preloader/preloader = new(location, attributesMirror)
			// Begin Instanciation
			// Handle Areas (not created every time)
			var /atom/instance
			if(ispath(atomPath, /area))
				//instance = locate(atomPath)
				//instance.contents.Add(locate(xcrd, ycrd, zcrd))
				new atomPath(locate(xcrd, ycrd, zcrd))
				location.dmm_preloader = null
			// Handle Underlay Turfs
			else if(istype(atomPath, /mutable_appearance))
				instance = atomPath // Skip to preloader manual loading.
				preloader.load(instance)
			// Handle Turfs & Movable Atoms
			else
				if(ispath(atomPath, /turf))
					if(ispath(atomPath, /turf/dmm_suite/no_wall))
						if(is_simulated(location))
							var/turf/simulated/S = location
							if(S.density)
								if(S.destruction_turf)
									instance = new S.destruction_turf(location)
								else
									instance = new /turf/simulated/floor/cave_dirt(location)
						else if(istype(location,/turf/unsimulated/generation))
							var/turf/unsimulated/generation/G = location
							G.density = FALSE
						else
							instance = new /turf/simulated/floor/cave_dirt(location)
					else
						instance = new atomPath(location)
						//instance = location.ReplaceWith(atomPath, keep_old_material = 0, handle_air = 0, handle_dir = 0)
				else
					if(atomPath)
						instance = new atomPath(location)
						if(angleOffset)
							instance.dir = turn(instance.dir,-angleOffset)
			// Handle cases where Atom/New was redifined without calling Super()
			if(preloader && instance) // Atom could delete itself in New()
				preloader.load(instance)
			//
			return instance

		loadAttribute(value, list/strings)
			//Check for string
			if(copytext(value, 1, 2) == "\"")
				return strings[value]
			//Check for number
			var num = text2num(value)
			if(isnum(num))
				return num
			//Check for file
			else if(copytext(value,1,2) == "'")
				return get_cached_file(copytext(value,2,length(value)))
				// return file(copytext(value,2,length(value)))
			// Check for lists
				// To Do


//-- Preloading ----------------------------------------------------------------

turf
	var
		dmm_suite/preloader/dmm_preloader

atom/New(turf/newLoc)
    if(isturf(newLoc))
        var /dmm_suite/preloader/preloader = newLoc.dmm_preloader
        if(preloader)
            newLoc.dmm_preloader = null
            preloader.load(src)
    . = ..()

dmm_suite
	preloader
		parent_type = /datum
		var
			list/attributes
		New(turf/loadLocation, list/_attributes)
			loadLocation.dmm_preloader = src
			attributes = _attributes
			. = ..()
		proc
			load(atom/newAtom)
				var /list/attributesMirror = attributes // apparently this is faster
				for(var/attributeName in attributesMirror)
					newAtom.vars[attributeName] = attributesMirror[attributeName]