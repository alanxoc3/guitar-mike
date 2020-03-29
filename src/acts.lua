create_actor([['mike', 2,
   {'dim','inputable','mov','drawable','spr','spr_obj','grounded'}
]], [[
   jump_percent = 0,
   rx=.625,
   ry=1,
   iyy=-8,
   x=@1, y=@2,
   sind=192, sw=2, sh=4,
   jump_sinds={194,196,198,200},
   u=@3
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
   else
      a.ay += .005
      a.ix = .75
   end

   if a:is_touching_ground() and a:btn(4) then
      a.jump_percent = min(a.jump_percent + .05, 1)
      a.sind = a.jump_sinds[min(1+flr(a.jump_percent*4), 4)]
   else
      a.jump_percent = 0
   end

   if a:is_touching_ground() and not a:btn(4) then
      a.sind = 192
   end

   if not a:is_touching_ground() then
      if abs(a.dy) > .3 then
         a.sind = 204
      else
         a.sind = 206
      end
   end
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
