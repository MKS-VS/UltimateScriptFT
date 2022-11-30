util.require_natives("natives-1663599433")

local main_root = menu.my_root()

function reset_settings_fps()

	--PHYSICS.ROPE_DRAW_SHADOW_ENABLED(true)

	GRAPHICS.CASCADE_SHADOWS_SET_AIRCRAFT_MODE(true)
	GRAPHICS.CASCADE_SHADOWS_ENABLE_ENTITY_TRACKER(false)
	GRAPHICS.CASCADE_SHADOWS_SET_DYNAMIC_DEPTH_MODE(true)
	GRAPHICS.CASCADE_SHADOWS_SET_ENTITY_TRACKER_SCALE(5.0)
	GRAPHICS.CASCADE_SHADOWS_SET_DYNAMIC_DEPTH_VALUE(5.0)
	GRAPHICS.CASCADE_SHADOWS_SET_CASCADE_BOUNDS_SCALE(5.0)
	
	WEAPON.SET_FLASH_LIGHT_FADE_DISTANCE(10.0)
	VEHICLE.SET_LIGHTS_CUTOFF_DISTANCE_TWEAK(10.0)
	AUDIO.DISTANT_COP_CAR_SIRENS(true)
	GRAPHICS.SET_ARTIFICIAL_LIGHTS_STATE(false)

end

local preset_fps_reducer = 4
menu.toggle_loop(main_root, "Enable Preset", {""}, "", function()
	if (preset_fps_reducer == 1) then

		--PHYSICS.ROPE_DRAW_SHADOW_ENABLED(false)

		GRAPHICS.CASCADE_SHADOWS_CLEAR_SHADOW_SAMPLE_TYPE()
		GRAPHICS.CASCADE_SHADOWS_SET_AIRCRAFT_MODE(false)
		GRAPHICS.CASCADE_SHADOWS_ENABLE_ENTITY_TRACKER(true)
		GRAPHICS.CASCADE_SHADOWS_SET_DYNAMIC_DEPTH_MODE(false)
		GRAPHICS.CASCADE_SHADOWS_SET_ENTITY_TRACKER_SCALE(0.0)
		GRAPHICS.CASCADE_SHADOWS_SET_DYNAMIC_DEPTH_VALUE(0.0)
		GRAPHICS.CASCADE_SHADOWS_SET_CASCADE_BOUNDS_SCALE(0.0)

		WEAPON.SET_FLASH_LIGHT_FADE_DISTANCE(0.0)
		VEHICLE.SET_LIGHTS_CUTOFF_DISTANCE_TWEAK(0.0)
		AUDIO.DISTANT_COP_CAR_SIRENS(false)

	elseif (preset_fps_reducer == 2) then

		--PHYSICS.ROPE_DRAW_SHADOW_ENABLED(false)

		GRAPHICS.CASCADE_SHADOWS_CLEAR_SHADOW_SAMPLE_TYPE()
		GRAPHICS.CASCADE_SHADOWS_SET_AIRCRAFT_MODE(false)
		GRAPHICS.CASCADE_SHADOWS_ENABLE_ENTITY_TRACKER(true)
		GRAPHICS.CASCADE_SHADOWS_SET_DYNAMIC_DEPTH_MODE(false)
		GRAPHICS.CASCADE_SHADOWS_SET_ENTITY_TRACKER_SCALE(0.0)
		GRAPHICS.CASCADE_SHADOWS_SET_DYNAMIC_DEPTH_VALUE(0.0)
		GRAPHICS.CASCADE_SHADOWS_SET_CASCADE_BOUNDS_SCALE(0.0)

		WEAPON.SET_FLASH_LIGHT_FADE_DISTANCE(5.0)
		VEHICLE.SET_LIGHTS_CUTOFF_DISTANCE_TWEAK(5.0)
		AUDIO.DISTANT_COP_CAR_SIRENS(false)

	elseif (preset_fps_reducer == 3) then

		--PHYSICS.ROPE_DRAW_SHADOW_ENABLED(true)

		GRAPHICS.CASCADE_SHADOWS_CLEAR_SHADOW_SAMPLE_TYPE()
		GRAPHICS.CASCADE_SHADOWS_SET_AIRCRAFT_MODE(false)
		GRAPHICS.CASCADE_SHADOWS_ENABLE_ENTITY_TRACKER(true)
		GRAPHICS.CASCADE_SHADOWS_SET_DYNAMIC_DEPTH_MODE(false)
		GRAPHICS.CASCADE_SHADOWS_SET_ENTITY_TRACKER_SCALE(5.0)
		GRAPHICS.CASCADE_SHADOWS_SET_DYNAMIC_DEPTH_VALUE(3.0)
		GRAPHICS.CASCADE_SHADOWS_SET_CASCADE_BOUNDS_SCALE(3.0)

		WEAPON.SET_FLASH_LIGHT_FADE_DISTANCE(3.0)
		VEHICLE.SET_LIGHTS_CUTOFF_DISTANCE_TWEAK(3.0)
		AUDIO.DISTANT_COP_CAR_SIRENS(false)
		GRAPHICS.SET_ARTIFICIAL_LIGHTS_STATE(false)

	elseif (preset_fps_reducer == 4) then
		reset_settings_fps()
	end
end)

