/obj/item/storage/bank_box
	name = "standard bankbox"
	desc = "Bigger banks!"
	desc_extended = "A bluespace-enhanced container which can be fit in a bank in order to effectively add more slots. Fits 15 items."
	icon = 'icons/obj/item/storage/death_box.dmi'
	icon_state = "locked"
	is_container = TRUE
	size = SIZE_1
	container_max_size = SIZE_9
	value = 50000
	dynamic_inventory_count = 5 * 3
	rarity = RARITY_RARE
	bank_bypass = TRUE

// recolors for organizational purposes

/obj/item/storage/bank_box/green
	name = "standard bankbox (green)"
	desc_extended = "A bluespace-enhanced container which can be fit in a bank in order to effectively add more slots. Fits 15 items. This one has a green stripe on it."
	icon_state = "green"

/obj/item/storage/bank_box/red
	name = "standard bankbox (red)"
	desc_extended = "A bluespace-enhanced container which can be fit in a bank in order to effectively add more slots. Fits 15 items. This one has a red stripe on it."
	icon_state = "red"

/obj/item/storage/bank_box/white
	name = "standard bankbox (white)"
	desc_extended = "A bluespace-enhanced container which can be fit in a bank in order to effectively add more slots. Fits 15 items. This one has a white stripe on it."
	icon_state = "white"

/obj/item/storage/bank_box/blue
	name = "standard bankbox (blue)"
	desc_extended = "A bluespace-enhanced container which can be fit in a bank in order to effectively add more slots. Fits 15 items. This one has a blue stripe on it."
	icon_state = "blue"

/obj/item/storage/bank_box/yellow
	name = "standard bankbox (yellow)"
	desc_extended = "A bluespace-enhanced container which can be fit in a bank in order to effectively add more slots. Fits 15 items. This one has a yellow stripe on it."
	icon_state = "yellow"


// other sizes

/obj/item/storage/bank_box/tiny
	name = "extra-miniature bankbox"
	desc = "Slightly bigger banks!"
	desc_extended = "A bluespace-enhanced container which can be fit in a bank in order to effectively add more slots. Fits 5 items."
	value = 10000
	dynamic_inventory_count = 5
	rarity = RARITY_UNCOMMON

/obj/item/storage/bank_box/small
	name = "miniature bankbox"
	desc = "Somewhat bigger banks!"
	desc_extended = "A bluespace-enhanced box which can be fit in a bank in order to effectively add more slots. Fits 10 items."
	value = 25000
	dynamic_inventory_count = 5 * 2
	rarity = RARITY_UNCOMMON

/obj/item/storage/bank_box/big
	name = "expanded bankbox"
	desc = "Much bigger banks!"
	desc_extended = "A bluespace-enhanced box which can be fit in a bank in order to effectively add more slots. Fits 20 items."
	value = 75000
	dynamic_inventory_count = 5 * 4
	rarity = RARITY_RARE

/obj/item/storage/bank_box/huge
	name = "ultra-expanded bankbox"
	desc = "WAY bigger banks!"
	desc_extended = "A bluespace-enhanced box which can be fit in a bank in order to effectively add more slots. Fits 25 items."
	value = 150000
	dynamic_inventory_count = 5 * 5
	rarity = RARITY_MYTHICAL

/obj/item/storage/bank_box/giga
	name = "giga-expanded bankbox"
	desc = "INSANELY bigger banks!!"
	desc_extended = "A bluespace-enhanced box which can be fit in a bank in order to effectively add more slots. Fits 30 items."
	value = 300000
	dynamic_inventory_count = 5 * 6
	rarity = RARITY_MYTHICAL

/obj/item/storage/bank_box/max
	name = "super-duper-crazy-mega-expanded bankbox"
	desc = "THE BIGGEST BANKS EVER!!!"
	desc_extended = "The pinnacle of modern banking technology, this is a bluespace-enhanced box which can be fit in a bank in order to effectively add more slots. Fits 35 items."
	value = 750000
	dynamic_inventory_count = 5 * 7
	rarity = RARITY_LEGENDARY

/obj/item/storage/bank_box/debug
	name = "prototype Genessian bankbox"
	desc = "THE BIGGEST BANKS EVER!!! FOR REAL THIS TIME!!!!"
	desc_extended = "An incredibly rare prototype of a bluespace-enhanced box which can be fit in a bank in order to effectively add more slots. Fits 100 items."
	value = 420691337
	dynamic_inventory_count = 10 * 10
	rarity = RARITY_LEGENDARY

// sub-box for expanding your expanders. has science gone too far?

/obj/item/storage/bank_box/sub_box
	name = "sub-bankbox"
	desc = "Infinite banks??"
	desc_extended = "A bluespace-enhanced container which can be fit in a bank in order to effectively add more slots. Fits 30 items. This is a much smaller bank-box that can fit inside other bank boxes."
	icon = 'icons/obj/item/storage/boxes.dmi'
	icon_state = "box_of_doom"
	size = SIZE_1
	container_max_size = SIZE_8
	value = 500000
	dynamic_inventory_count = 5 * 6
	rarity = RARITY_MYTHICAL

