/mob/living/advanced/npc/unique/goblin_merchant
	name = "goblin merchant"
	desc = "Profitting from raiding settlements since 4506 BC."

	species = "goblin"

	pixel_z = 1

	blood_type = /reagent/blood/goblin

	dialogue_id = /dialogue/npc/goblin_merchant/

	health = null

	anchored = TRUE
	density = TRUE

	size = SIZE_10

	level = 12

	dna = /dna/goblin

	loadout = /loadout/goblin/merchant

/mob/living/advanced/npc/unique/goblin_merchant/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)
	add_status_effect(IMMORTAL)

/mob/living/advanced/npc/unique/goblin_merchant/employee
	name = "nanotrasen cargo assistant"
	desc_extended = "A Nanotrasen employee who works for the local Quartermaster. Allows access to the bank and purchases items for gold."

	species = "human"

	blood_type = /reagent/blood/human

	dialogue_id = /dialogue/npc/goblin_merchant/employee

	level = 8

	dna = /dna/human

	loadout = /loadout/nanotrasen/cargo_tech

/mob/living/advanced/npc/unique/goblin_merchant/employee/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)
	add_status_effect(IMMORTAL)
