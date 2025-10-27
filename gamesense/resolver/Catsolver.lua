-- renamed variables for readability
-- DEOBFUSCATED BY MINTEDD
-- DEOBFUSCATED BY MINTEDD
-- DEOBFUSCATED BY MINTEDD
-- DEOBFUSCATED BY MINTEDD
-- DEOBFUSCATED BY MINTEDD
-- DEOBFUSCATED BY MINTEDD

-- Discord: mintedd
-- hackvshack.net: https://hackvshack.net/members/minted.176184/


local bit_lib = require("bit")
local gs_color = require("gamesense/color")

local ui_label_main = ui.new_label("RAGE", "Other", "CATSOLVER")
local cb_mode = ui.new_combobox("RAGE", "Other", "\aCC0000FFMode:", {
  "Resolver + Predict",
  "Lag Function",
  "Exploit Function",
  "Misc Function"
})
local chk_enable_resolver = ui.new_checkbox("RAGE", "Other", "Enable Resolver")
local cb_resolver_mode = ui.new_combobox("RAGE", "Other", "Resolver Mode", {
  "Low", "Medium", "High", "Neverlose", "Exploiter"
})
local cb_prediction_mode = ui.new_combobox("RAGE", "Other", "Prediction Mode", {
  "Static", "Adaptive", "Dynamic", "Neverlose"
})
local s_prediction_strength = ui.new_slider("RAGE", "Other", "Prediction Strength", 0, 50, 15, true, "%")
local s_autofire_threshold = ui.new_slider("RAGE", "Other", "Autofire Threshold", 0, 100, 50, true, "%")
local chk_extra_resolver = ui.new_checkbox("RAGE", "Other", "Enable Extra Resolver")
local ms_priority_hitbox = ui.new_multiselect("RAGE", "Other", "Priority Hitbox", { "Head", "Chest", "Stomach" })
local s_priority_strength = ui.new_slider("RAGE", "Other", "Priority Strength", 1, 100, 50, true, "%")
local chk_anti_dt = ui.new_checkbox("RAGE", "Other", "Anti-DT Resolver")
local chk_clan_tag_spammer = ui.new_checkbox("RAGE", "Other", "Enable Clan Tag Spammer")
local s_clan_tag_speed = ui.new_slider("RAGE", "Other", "Clan Tag Change Speed", 1, 20, 5, true, "s", 0.1)

client.set_event_callback("aim_fire", function(ev)
  if not ui.get(chk_anti_dt) then return end
  local local_idx = entity.get_local_player()
  if not local_idx then return end
  local players = entity.get_players(true)
  for _, p in ipairs(players) do
    if not entity.is_alive(p) then goto cont end
    local sim = entity.get_prop(p, "m_flSimulationTime") or 0
    local old_sim = entity.get_prop(p, "m_flOldSimulationTime") or 0
    local diff = sim - old_sim
    if diff < 0.01 then
      local eye = entity.get_prop(p, "m_angEyeAngles[1]") or 0
      entity.set_prop(p, "m_angEyeAngles[1]", eye + math.random(-45, 45))
    end
    ::cont::
  end
end)

