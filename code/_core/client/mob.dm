/client/proc/make_ghost(var/turf/desired_loc)

	if(!desired_loc)
		desired_loc = FALLBACK_TURF

	if(mob)
		mob.ckey_last = null

	var/mob/abstract/observer/O = new(desired_loc,src)
	INITIALIZE(O)
	O.force_move(desired_loc)

/client/proc/control_mob(var/mob/M,var/delete_last_mob = FALSE)

	if(!M)
		return FALSE

	if(delete_last_mob)
		if(mob) qdel(mob)
	else
		clear_mob(mob,TRUE)

	M.client = src
	M.ckey = src.ckey
	M.ckey_last = src.ckey

	mob = M
	eye = M
	all_mobs_with_clients += M

	var/obj/parallax/layer1/P1 = new
	screen += P1
	mob.parallax += P1
	P1.transform *= 2
	P1.owner = mob

	var/obj/parallax/layer2/P2 = new
	screen += P2
	mob.parallax += P2
	P2.transform *= 2
	P2.owner = mob

	var/obj/parallax/layer3/P3 = new
	screen += P3
	mob.parallax += P3
	P3.transform *= 2
	P3.owner = mob

	var/obj/parallax/layer4/P4 = new
	screen += P4
	mob.parallax += P4
	P4.owner = mob

	update_zoom(-1)
	update_verbs()
	src.to_chat("You have taken control of [M].")

/client/proc/clear_mob(var/mob/M,var/hard = FALSE) //This is called when the client no longer controls this mob.

	if(known_inventory)
		known_inventory.Cut()

	if(known_buttons)
		known_buttons.Cut()

	if(known_health_elements)
		known_health_elements.Cut()

	if(screen)
		screen.Cut()

	if(images)
		images.Cut()

	if(!M)
		return FALSE

	if(M.parallax)
		for(var/obj/parallax/P in M.parallax)
			qdel(P)
			M.parallax -= P
		M.parallax.Cut()

	all_mobs_with_clients -= M
	M.client = null
	if(hard)
		M.ckey_last = null
	if(M == mob)
		mob = null


/client/proc/load(var/savedata/client/mob/U,var/file_num)

	U.loaded_data = U.load_json_data_from_id(file_num)
	src.save_slot = file_num
	to_chat(span("notice","Successfully loaded character [U.loaded_data["name"]]."))
	stop_music_track(src)

	var/mob/living/advanced/player/P = new(FALLBACK_TURF,src)
	P.mobdata = U
	INITIALIZE(P)

	return P
