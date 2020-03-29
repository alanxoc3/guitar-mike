_g = gun_vals[[
   scr_fade=0,
   debug=false,
]]

function _init()
   g_tl = {
      --g_logo,
      gun_vals([[
      { i=@1, u=@2, d=@3 }
   ]], function()
      pause'transitioning'
      g_att.fader_in(game_init, unpause)
   end, game_update, game_draw) }
end

function _update60()
   if btnp'5' and btn'4' then _g.debug = not _g.debug end
   tl_node(g_tl,g_tl)
end

function _draw()
   cls(0)
   fade(_g.scr_fade)
   call_not_nil(g_tl, 'd', g_tl)
   fade'0'

   if _g.mike then
      print("y: ".._g.mike.y, 0, 0, 7)
   end
end

function game_update()
   batch_call(acts_loop, [[
      {'act','update'},
      {'mov','move'},
      {'col','move_check',@1},
      {'col','move_check',@4},
      {'trig','trigger_update',@3},
      {'rel','rel_update'},
      {'vec','vec_update'},
      {'bounded','check_bounds'},
      {'grounded','keep_above_ground'},
      {'anim','anim_update'},
      {'timed','tick'},
      {'view','update_view'}
   ]])
end

function game_draw()
   for i=1,100 do
      rect(
         rnd()*128, rnd()*128,
         rnd()*128, rnd()*128,
         1
      )
   end
   scr_rectfill(-8,0,8,16,3)

   acts_loop('drawable', 'd')
   -- :w
   -- _g.mike:d()
end

function game_init()
   _g.mike = g_att.mike(0,0)
   g_view = g_att.view(2.75, 3, 0, _g.mike)
   g_view.off_y=5
end