menu.slider(main_root, "Auto Preset FPS Reducer: ", {""}, " 1 = Ultra Low \n 2 = Low \n 3 = Medium \n 4 = Reset", 1, 4, 4, 1, function(value)
	preset_fps_reducer = value
	util.toast("Successfully Set preset " .. preset_fps_reducer .. " !! \nNow enable 'Enable Auto Preset'")
end)

local value_toogle_enabled = menu.ref_by_path("Stand>Lua Scripts>[Debug] FPS Reducer>Enable Preset")
local toogle_enabled = menu.get_value(value_toogle_enabled)

-- // Distance rendering and entity handler (need a revision)

util.create_tick_handler(function()
	while true do
		if (preset_fps_reducer == 1 and toogle_enabled == 1) then
			--// Find closest ped and set the alpha
			for ped in entities.get_all_peds_as_handles() do
				if not ENTITY.IS_ENTITY_ON_SCREEN(ped) then
					ENTITY.SET_ENTITY_ALPHA(ped, 0, true) --SET_​ENTITY_​ALPHA(Entity entity, int alphaLevel, BOOL skin)
					ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(ped)
				else
					if ENTITY.GET_ENTITY_ALPHA(ped) == 0 then
						ENTITY.SET_ENTITY_ALPHA(ped, 255, true) --SET_​ENTITY_​ALPHA(Entity entity, int alphaLevel, BOOL skin)
					elseif ENTITY.GET_ENTITY_ALPHA(ped) ~= 210 then
						ENTITY.SET_ENTITY_ALPHA(ped, 210, true) --SET_​ENTITY_​ALPHA(Entity entity, int alphaLevel, BOOL skin)
					end
				end
	
				PED.SET_PED_AO_BLOB_RENDERING(ped, false)
				util.yield(1)
			end
	
			--// Find closest object and set the alpha
			for obj in entities.get_all_objects_as_handles() do
				if not ENTITY.IS_ENTITY_ON_SCREEN(obj) then
					ENTITY.SET_ENTITY_ALPHA(obj, 0, true)
					ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(obj)
				else
					if ENTITY.GET_ENTITY_ALPHA(obj) == 0 then
						ENTITY.SET_ENTITY_ALPHA(obj, 255, true)
					elseif ENTITY.GET_ENTITY_ALPHA(obj) ~= 170 then
						ENTITY.SET_ENTITY_ALPHA(obj, 170, true)
					end
				end
				util.yield(1)
			end
	
	
			GRAPHICS.DISABLE_OCCLUSION_THIS_FRAME()
			GRAPHICS.SET_DISABLE_DECAL_RENDERING_THIS_FRAME()
			GRAPHICS.REMOVE_PARTICLE_FX_IN_RANGE(ENTITY.GET_ENTITY_COORDS(players.user_ped()), 10.0)
			STREAMING.OVERRIDE_LODSCALE_THIS_FRAME(0.4)
			GRAPHICS.SET_ARTIFICIAL_LIGHTS_STATE(true)
		elseif (preset_fps_reducer == 2 and toogle_enabled == 1) then
			--// Find closest ped and set the alpha
			for ped in entities.get_all_peds_as_handles() do
				if not ENTITY.IS_ENTITY_ON_SCREEN(ped) then
					ENTITY.SET_ENTITY_ALPHA(ped, 0, true)
					ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(ped)
				else
					if ENTITY.GET_ENTITY_ALPHA(ped) == 0 then
						ENTITY.SET_ENTITY_ALPHA(ped, 255, true)
					elseif ENTITY.GET_ENTITY_ALPHA(ped) ~= 210 then
						ENTITY.SET_ENTITY_ALPHA(ped, 210, true)
					end
				end
				PED.SET_PED_AO_BLOB_RENDERING(ped, false)
	
				util.yield(1)
			end
	
			--// Find closest object and set the alpha
			for obj in entities.get_all_objects_as_handles() do
				if not ENTITY.IS_ENTITY_ON_SCREEN(obj) then
					ENTITY.SET_ENTITY_ALPHA(obj, 0, true)
					ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(obj)
				else
					if ENTITY.GET_ENTITY_ALPHA(obj) == 0 then
						ENTITY.SET_ENTITY_ALPHA(obj, 255, true)
					elseif ENTITY.GET_ENTITY_ALPHA(ped) ~= 210 then
						ENTITY.SET_ENTITY_ALPHA(ped, 210, true)
					end
				end
				util.yield(1)
			end
	
			GRAPHICS.DISABLE_OCCLUSION_THIS_FRAME()()
			GRAPHICS.REMOVE_PARTICLE_FX_IN_RANGE(ENTITY.GET_ENTITY_COORDS(players.user_ped()), 10.0)
			STREAMING.OVERRIDE_LODSCALE_THIS_FRAME(0.6)
			GRAPHICS.SET_ARTIFICIAL_LIGHTS_STATE(true)
		elseif (preset_fps_reducer == 3 and toogle_enabled == 1) then
			--// Find closest ped and set the alpha
			for ped in entities.get_all_peds_as_handles() do
				if not ENTITY.IS_ENTITY_ON_SCREEN(ped) then
					ENTITY.SET_ENTITY_ALPHA(ped, 0, true)
					ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(ped)
				else
					if ENTITY.GET_ENTITY_ALPHA(ped) == 0 then
						ENTITY.SET_ENTITY_ALPHA(ped, 255, true)
					end
				end
	
				PED.SET_PED_AO_BLOB_RENDERING(ped, false)
				util.yield(1)
			end
		
			--// Find closest object and set the alpha
			for obj in entities.get_all_objects_as_handles() do
				if not ENTITY.IS_ENTITY_ON_SCREEN(obj) then
					ENTITY.SET_ENTITY_ALPHA(obj, 0, true)
					ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(obj)
				else
					if ENTITY.GET_ENTITY_ALPHA(obj) == 0 then
						ENTITY.SET_ENTITY_ALPHA(obj, 255, true)
					end
				end
				util.yield(1)
			end
	
			STREAMING.OVERRIDE_LODSCALE_THIS_FRAME(0.8)
		else
			util.yield(500)
		end
		util.yield(8)
		return true
	end
	return true
end)

