dofile_once("data/scripts/lib/utilities.lua")
dofile( "data/scripts/lib/utilities.lua" )
dofile( "data/scripts/perks/perk_list.lua")
dofile( "data/scripts/perks/perk.lua")

ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_hall.lua", "data/scripts/biomes/mountain/mountain_hall_enemies.lua" )
ModLuaFileAppend( "data/scripts/items/heart_fullhp.lua", "data/scripts/items/heart_fullhp_share.lua" )
ModLuaFileAppend( "data/scripts/items/heart_fullhp_temple.lua", "data/scripts/items/heart_fullhp_temple_share.lua" )
ModLuaFileAppend( "data/scripts/items/gold_pickup.lua", "data/scripts/items/gold_pickup_share.lua" )

if not async then
    -- guard against multiple inclusion to prevent
    -- loss of async coroutines
    dofile( "data/scripts/lib/coroutines.lua" )
end

if ModIsEnabled("mnee") then
	ModLuaFileAppend("mods/mnee/bindings.lua", "mods/test_mod/mnee.lua")
	dofile_once("mods/mnee/lib.lua")
end

function get_player1_obj()
    return EntityGetWithTag( "player1_unit" )[1]
end

function get_player2_obj()
    return EntityGetWithTag( "player2_unit" )[1]
end


