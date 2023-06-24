/obj/item/storage/box
	name = "box"
	desc = "What's inside the box?"
	desc_extended = "A regular grey cardboard box."

	icon = 'icons/obj/item/storage/boxes.dmi'
	icon_state = "box"

	size = SIZE_3

	is_container = TRUE
	container_max_size = SIZE_2

	dynamic_inventory_count = MAX_INVENTORY_X

	value = 10

/obj/item/storage/box/bank
	name = "bankbox"
	desc = "Bank expansions - no gold deposit required!"
	desc_extended = "A metallic box with large amounts of storage space. Too big to be stored anywhere but a bank, though."

	icon = 'icons/obj/item/storage/death_box.dmi'
	icon_state = "locked"

	size = SIZE_10

	is_container = TRUE
	container_max_size = SIZE_10*5

	dynamic_inventory_count = 8*10

	value = 3000

	rarity = RARITY_RARE
