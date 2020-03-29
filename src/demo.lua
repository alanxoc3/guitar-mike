_g = gun_vals[[
   scr_fade=0,
   debug=false,
   btns={}
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

   if _g.debug and _g.mike then
      print("0: "..(_g.mike:btn(0) or "nil"), 0, 0, 7)
      print("1: "..(_g.mike:btn(1) or "nil"), 64, 0, 7)
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
   scr_map(0,0,0,0,64,64)
   acts_loop('drawable', 'd')

   call_not_nil(_g.mike, 'd', _g.mike)
   if _g.debug then acts_loop('dim', 'debug_rect') end
end

function game_init()
   _g.mike = g_att.mike(0,0)
   g_cur_room = gun_vals[[x=0,y=0,w=64,h=64]]
   g_view = g_att.view(16, 16, 1, _g.mike)
   g_view.off_y=5
   sfx(2,2)
end
