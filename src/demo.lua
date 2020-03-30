_g = gun_vals[[
   scr_fade=0,
   debug=false,
   jam_count=0,
   jump_count=0,
   btns={}
]]

function _init()
   g_tl = {
      g_logo,
      gun_vals([[
      { i=@1, u=@2, d=@3 }
   ]], function()
      pause'transitioning'
      g_att.fader_in(game_init, unpause)
   end, game_update, game_draw) }
end

function _update60()
   -- if btnp'5' and btn'4' then _g.debug = not _g.debug end
   tl_node(g_tl,g_tl)
end

function _draw()
   cls(0)
   fade(_g.scr_fade)
   call_not_nil(g_tl, 'd', g_tl)
   fade'0'

   if _g.debug and _g.mike then
      print("0: "..(_g.mike:btn(0) or "nil"), 0, 0, 7)
      print("1: "..(_g.mike:btn(1) or "nil"), 64, 0, 7)
      print(stat(1), 32, 0, 7)
   end
end

function game_update()
   batch_call(acts_loop, [[
      {'inputable','update_btns'},
      {'act','update'},
      {'mov','move'},
      {'tcol','coll_tile',@1},
      {'rel','rel_update'},
      {'vec','vec_update'},
      {'bounded','check_bounds'},
      {'grounded','keep_above_ground'},
      {'anim','anim_update'},
      {'timed','tick'},
      {'view','update_view'}
   ]], function(x, y)
         return fget(mget(x, y), 0)
      end)
   -- g_view.x = _g.mike.x
   -- g_view.y = _g.mike.y
end

function game_draw()
   if g_show_fractal then
      fractal_draw()
   end
   zprint("guitar mike", scr_x(35), scr_y(25), 0, 12, 1)
   zprint("z to jump!", scr_x(35), scr_y(26), 0, 7, 1)
   zprint("go mike!", scr_x(20), scr_y(25), 0, 7, 1)
   zprint("annoyed?", scr_x(6), scr_y(17), 0, 7, 1)
   zprint("x to jam!", scr_x(7), scr_y(9), 0, 7, 1)
   zprint("haha", scr_x(14), scr_y(14), 0, 7, 1)
   zprint("weeeeeeeeeeee", scr_x(30), scr_y(14), 0, 7, 1)
   zprint("?", scr_x(36), scr_y(8), 0, 7, 1)
   zprint("you smart bro!", scr_x(54), scr_y(2), 0, 10, 4)
   zprint("mwahaha", scr_x(50), scr_y(19), 0, 8, 2)
   zprint("you win", scr_x(50), scr_y(20), 0, 8, 2)
   zprint(" *heh* ", scr_x(50), scr_y(21), 0, 8, 2)

   zprint("ok, you def win this time,", scr_x(77), scr_y(20), 0, 7, 1)
   zprint("because i'm too lazy to", scr_x(77), scr_y(21), 0, 7, 1)
   zprint("finish this game.", scr_x(77), scr_y(22), 0, 7, 1)

   zprint("you jumped ".._g.jump_count.." times!", scr_x(95), scr_y(25), 0, 14, 8)
   zprint("you jammed ".._g.jam_count.." times!", scr_x(95), scr_y(26), 0, 15, 4)

   zprint("have a great day!", scr_x(111), scr_y(18), 0, 7, 1)
   zprint("keep social distancing!", scr_x(113), scr_y(19), 0, 11, 3)
   zprint("music is a weapon btw!", scr_x(114), scr_y(20), 0, 12, 1)
   zprint("@alanxoc3 - code/spr/sfx", scr_x(113), scr_y(22), 0, 8, 2)
   zprint("@cadensings - spr", scr_x(112), scr_y(23), 0, 10, 4)
   zprint("@shuyingyu0327 - photo", scr_x(113), scr_y(24), 0, 14, 2)

   scr_map(0,0,0,0,128,32)
   acts_loop('drawable', 'd')

   call_not_nil(_g.mike, 'd', _g.mike)
   if _g.debug then acts_loop('dim', 'debug_rect') end
end

function game_init()
   fractal_init()
   _g.mike = g_att.mike(35,29)
   g_cur_room = gun_vals[[x=0,y=0,w=125,h=32]]
   g_view = g_att.view(16, 16, 0, _g.mike)
   sfx(2,2)
end