util.create_tick_handler(function()
    while true do
        if (preset_fps_reducer == 1 or preset_fps_reducer == 2 and toogle_enabled == 1) then
            AUDIO.CLEAR_ALL_BROKEN_GLASS()
            HUD.CLEAR_ALL_HELP_MESSAGES()
            STATS.LEADERBOARDS_READ_CLEAR_ALL()
            HUD.CLEAR_BRIEF()
            HUD.CLEAR_GPS_FLAGS()
            HUD.CLEAR_PRINTS()
            HUD.CLEAR_SMALL_PRINTS()
            MISC.CLEAR_REPLAY_STATS()
            STATS.LEADERBOARDS_CLEAR_CACHE_DATA()
            STREAMING.CLEAR_FOCUS()
            STREAMING.CLEAR_HD_AREA()
            PED.CLEAR_PED_BLOOD_DAMAGE(players.user_ped())
            PED.CLEAR_PED_WETNESS(players.user_ped())
            PED.CLEAR_PED_ENV_DIRT(players.user_ped())
			PED.RESET_PED_VISIBLE_DAMAGE(players.user_ped())
            GRAPHICS.CLEAR_EXTRA_TCMODIFIER()
            GRAPHICS.CLEAR_TIMECYCLE_MODIFIER()
            MISC.CLEAR_OVERRIDE_WEATHER()
            STREAMING.CLEAR_HD_AREA()
            GRAPHICS.DISABLE_VEHICLE_DISTANTLIGHTS(false)
            GRAPHICS.DISABLE_SCREENBLUR_FADE()
            MISC.SET_RAIN(0.0)
            MISC.SET_WIND_SPEED(0.0)
            util.yield(300)
        elseif (preset_fps_reducer == 3 and toogle_enabled == 1) then
            AUDIO.CLEAR_ALL_BROKEN_GLASS()
            HUD.CLEAR_ALL_HELP_MESSAGES()
            STATS.LEADERBOARDS_READ_CLEAR_ALL()
            HUD.CLEAR_BRIEF()
            HUD.CLEAR_GPS_FLAGS()
            HUD.CLEAR_PRINTS()
            MISC.CLEAR_SMALL_PRINTS()
            MISC.CLEAR_REPLAY_STATS()
            STATS.LEADERBOARDS_CLEAR_CACHE_DATA()
            STREAMING.CLEAR_FOCUS()
            STREAMING.CLEAR_HD_AREA()
            MISC.SET_WIND_SPEED(0.0)
            util.yield(1000)
        else
            util.yield(1500)
        end
		return true
    end
	return true
end)

util.keep_running()