local chk_instant_peek = ui.new_checkbox("RAGE", "Other", "Enable Instant Peek Resolver")
local s_instant_peek_strength = ui.new_slider("RAGE", "Other", "Instant Peek Strength", 0, 60, 30, true, "%")
local chk_anti_prediction_position = ui.new_checkbox("RAGE", "Other", "Enable Anti-Prediction Position")
local s_anti_prediction_strength = ui.new_slider("RAGE", "Other", "Anti-Prediction Strength", 0, 90, 45, true, "%")
local chk_lag_peak = ui.new_checkbox("RAGE", "Other", "Enable Lag Peak")
local s_lag_peak_strength = ui.new_slider("RAGE", "Other", "Lag Peak Strength", 0, 100, 50, true, "%")
local chk_anti_defensive_dt = ui.new_checkbox("RAGE", "Other", "Enable Anti-Defensive DT")
local s_anti_defensive_dt_ticks = ui.new_slider("RAGE", "Other", "Anti-Defensive DT Strength", 0, 20, 10, true, "ticks")
local chk_fake_flick = ui.new_checkbox("RAGE", "Other", "Enable Fake Flick Exploit")
local s_fake_flick_strength = ui.new_slider("RAGE", "Other", "Fake Flick Strength", 0, 90, 45, true, "%")
local chk_internal_backtrack = ui.new_checkbox("RAGE", "Other", "Enable Internal Backtrack")
local s_backtrack_ticks = ui.new_slider("RAGE", "Other", "Backtrack Ticks", 0, 100, 45, true, "%")
local chk_enable_lag_exploit = ui.new_checkbox("RAGE", "Other", "Enable Lag Exploit")
local chk_trash_talk = ui.new_checkbox("RAGE", "Other", "Enable Trash Talk")
local cb_trash_talk_mode = ui.new_combobox("RAGE", "Other", "Trash Talk Mode", { "Trash", "Trash with ads" })

local clan_tags = {
  "CATSOLVER DEOBF BY MINTEDD",
  "CATSOLVER DEOBF BY MINTEDD ",
  "CATSOLVER DEOBF BY MINTEDD  ",
  " CATSOLVER DEOBF BY MINTEDD ",
  "  CATSOLVER DEOBF BY MINTEDD",
  "ATSOLVER DEOBF BY MINTEDD  ",
  "TSOLVER DEOBF BY MINTEDD  C",
  "SOLVER DEOBF BY MINTEDD  CA",
  "OLVER DEOBF BY MINTEDD  CAT",
  "LVER DEOBF BY MINTEDD  CATS",
  "VER DEOBF BY MINTEDD  CATSO",
  "ER DEOBF BY MINTEDD  CATSOL",
  "R DEOBF BY MINTEDD  CATSOLV",
  " DEOBF BY MINTEDD  CATSOLVE",
  "DEOBF BY MINTEDD  CATSOLVER",
  "EOBF BY MINTEDD  CATSOLVER ",
  "OBF BY MINTEDD  CATSOLVER D",
  "BF BY MINTEDD  CATSOLVER DE",
  "F BY MINTEDD  CATSOLVER DEO",
  " BY MINTEDD  CATSOLVER DEOB",
  "BY MINTEDD  CATSOLVER DEOBF",
  "Y MINTEDD  CATSOLVER DEOBF ",
  " MINTEDD  CATSOLVER DEOBF BY",
  "MINTEDD  CATSOLVER DEOBF BY ",
  "INTEDD  CATSOLVER DEOBF BY M",
  "NTEDD  CATSOLVER DEOBF BY MI",
  "TEDD  CATSOLVER DEOBF BY MIN",
  "EDD  CATSOLVER DEOBF BY MINT",
  "DD  CATSOLVER DEOBF BY MINTE",
  "D  CATSOLVER DEOBF BY MINTED",
  "  CATSOLVER DEOBF BY MINTEDD",
  " CATSOLVER DEOBF BY MINTEDD ",
  "CATSOLVER DEOBF BY MINTEDD  "
}

local clan_last_update, clan_index = 0, 1

local function update_clan_tag()
  if not ui.get(chk_clan_tag_spammer) then client.set_clan_tag("") return end
  local now = globals.realtime()
  local speed = ui.get(s_clan_tag_speed) * 0.1
  if now - clan_last_update >= speed then
    client.set_clan_tag(clan_tags[clan_index])
    clan_index = clan_index + 1
    if clan_index > #clan_tags then clan_index = 1 end
    clan_last_update = now
  end
end

local last_eyeangles = {}
local last_velocity = {}

