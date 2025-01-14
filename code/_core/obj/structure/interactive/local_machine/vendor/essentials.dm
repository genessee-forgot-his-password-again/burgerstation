/obj/structure/interactive/vending/essentials
	name = "essentials vendor"
	desc_extended = "Sells a variety of simple tools, like empty boxes, pinpointers, and emergency weaponry."

	stored_types = list(
		/obj/item/clothing/ears/headset/nanotrasen,

		/obj/item/pinpointer/boss,
		/obj/item/pinpointer/crew,
		/obj/item/pinpointer/crew/death,
		/obj/item/pinpointer/crew/syndicate,
		/obj/item/pinpointer/landmark/,
		/obj/item/pinpointer/objective/,

		/obj/item/analyzer/health,
		/obj/item/storage/kit/small/filled,

		/obj/item/weapon/melee/toolbox/blue/mechanical,
		/obj/item/analyzer/gps,
		/obj/item/flare,
		/obj/item/weapon/melee/torch/flashlight,

		/obj/item/storage/secure,
		/obj/item/storage/box
	)

/obj/structure/interactive/vending/currency
	name = "currency exchange center"
	desc = "Stonks!"
	desc_extended = "Allows nanotrasen credits to be traded in for other currencies, like gold, dosh, or telecrystals."
	markup = 1
	icon = 'icons/obj/structure/vending_new.dmi'
	icon_state = "general_attachments"

	stored_types = list(
		/obj/item/currency/credits,
		/obj/item/currency/dosh,
		/obj/item/currency/gold_coin,
		/obj/item/currency/gold_bar,
		/obj/item/currency/telecrystals,
		/obj/item/currency/magic_token
	)
