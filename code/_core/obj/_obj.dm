/obj/
	name = "OBJ ERROR"
	icon = 'icons/debug/objs.dmi'
	icon_state = ""
	desc = "null"
	layer = LAYER_OBJ
	plane = PLANE_MOVABLE

	var/list/additional_blends

	var/can_save = TRUE

	var/under_tile = FALSE

	var/has_quick_function = FALSE

/obj/proc/quick(var/mob/living/advanced/caller,var/atom/object,location,params)
	return FALSE

/obj/PreDestroy()
	QDEL_CUT_ASSOC(additional_blends)
	. = ..()