local function compute_prediction_offset(player)
  if not ui.get(chk_enable_resolver) then return end
  if not player or not entity.is_alive(player) then return end

  local vx = entity.get_prop(player, "m_vecVelocity[0]") or 0
  local vy = entity.get_prop(player, "m_vecVelocity[1]") or 0
  local speed = math.sqrt(vx^2 + vy^2)

  local pred_mode = ui.get(cb_prediction_mode)
  local pred_strength = ui.get(s_prediction_strength)
  local offset = 0
  local cur_eye = entity.get_prop(player, "m_angEyeAngles[1]") or 0

  if pred_mode == "Static" then
    offset = pred_strength
  elseif pred_mode == "Adaptive" then
    offset = pred_strength * (speed / 250)
  elseif pred_mode == "Dynamic" then
    offset = pred_strength * (speed / 300) + math.random(-5, 5)
  elseif pred_mode == "Neverlose" then
    local prev_eye = last_eyeangles[player] or cur_eye
    local prev_speed = last_velocity[player] or speed
    local delta_eye = cur_eye - prev_eye
    local delta_speed = speed - prev_speed
    offset = delta_eye + (delta_speed * (pred_strength / 100))
    last_eyeangles[player] = cur_eye
    last_velocity[player] = speed
  end

  return offset
end

local function apply_anti_prediction_position(cmd)
  if not ui.get(chk_anti_prediction_position) then return end
  local me = entity.get_local_player()
  if not me or not entity.is_alive(me) then return end
  local strength = ui.get(s_anti_prediction_strength)
  local yaw = cmd.yaw
  local jitter = math.random(-strength, strength)
  cmd.yaw = yaw + jitter
end

local function apply_prediction_to_all()
  local pred_strength = ui.get(s_prediction_strength) or 0
  local players = entity.get_players(true)
  for _, p in ipairs(players) do
    local offset = compute_prediction_offset(p)
    if offset then
      local cur = entity.get_prop(p, "m_angEyeAngles[1]") or 0
      entity.set_prop(p, "m_angEyeAngles[1]", cur + offset)
    end
  end
end

local normalize_angle = function(a)
  a = tonumber(a) or 0
  while a > 180 do a = a - 360 end
  while a < -180 do a = a + 360 end
  return a
end

local last_hurt_time = globals.curtime()

client.set_event_callback("player_hurt", function(e)
  local whom = client.userid_to_entindex(e.userid)
  if whom == entity.get_local_player() then last_hurt_time = globals.curtime() end
end)

client.set_event_callback("create_move", function(cmd)
  if not ui.get(chk_internal_backtrack) then return end
  local me = entity.get_local_player()
  if not me or not entity.is_alive(me) then return end
  local eye = entity.get_prop(me, "m_angEyeAngles[1]") or 0
  local since_hurt = globals.curtime() - last_hurt_time
  if since_hurt < 2 then
    entity.set_prop(me, "m_angEyeAngles[1]", eye + math.random(-45, 45))
  else
    entity.set_prop(me, "m_angEyeAngles[1]", eye + math.random(-15, 15))
  end
end)

local function apply_resolver_to_player(player)
  if not ui.get(chk_enable_resolver) or not player or not entity.is_alive(player) then return end
  local cur_eye = entity.get_prop(player, "m_angEyeAngles[1]") or 0
  local mode = ui.get(cb_resolver_mode)
  local strength = ui.get(s_prediction_strength) or 0

  if mode == "Low" then
    cur_eye = cur_eye + strength / 2
  elseif mode == "Medium" then
    cur_eye = cur_eye + math.random(-strength, strength)
  elseif mode == "High" then
    cur_eye = cur_eye + ((globals.tickcount() % 2 == 0) and strength or -strength)
  elseif mode == "Neverlose" then
    cur_eye = cur_eye + math.random(-60, 60)
  elseif mode == "Exploiter" then
    cur_eye = cur_eye + 35
  end

  cur_eye = normalize_angle(cur_eye)
  entity.set_prop(player, "m_angEyeAngles[1]", cur_eye)
end

local function apply_fake_flick_on_fire(cmd)
  if not ui.get(cb_mode) or not ui.get(chk_fake_flick) then return end
  if bit_lib.band(cmd.buttons, 1) ~= 0 then
    local flick = ui.get(s_fake_flick_strength)
    cmd.yaw = cmd.yaw + (math.random(0, 1) == 1 and flick or -flick)
  end
end

