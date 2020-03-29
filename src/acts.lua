create_actor([['mike', 2,
   {'tcol','dim','inputable','mov','drawable','spr','spr_obj','grounded'}
]], [[
   touchable=true,
   jump_percent = 0,
   rx=.5,
   ry=1,
   iyy=-8,
   x=@1, y=@2,
   sind=192, sw=2, sh=4,
   jump_sinds={194,196,198,200},
   play_sinds={128,130,132,134,136,138,140,142,140,138,136,134,132,130,128},
   tl_loop=true,
   tile_hit=@6,
   {i=nf, u=@3},
   {i=@5, u=@4, tl_max_time=3}
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
   a.sind = a.play_sinds[1+flr(percent*14)]
end, function(a)
   music(1)
end, function(a, dir)
   a.wall_below = true
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

create_actor([['platform', 2, {'wall', 'drawable', 'spr'}
]], [[
   x=@1, y=@2, rx=.5, ry=.5, sind=1, sw=1, sh=2, iyy=-2
]])

create_actor([['long_platform', 2, {'wall', 'drawable', 'spr'}
]], [[
   x=@1, y=@2, rx=8, ry=.5, sind=32, sw=16, sh=2, iyy=-2
]])
