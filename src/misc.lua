function destroy_effect(a, num, ...)
   for i=1,num do
      g_att.thing_destroyed(a, rnd_item(...), rnd(.5)+.1)
   end
end

function destroy_func(a)
   g_att.money(a.x, a.y, a.dx, a.dy)
end

-- this file contains the logic for loading and saving a game.

g_save_spots = gun_vals([[
   {x=02,  y=12, room='h_ban'},
   {x=52,  y=60, room='for_4'},
   {x=69,  y=17, room='cas_3'},
   {x=123, y=14, room='tom_2'},
   {x=123, y=60, room='tec_1'}
]])

-- token history: 128 103 97 69 81 49 88 104 136 108 95 92 103 73 66 64 56

g_logo = gun_vals([[
      { tl_name='logo', x=64, y=64, u=nf, d=@1, tl_max_time=2.5 }
   ]], function(a)
   local logo = a.logo
   _g.scr_fade = 8+cos(logo.tl_tim/logo.tl_max_time)*4-4

   camera(_g.scr_fade > 1 and rnd_one())
   zspr(76, logo.x, logo.y, 4, 2)
   camera()
end
)

-- params: initCallback, endCallback
create_actor([['fader_out', 2, {'act'}, {'update'}]], [[
   i=@1, e=@2,u=@3,
   {tl_name='timeline', tl_max_time=FADE_TIME}
]], function(a)
   _g.scr_fade = max(a.timeline.tl_tim/a.timeline.tl_max_time*10, _g.scr_fade)
end)

-- params: initCallback, endCallback
create_actor([['fader_in', 2, {'act'}, {'update'}]], [[
   i=@1, e=@2,u=@3,
   {tl_name='timeline', tl_max_time=FADE_TIME}
]], function(a)
   _g.scr_fade = min((a.timeline.tl_max_time-a.timeline.tl_tim)/a.timeline.tl_max_time*10,_g.scr_fade)
end)

-------------
-- Pausing --
-------------
function pause(reason)
   g_pause_reason=reason g_game_paused=true
end

function unpause()
   g_game_paused=false
end

function is_game_paused(reason)
   return g_game_paused and (reason == g_pause_reason or not reason)
end