client.set_event_callback("create_move", function(cmd)
  if not ui.get(chk_enable_lag_exploit) then return end
  local me = entity.get_local_player()
  if not me then return end
  local players = entity.get_players(true)
  for _, p in ipairs(players) do
    if entity.is_alive(p) then
      local active_and_shot = (entity.get_prop(p, "m_hActiveWeapon") and bit_lib.band(entity.get_prop(p, "m_iShotsFired") or 0, 1)) ~= 0
      if active_and_shot then
        cmd.choked_commands = 14
        return
      end
    end
  end
end)

local function update_ui_visibility()
  local mode_enabled = ui.get(cb_mode)
  local mode_value = ui.get(cb_mode)
  local resolver_mode = ui.get(cb_resolver_mode)
  local prediction_mode = ui.get(cb_prediction_mode)

  local requires_high_resolver = (resolver_mode == "High" or resolver_mode == "Neverlose" or resolver_mode == "Exploiter")
  local requires_dynamic_prediction = (prediction_mode == "Dynamic" or prediction_mode == "Neverlose")

  local show_resolve_predict = mode_enabled and requires_high_resolver and requires_dynamic_prediction
  local is_resolver_plus_predict = mode_enabled and mode_value == "Resolver + Predict"
  local is_lag_function = mode_enabled and mode_value == "Lag Function"
  local is_exploit_function = mode_enabled and mode_value == "Exploit Function"
  local is_misc_function = mode_enabled and mode_value == "Misc Function"

  ui.set_visible(chk_enable_resolver, is_resolver_plus_predict)
  ui.set_visible(cb_resolver_mode, is_resolver_plus_predict and ui.get(chk_enable_resolver))
  ui.set_visible(chk_extra_resolver, is_resolver_plus_predict and ui.get(chk_enable_resolver))
  ui.set_visible(ms_priority_hitbox, is_resolver_plus_predict and ui.get(chk_extra_resolver))
  ui.set_visible(s_priority_strength, is_resolver_plus_predict and ui.get(chk_extra_resolver))
  ui.set_visible(cb_prediction_mode, is_resolver_plus_predict and ui.get(chk_enable_resolver))
  ui.set_visible(s_prediction_strength, is_resolver_plus_predict and ui.get(chk_enable_resolver))
  ui.set_visible(s_autofire_threshold, is_resolver_plus_predict and show_resolve_predict)
  ui.set_visible(chk_anti_dt, is_resolver_plus_predict)
  ui.set_visible(chk_anti_defensive_dt, is_resolver_plus_predict)
  ui.set_visible(s_anti_defensive_dt_ticks, is_resolver_plus_predict and ui.get(chk_anti_defensive_dt))
  ui.set_visible(chk_anti_prediction_position, is_resolver_plus_predict)
  ui.set_visible(s_anti_prediction_strength, is_resolver_plus_predict and ui.get(chk_anti_prediction_position))
  ui.set_visible(chk_lag_peak, is_lag_function)
  ui.set_visible(s_lag_peak_strength, is_lag_function and ui.get(chk_lag_peak))
  ui.set_visible(chk_enable_lag_exploit, is_lag_function)
  ui.set_visible(chk_fake_flick, is_exploit_function)
  ui.set_visible(s_fake_flick_strength, is_exploit_function and ui.get(chk_fake_flick))
  ui.set_visible(chk_internal_backtrack, is_exploit_function)
  ui.set_visible(s_backtrack_ticks, is_exploit_function and ui.get(chk_internal_backtrack))
  ui.set_visible(chk_instant_peek, is_resolver_plus_predict)
  ui.set_visible(s_instant_peek_strength, is_resolver_plus_predict and ui.get(chk_instant_peek))
  ui.set_visible(chk_trash_talk, is_misc_function)
  ui.set_visible(cb_trash_talk_mode, is_misc_function and ui.get(chk_trash_talk))
  ui.set_visible(chk_clan_tag_spammer, is_misc_function)
  ui.set_visible(s_clan_tag_speed, is_misc_function and ui.get(chk_clan_tag_spammer))
