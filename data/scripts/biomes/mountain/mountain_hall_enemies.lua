dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/perks/perk.lua")

function init( x, y, w, h )


  EntityLoad("data/entities/buildings/ritualist_a.xml", x - 61,y + 397)
  --EntityLoad("data/entities/animals/acidshooter.xml", x - 200,y + 397)
  EntityLoad("data/entities/player2.xml", x - 200,y + 397)
  --EntityLoad("data/entities/player.xml", x - 200,y + 397)
  --EntityLoad("data/entities/buildings/acidshooter.xml", x - 5,y + 5)

  perk_spawn( x - 40 , y + 397 , "PROJECTILE_HOMING" )

  -- regular game script info:
	if GameGetIsGamepadConnected() then
		LoadPixelScene( "data/biome_impl/mountain/hall.png", "data/biome_impl/mountain/hall_visual.png", x, y, "data/biome_impl/mountain/hall_background_gamepad_updated.png", true )
	else
		LoadPixelScene( "data/biome_impl/mountain/hall.png", "data/biome_impl/mountain/hall_visual.png", x, y, "data/biome_impl/mountain/hall_background.png", true )
	end
	
	LoadPixelScene( "data/biome_impl/mountain/hall_instructions.png", "", x, y, "", true )
	
	LoadPixelScene( "data/biome_impl/mountain/hall_b.png", "data/biome_impl/mountain/hall_b_visual.png", x, y+512, "", true )
	LoadPixelScene( "data/biome_impl/mountain/hall_br.png", "data/biome_impl/mountain/hall_br_visual.png", x+512, y+512, "", true )
	LoadPixelScene( "data/biome_impl/mountain/hall_r.png", "data/biome_impl/mountain/hall_r_visual.png", x+512, y, "", true )
	LoadPixelScene( "data/biome_impl/mountain/hall_bottom.png", "", x-512, y+512, "", true )
	LoadPixelScene( "data/biome_impl/mountain/hall_bottom_2.png", "", x+552, y+512, "", true )
	
	load_verlet_rope_with_two_joints("data/entities/verlet_chains/vines/verlet_vine_pixelscene.xml", x+139, y+300, x+175, y+281)
	load_verlet_rope_with_two_joints("data/entities/verlet_chains/vines/verlet_vine_pixelscene.xml", x+302, y+341, x+348, y+345)
	load_verlet_rope_with_two_joints("data/entities/verlet_chains/vines/verlet_vine_pixelscene.xml", x+325, y+342, x+374, y+371)
	load_verlet_rope_with_two_joints("data/entities/verlet_chains/vines/verlet_vine_long_pixelscene.xml", x+216, y+278, x+272, y+314)
	
	load_verlet_rope_with_one_joint("data/entities/verlet_chains/vines/verlet_vine_short_pixelscene.xml", x+243, y+285)
	load_verlet_rope_with_one_joint("data/entities/verlet_chains/vines/verlet_vine_short_pixelscene.xml", x+281, y+325)
	load_verlet_rope_with_one_joint("data/entities/verlet_chains/vines/verlet_vine_short_pixelscene.xml", x+356, y+354)
	load_verlet_rope_with_one_joint("data/entities/verlet_chains/vines/verlet_vine_shorter_pixelscene.xml", x+184, y+276)
	load_verlet_rope_with_one_joint("data/entities/verlet_chains/vines/verlet_vine_shorter_pixelscene.xml", x+286, y+331)
end