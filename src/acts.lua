create_actor([['mike', 2,
   {'tcol','dim','inputable','mov','drawable','spr','spr_obj','grounded'}
]], [[
   touchable=true,
   jump_percent = 0,
   rx=.375,
   ry=1,
   iyy=-8,
   xf=true,
   x=@1, y=@2,
   spawns={{x=@1,y=@2}},
   sind=192, sw=2, sh=4,
   jump_sinds={194,196,198,200},
   play_sinds    ={128,130,132,134,136,138,140,142},
   play_end_sinds={140,142,138,136,134,132,130,128},
   tl_loop=true,
   tile_hit=@6,
   {i=nf, u=@3, e=nf},
   {i=@5, u=@4, e=nf, tl_max_time=1.5},
   {i=@8, u=@7, e=@9, tl_max_time=1.5}
]], function(a)
   if a:xbtn() > 0 then
      a.xf = false
   elseif a:xbtn() < 0 then
      a.xf = true
   end

   if not a:is_touching_ground() then
      a.ax=a:xbtn()*.05
   else
      a.ax = 0
   end

   if a:is_touching_ground() and a:btnr(4) then
      a.dy -= a.jump_percent * 1.5
      a.ix = .85
      a.sind = 202
      add(a.spawns, {x=a.x,y=a.y})
      sfx(4,3)
   else
      a.ix = .75
   end
   a.ay += .005

   if a:is_touching_ground() and a:btn(4) then
      if a.jump_percent < 1 then sfx(5,3) end
      a.jump_percent = min(a.jump_percent + .05, 1)
      a.sind = a.jump_sinds[min(1+flr(a.jump_percent*4), 4)]
   else
      a.jump_percent = 0
   end

   if a:is_touching_ground() and not a:btn(4) then
      a.sind = 192
   end

   if not a:is_touching_ground() then
      if abs(a.dy) > .9 then
         a.sind = 202
      elseif abs(a.dy) > .3 then
         a.sind = 204
      else
         a.sind = 206
      end
   end

   if a:is_touching_ground() and not a:btn(4) and a:btnp(5) then
      a.tl_next = true
   end

   a.wall_below = false
end, function(a)
   local percent = a.tl_tim / a.tl_max_time
   a.sind = a.play_sinds[1+flr(percent*8)]
   pal(1,sin(t())*15, 1)
end, function(a)
   _g.jam_count += 1
   music(1)
   g_show_fractal = true
end, function(a, dir)
   if dir == 3 then
      a.wall_below = true
   end
end, function(a)
   local percent = a.tl_tim / a.tl_max_time
   a.sind = a.play_end_sinds[1+flr(percent*8)]
   pal(1,sin(t())*15, 1)
end, function(a)
   local last_spawn = a.spawns[#a.spawns]
   if #a.spawns > 1 then
      del(a.spawns, last_spawn)
   end
   a.x = last_spawn.x
   a.y = last_spawn.y
end, function(a)
   pal(1,1,1)
   g_show_fractal = false
end)

create_actor([['view', 4,
   {'act','confined'},
   {'center_view', 'update_view'}
]], [[
   x=0, y=0, room_crop=2,
   off_x=0, off_y=0,
   tl_loop=true,
   w=@1, h=@2, follow_dim=@3, follow_act=@4,
   update_view=@5,
   center_view=@6,
   change_ma=@7,
   {},
   {tl_max_time=4},
   {follow_act=false}
]],
function(a)
   batch_call(update_view_helper, [[{@1,'x','w','ixx'},{@1,'y','h','iyy'}]],a)
end, function(a)
   if a.follow_act then
      a.x, a.y = a.follow_act.x, a.follow_act.y
   end
   a:update_view()
end, function(a, ma)
   a.follow_act = ma
   a.tl_next = ma and ma.timeoutable and 2 or 1
end)
