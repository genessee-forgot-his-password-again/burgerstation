/mob/living/simple/colossus
	name = "colossus"
	boss_icon_state = "colossus"
	icon = 'icons/mob/living/simple/lavaland/colossus.dmi'
	icon_state = "colossus"
	damage_type = /damagetype/unarmed/claw/


	value = 4000

	pixel_x = -32

	ai = /ai/boss/colossus/

	stun_angle = 0

	boss_loot = /loot/lavaland/colossus

	health_base = 12000
	stamina_base = 500
	mana_base = 2000

	movement_delay = DECISECONDS_TO_TICKS(5)

	force_spawn = TRUE
	boss = TRUE

	armor = /armor/colossus

	status_immune = list(
		STUN = TRUE,
		SLEEP = TRUE,
		PARALYZE = TRUE,
		STAMCRIT = TRUE,
		STAGGER = TRUE,
		CONFUSED = TRUE,
		DISARM = TRUE,
		FIRE = TRUE,
		GRAB = TRUE,
		PAINCRIT = TRUE
	)

	iff_tag = "Colossus"
	loyalty_tag = "Colossus"

	fatigue_mul = 0

	size = SIZE_BOSS

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	blood_type = /reagent/blood/ancient
	blood_volume = 2000

	butcher_contents = list(
		/obj/item/container/edible/dynamic/meat/raw_colossus,
		/obj/item/container/edible/dynamic/meat/raw_colossus,
		/obj/item/container/edible/dynamic/meat/raw_colossus,
		/obj/item/container/edible/dynamic/meat/raw_colossus,
		/obj/item/container/edible/dynamic/meat/raw_colossus,
		/obj/item/container/edible/dynamic/meat/raw_colossus
	)

	object_size = 2

	respawn_time = SECONDS_TO_DECISECONDS(300)

	level = 28

/mob/living/simple/colossus/pre_death()
	do_say("<font color='#DD1C1F' size='4'>I WILL RETURN.</font>",FALSE)
	play_sound('sound/effects/demon_dies.ogg',get_turf(src), volume=75, range_min = VIEW_RANGE, range_max = VIEW_RANGE * 3)
	return ..()

/mob/living/simple/colossus/post_death()
	. = ..()
	animate(src, pixel_z = 64, time = 30)

/mob/living/simple/colossus/handle_alpha()
	if(dead) return 0
	. = ..()