function OnWorldPreUpdate()
	wake_up_waiting_threads(1)

  local player2_obj = get_player2_obj()
  local player1_obj = get_player1_obj()

  local player2_ControlsComponent = EntityGetComponent( player2_obj, "ControlsComponent" )[1]
  local player1_ControlsComponent = EntityGetComponent( player1_obj, "ControlsComponent" )[1]

  local lmb_pressed = ComponentGetValue2( player2_ControlsComponent, "mButtonDownLeftClick" )

  local p1_location_x,p1_location_y = EntityGetTransform( player1_obj )
  local p2_location_x,p2_location_y = EntityGetTransform( player2_obj )

  local mouse_x,mouse_y = ComponentGetValue2( player2_ControlsComponent, "mMousePosition" )

  local player1_PlatformShooterPlayerComponent = EntityGetComponent( player1_obj, "PlatformShooterPlayerComponent" )[1]

  ComponentSetValue2(player1_PlatformShooterPlayerComponent, "mDesiredCameraPos", (p1_location_x+p2_location_x)/2.0, (p1_location_y+p2_location_y)/2.0 )

  if lmb_pressed then
    ComponentSetValue2( player1_PlatformShooterPlayerComponent, "mForceFireOnNextUpdate", true )
    ComponentSetValue2( player1_ControlsComponent, "mButtonDownLeftClick", lmb_pressed )
    ComponentSetValue2( player1_ControlsComponent, "mButtonDownFire", lmb_pressed )
    ComponentSetValue2( player1_ControlsComponent, "mButtonDownFire2", lmb_pressed )
  else
    ComponentSetValue2( player1_PlatformShooterPlayerComponent, "mForceFireOnNextUpdate", false )
    ComponentSetValue2( player1_ControlsComponent, "mButtonDownLeftClick", lmb_pressed )
    ComponentSetValue2( player1_ControlsComponent, "mButtonDownFire", lmb_pressed )
    ComponentSetValue2( player1_ControlsComponent, "mButtonDownFire2", lmb_pressed )
  end

  ComponentSetValue2( player1_ControlsComponent, "mMousePosition", mouse_x, mouse_y )
  ComponentSetValue2( player1_ControlsComponent, "mAimingVector", mouse_x-p1_location_x, mouse_y-p1_location_y )

  if ModIsEnabled("mnee") then
    if is_binding_down("key_left", "left", false, false, false, true) then
      ComponentSetValue2( player1_ControlsComponent, "mButtonDownLeft", true )
    else
      ComponentSetValue2( player1_ControlsComponent, "mButtonDownLeft", false )
    end

    if is_binding_down("key_right", "right", false, false, false, true) then
      ComponentSetValue2( player1_ControlsComponent, "mButtonDownRight", true )
    else
      ComponentSetValue2( player1_ControlsComponent, "mButtonDownRight", false )
    end

    ComponentSetValue2( player1_ControlsComponent, "mFlyingTargetY", p1_location_y-10 )
    if is_binding_down("key_jump_space", "jump_space", false, false, false, true) or is_binding_down("key_jump_w", "jump_w", false, false, false, true) then
      ComponentSetValue2( player1_ControlsComponent, "mButtonDownUp", true )
      ComponentSetValue2( player1_ControlsComponent, "mButtonDownJump", true )
      ComponentSetValue2( player1_ControlsComponent, "mButtonDownFly", true )
      ComponentSetValue2( player1_ControlsComponent, "mButtonFrameFly", GameGetFrameNum() )
    else
      ComponentSetValue2( player1_ControlsComponent, "mButtonDownUp", false )
      ComponentSetValue2( player1_ControlsComponent, "mButtonDownJump", false )
      ComponentSetValue2( player1_ControlsComponent, "mButtonDownFly", false )
    end

    if is_binding_down("key_down", "down", false, false, false, true) then
      ComponentSetValue2( player1_ControlsComponent, "mButtonDownEat", true)
    else
      ComponentSetValue2( player1_ControlsComponent, "mButtonDownEat", false)
    end

    if get_binding_pressed("key_next_item_r", "next_item_r") then
      local amount = 1
      ComponentSetValue2(player1_ControlsComponent, "mButtonDownChangeItemR", true)
      ComponentSetValue2(player1_ControlsComponent, "mButtonFrameChangeItemR", GameGetFrameNum()+1)
      ComponentSetValue2(player1_ControlsComponent, "mButtonCountChangeItemR", amount)
    else
      ComponentSetValue2(player1_ControlsComponent, "mButtonDownChangeItemR", false)
      ComponentSetValue2(player1_ControlsComponent, "mButtonCountChangeItemR", 0)
    end

    if get_binding_pressed("key_next_item_l", "next_item_l") then
      local amount = 1
      ComponentSetValue2(player1_ControlsComponent, "mButtonDownChangeItemL", true)
      ComponentSetValue2(player1_ControlsComponent, "mButtonFrameChangeItemL", GameGetFrameNum()+1)
      ComponentSetValue2(player1_ControlsComponent, "mButtonCountChangeItemL", amount)
    else
      ComponentSetValue2(player1_ControlsComponent, "mButtonDownChangeItemL", false)
      ComponentSetValue2(player1_ControlsComponent, "mButtonCountChangeItemL", 0)
    end

    if get_binding_pressed("key_kick", "kick") then
      GamePrint("kick")
      ComponentSetValue2(player1_ControlsComponent, "mButtonDownKick", true);
      ComponentSetValue2(player1_ControlsComponent, "mButtonFrameKick", GameGetFrameNum()+1);
    else
      ComponentSetValue2(player1_ControlsComponent, "mButtonDownKick", false);
    end

    if get_binding_pressed("key_interact", "interact") then
      ComponentSetValue2(player1_ControlsComponent, "mButtonDownInteract", true);
      ComponentSetValue2(player1_ControlsComponent, "mButtonFrameInteract", GameGetFrameNum()+1);
    else
      ComponentSetValue2(player1_ControlsComponent, "mButtonDownInteract", false);
    end

    if get_binding_pressed("key_inventory", "inventory") then
      ComponentSetValue2(player1_ControlsComponent, "mButtonDownInventory", true);
      ComponentSetValue2(player1_ControlsComponent, "mButtonFrameInventory", GameGetFrameNum()+1);
    end

    if get_binding_pressed("key_take_control", "take_control") then
      GamePrint("take contol")
      ComponentSetValue2( player1_ControlsComponent, "enabled", false)
    end

    if get_binding_pressed("key_give_control", "give_control") then
      GamePrint("give control")
      ComponentSetValue2( player1_ControlsComponent, "enabled", true)
    end

    if get_binding_pressed("key_p1_tp_to_p2", "p1_tp_to_p2") then
      EntitySetTransform( player1_obj , p2_location_x , p2_location_y )
    end

    if get_binding_pressed("key_p2_tp_to_p1", "p2_tp_to_p1") then
      EntitySetTransform( player2_obj , p1_location_x , p1_location_y )
    end

  end







  --EntityGetAllComponents( entity_id:int ) -> {int} [Returns a table of component ids.]
  --table.getn

  --local player1_Inventory2Component = EntityGetComponent( player1_obj, "Inventory2Component" )[1]
  --local player1_active_item_id = ComponentGetValue2( player1_Inventory2Component, "mActiveItem" )
  --local player1_active_item_all_components = EntityGetAllComponents(player1_active_item_id)
  --GamePrint(table.getn(player1_active_item_all_components))
  --for i=1,table.getn(player1_active_item_all_components) do
  --  --GamePrint(tostring(ComponentGetTypeName(player1_active_item_all_components[i])))
  --
  --  if ComponentGetTypeName(player1_active_item_all_components[i]) == "ItemComponent" then
  --    GamePrint(tostring(ComponentGetTypeName(player1_active_item_all_components[i])))
  --    GamePrint(tostring(ComponentGetValue2( player1_active_item_all_components[i], "item_name" )))
  --  end
  --  if ComponentGetTypeName(player1_active_item_all_components[i]) == "AbilityComponent" then
  --    GamePrint(tostring(ComponentGetTypeName(player1_active_item_all_components[i])))
  --    GamePrint("click_to_use           :                          "..tostring(ComponentGetValue2( player1_active_item_all_components[i], "click_to_use" )))
  --    GamePrint("cooldown_frames        :                          "..tostring(ComponentGetValue2( player1_active_item_all_components[i], "cooldown_frames" )))
  --    GamePrint("never_reload           :                          "..tostring(ComponentGetValue2( player1_active_item_all_components[i], "never_reload" )))
  --    GamePrint("reload_time_frames     :                          "..tostring(ComponentGetValue2( player1_active_item_all_components[i], "reload_time_frames" )))
  --    GamePrint("use_gun_script         :                          "..tostring(ComponentGetValue2( player1_active_item_all_components[i], "use_gun_script" )))
  --    GamePrint("click_to_use           :                          "..tostring(ComponentGetValue2( player1_active_item_all_components[i], "click_to_use" )))
  --    GamePrint("mIsInitialized         :                          "..tostring(ComponentGetValue2( player1_active_item_all_components[i], "mIsInitialized" )))
  --    GamePrint("mNextFrameUsable       :                          "..tostring(ComponentGetValue2( player1_active_item_all_components[i], "mNextFrameUsable" )))
  --    GamePrint("mCastDelayStartFrame   :                          "..tostring(ComponentGetValue2( player1_active_item_all_components[i], "mCastDelayStartFrame" )))
  --    GamePrint("mAmmoLeft              :                          "..tostring(ComponentGetValue2( player1_active_item_all_components[i], "mAmmoLeft" )))
  --    GamePrint("mReloadFramesLeft      :                          "..tostring(ComponentGetValue2( player1_active_item_all_components[i], "mReloadFramesLeft" )))
  --    GamePrint("mReloadNextFrameUsable :                          "..tostring(ComponentGetValue2( player1_active_item_all_components[i], "mReloadNextFrameUsable" )))
  --    GamePrint("mNextChargeFrame       :                          "..tostring(ComponentGetValue2( player1_active_item_all_components[i], "mNextChargeFrame" )))
  --    GamePrint("mItemRecoil            :                          "..tostring(ComponentGetValue2( player1_active_item_all_components[i], "mItemRecoil" )))
  --  end
  --end

end

--function OnWorldPostUpdate()
--
--  local player2_obj = get_player2_obj()
--  local player1_obj = get_player1_obj()
--
--  local player2_ControlsComponent = EntityGetComponent( player2_obj, "ControlsComponent" )[1]
--  local player1_ControlsComponent = EntityGetComponent( player1_obj, "ControlsComponent" )[1]
--
--  ComponentSetValue2( player1_ControlsComponent, "enabled", false )
--end