end

ui.set_callback(cb_mode, update_ui_visibility)
ui.set_callback(chk_enable_resolver, update_ui_visibility)
ui.set_callback(cb_resolver_mode, update_ui_visibility)
ui.set_callback(cb_prediction_mode, update_ui_visibility)
ui.set_callback(chk_lag_peak, update_ui_visibility)
ui.set_callback(chk_enable_lag_exploit, update_ui_visibility)
ui.set_callback(chk_fake_flick, update_ui_visibility)
ui.set_callback(chk_internal_backtrack, update_ui_visibility)
ui.set_callback(chk_extra_resolver, update_ui_visibility)
ui.set_callback(chk_trash_talk, update_ui_visibility)
ui.set_callback(chk_anti_dt, update_ui_visibility)
ui.set_callback(chk_instant_peek, update_ui_visibility)
ui.set_callback(chk_anti_defensive_dt, update_ui_visibility)
ui.set_callback(chk_clan_tag_spammer, update_ui_visibility)
ui.set_callback(s_clan_tag_speed, update_ui_visibility)
ui.set_callback(chk_anti_prediction_position, update_ui_visibility)
ui.set_callback(s_anti_prediction_strength, update_ui_visibility)

local function adjust_priority_hitbox(player)
  if not ui.get(chk_extra_resolver) then return end
  if not player or not entity.is_alive(player) then return end
  local picks = ui.get(ms_priority_hitbox)
  local adjustments = {}

  for _, v in ipairs(picks) do
    if v == "Head" then table.insert(adjustments, 0)
    elseif v == "Chest" then table.insert(adjustments, 2)
    elseif v == "Stomach" then table.insert(adjustments, 3) end
  end

  if #adjustments == 0 then return end
  local priority = ui.get(s_priority_strength) or 10
  local cur_eye = entity.get_prop(player, "m_angEyeAngles[1]") or 0

  for _, hit in ipairs(adjustments) do
    if hit == 0 then cur_eye = cur_eye + priority
    elseif hit == 2 then cur_eye = cur_eye + priority / 2
    elseif hit == 3 then cur_eye = cur_eye - priority / 2 end
  end

  entity.set_prop(player, "m_angEyeAngles[1]", cur_eye)
end

local function apply_lag_peak(cmd)
  if not ui.get(cb_mode) or not ui.get(chk_lag_peak) then return end
  local strength = ui.get(s_lag_peak_strength)
  local jitter = math.random(-strength, strength)
  cmd.yaw = cmd.yaw + jitter
end

client.set_event_callback("create_move", function()
  if not ui.get(chk_instant_peek) then return end
  local players = entity.get_players(true)
  for _, p in ipairs(players) do
    if entity.is_alive(p) then
      local vx = entity.get_prop(p, "m_vecVelocity[0]") or 0
      local vy = entity.get_prop(p, "m_vecVelocity[1]") or 0
      local spd = math.sqrt(vx^2 + vy^2)
      if spd > 250 then
        local eye = entity.get_prop(p, "m_angEyeAngles[1]") or 0
        local strength = ui.get(s_instant_peek_strength)
        entity.set_prop(p, "m_angEyeAngles[1]", eye + math.random(-strength, strength))
      end
    end
  end
end)

local trash_talk_messages = {
  ["Trash"] = {
    "1 ezz",
    "Cry n1gga",
    "Ohh, sorry i fuSCK1ng your mom, and k1ll1ng y0ur sister",
    "1 = your iq",
    "pls delete cs:go and go cry about it mom",
    "Ez"
  },
  ["Trash with ads"] = {
    "U fucking by dsc.gg/newerahvh - The Best Resolver",
    "Oh sry 1, dsc.gg/newerahvh 3$ for resolver, ez",
    "Why u cry? i use dsc.gg/newerahvh, 3$ for use",
    "Pls leave hvh or buy resolver, dsc.gg/newerahvh!",
    "Your resolver is ugly, better buy this dsc.gg/newerahvh",
    "Your mom fuSCK1ng by dsc.gg/newerahvh"
  }
}

