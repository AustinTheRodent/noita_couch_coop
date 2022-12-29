dofile("data/scripts/lib/mod_settings.lua")

function mod_setting_change_callback( mod_id, gui, in_main_menu, setting, old_value, new_value  )
	print( tostring(new_value) )
end

local mod_id = "new_enemies"
mod_settings_version = 1
mod_settings = 
{
  {
    id = "show_button",
    ui_name = "GUI Button",
    ui_description = "Shows [NE] button at the top of the screen.",
    value_default = true,
    scope = MOD_SETTING_SCOPE_RUNTIME,
  },
  
	{
		id = "difficulty_level",
		ui_name = "Difficulty Selection",
		ui_description = "Select the custom enemy difficulty",
		value_default = "normal",
		values = {
			{"easy", "Easier Mode"},
			{"normal","Normal Mode"},
		},
		scope = MOD_SETTING_SCOPE_RUNTIME, 
	},
	
  {
    id = "scenes_enabled",
    ui_name = "New Enemies Scenes",
    ui_description = "Toggles Custom Scenes on and off.",
    value_default = true,
    scope = MOD_SETTING_SCOPE_NEW_GAME,
  },
  {
    id = "twitch_events_enabled",
    ui_name = "New Enemies Twitch Events",
    ui_description = "Toggles Custom Events on and off.",
    value_default = false,
    scope = MOD_SETTING_SCOPE_NEW_GAME,
  },
}

function ModSettingsUpdate( init_scope )
	local old_version = mod_settings_get_version( mod_id )
	mod_settings_update( mod_id, mod_settings, init_scope )
end

function ModSettingsGuiCount()
	return mod_settings_gui_count( mod_id, mod_settings )
end

function ModSettingsGui( gui, in_main_menu )
	mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )
end
