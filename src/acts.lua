create_actor([['mike', 2,
   {'mov','drawable','spr','spr_obj','grounded'}
]], [[
   iyy=-11,
   x=@1, y=@2,
   sind=192, sw=2, sh=4,
   u=@3
]], function(a)
   if not a:is_touching_ground() then
      a.ax=xbtn()*.05
   else
      a.ax = 0
   end

   if a:is_touching_ground() and btn(4) then
      a.dy -= 1.2
      a.ix = .85
   else
      a.ay += .005
      a.ix = .75
   end

end
)

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

