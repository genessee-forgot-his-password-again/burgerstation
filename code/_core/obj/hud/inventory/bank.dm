/obj/hud/inventory/dynamic/bank
	name = "bank space"
	icon_state = "square_round"

	max_size = SIZE_10
	max_slots = 1

	drag_to_take = FALSE

	flags_hud = FLAG_HUD_INVENTORY | FLAG_HUD_SPECIAL | FLAG_HUD_CONTAINER

	should_add_to_advanced = FALSE

	priority = -101

/obj/hud/inventory/dynamic/bank/can_slot_object(var/obj/item/I,var/messages = FALSE,var/bypass=FALSE)

	if(!bypass)
		if(!I.bank_bypass && length(I.inventories) && I.size >= SIZE_2)
			if(messages) owner.to_chat(span("warning","The bank does not allow the storage of large containers."))
			return FALSE

		if(!I.bank_bypass && !I.can_save)
			if(messages) owner.to_chat(span("warning","This type of object cannot be stored."))
			return FALSE

		if(!I.bank_bypass && I.contraband)
			if(messages) owner.to_chat(span("warning","The bank refuses to store contraband."))
			return FALSE

	. = ..()
