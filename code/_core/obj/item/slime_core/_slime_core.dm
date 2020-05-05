/obj/item/slime_core
	name = "dye core"
	desc = "What wonders does this contained goo have?"
	color = "#FFFFFF"
	icon = 'icons/mob/living/simple/slimes_new.dmi'
	icon_state = "slime_core"
	alpha = 128

	value = 3

/obj/item/slime_core/New(var/desired_loc)
	generate_name()
	return ..()

/obj/item/slime_core/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	object = object.defer_click_on_object(location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.dye_self(caller,src,src.color,alpha/255))
			return TRUE

	return ..()


/obj/item/slime_core/calculate_value()
	return ..() * (1 + (alpha/255)) ** 2

/obj/item/slime_core/proc/generate_name()

	var/prefix = ""
	if(alpha < 100)
		prefix = "weak "
	else if(alpha > 200)
		prefix = "strong "

	name = "[prefix]dye core ([color ? color : "#FFFFFF"])"

	return TRUE

/obj/item/slime_core/red
	color = "#FF0000"

/obj/item/slime_core/red/strong
	alpha = 255

/obj/item/slime_core/red/weak
	alpha = 64

/obj/item/slime_core/green
	color = "#00FF00"

/obj/item/slime_core/green/strong
	alpha = 255

/obj/item/slime_core/green/weak
	alpha = 64

/obj/item/slime_core/blue
	color = "#0000FF"

/obj/item/slime_core/blue/strong
	alpha = 255

/obj/item/slime_core/blue/weak
	alpha = 64

/obj/item/slime_core/black
	color = "#000000"

/obj/item/slime_core/black/weak
	alpha = 64

/obj/item/slime_core/black/strong
	alpha = 255

/obj/item/slime_core/white
	color = "#FFFFFF"

/obj/item/slime_core/white/weak
	alpha = 64

/obj/item/slime_core/white/strong
	alpha = 255