local function say_trash_talk()
  if not ui.get(chk_trash_talk) then return end
  local mode = ui.get(cb_trash_talk_mode)
  local pool = trash_talk_messages[mode]
  if pool then
    local line = pool[math.random(#pool)]
    client.exec("say '" .. line)
  end
end

client.set_event_callback("player_death", function(ev)
  local attacker = client.userid_to_entindex(ev.attacker)
  local me = entity.get_local_player()
  if attacker == me then say_trash_talk() end
end)

local function apply_instant_fire_chance(cmd)
  if not ui.get(cb_mode) or not ui.get(chk_enable_resolver) then return end
  if not (ui.get(cb_resolver_mode) == "High" or ui.get(cb_resolver_mode) == "Neverlose") then return end
  if not (ui.get(cb_prediction_mode) == "Dynamic" or ui.get(cb_prediction_mode) == "Neverlose") then return end
  local chance = ui.get(s_autofire_threshold)
  local me = entity.get_local_player()
  if not me or not entity.is_alive(me) then return end
  local players = entity.get_players(true)
  for _, p in ipairs(players) do
    if entity.is_alive(p) then
      if math.random(0, 100) <= chance then cmd.buttons = bit_lib.bor(cmd.buttons, 1) end
    end
  end
end

local function apply_shift_tick(cmd)
  if not ui.get(cb_mode) or not ui.get(chk_anti_defensive_dt) then return end
  local base_ticks = ui.get(s_anti_defensive_dt_ticks)
  local shift = base_ticks
  local players = entity.get_players(true)
  for _, p in ipairs(players) do
    local sim = entity.get_prop(p, "m_flSimulationTime")
    if sim and sim > 0 then shift = shift + 2 end
  end
  cmd.shift_tick = shift
end

local function handle_create_move(cmd)
  apply_instant_fire_chance(cmd)
  apply_shift_tick(cmd)
  apply_lag_peak(cmd)
  apply_fake_flick_on_fire(cmd)
end

local function exploiter_tick_adjustment(cmd)
  if not ui.get(cb_mode) or ui.get(cb_resolver_mode) ~= "Exploiter" then return end
  local players = entity.get_players(true)
  for _, p in ipairs(players) do
    if entity.is_alive(p) then
      local ticks = ui.get(s_backtrack_ticks)
      cmd.tick_count = globals.tickcount - ticks
    end
  end
end

local function backtrack_tick_adjustment(cmd)
  if not ui.get(chk_internal_backtrack) then return end
  local me = entity.get_local_player()
  if not me or not entity.is_alive(me) then return end
  local ticks = ui.get(s_backtrack_ticks) or 0
  cmd.tick_count = globals.tickcount() - ticks
end

local function apply_extra_resolver_global()
  if not ui.get(chk_extra_resolver) then return end
  local me = entity.get_local_player()
  if not me or not entity.is_alive(me) then return end
  local players = entity.get_players(true)
  for _, p in ipairs(players) do
    if entity.is_alive(p) then
      local cur = entity.get_prop(p, "m_angEyeAngles[1]") or 0
      local picks = ui.get(ms_priority_hitbox)
      local chosen = {}
      for _, v in ipairs(picks) do
        if v == "Head" then table.insert(chosen, 0)
        elseif v == "Chest" then table.insert(chosen, 2)
        elseif v == "Stomach" then table.insert(chosen, 3) end
      end
      if #chosen == 0 then return end
      local priority = ui.get(s_priority_strength)
      cur = cur + (priority / #chosen)
      entity.set_prop(p, "m_angEyeAngles[1]", cur)
    end
  end
end

client.set_event_callback("create_move", exploiter_tick_adjustment)
client.set_event_callback("paint", apply_prediction_to_all)
client.set_event_callback("paint", function()
  local players = entity.get_players(true)
  for _, p in ipairs(players) do apply_resolver_to_player(p) end
end)
client.set_event_callback("create_move", apply_anti_prediction_position)
client.set_event_callback("paint", update_clan_tag)
update_ui_visibility()
