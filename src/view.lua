function update_view_helper(view, xy, wh, ii)
   local follow_coord = view.follow_act and (view.follow_act[xy]+view.follow_act[ii]/8) or 0
   local view_coord = view[xy]
   local view_dim = view[wh]
   local room_dim = 0 -- g_cur_room[wh]/2-view_dim/2
   local room_coord = 0 -- g_cur_room[xy]+g_cur_room[wh]/2
   local follow_dim = round(view.follow_dim*8)/8

   -- Checking the actor we follow.
   if follow_coord < view_coord-follow_dim then view_coord = follow_coord+follow_dim end
   if follow_coord > view_coord+follow_dim then view_coord = follow_coord-follow_dim end

   -- Next, check the room bounds.
   if view_coord < room_coord-room_dim then view_coord = room_coord-room_dim end
   if view_coord > room_coord+room_dim then view_coord = room_coord+room_dim end

   -- Finally, center the view if the room is too small.
   -- if g_cur_room[wh] <= view[wh] then view_coord = room_coord end

   view[xy] = view_coord
end

-- some utility functions
function scr_x(x) return round((x+g_view.off_x+8-g_view.x)*8) end
function scr_y(y) return round((y+g_view.off_y+8-g_view.y)*8) end

function scr_pset(x, y, c)
   pset(scr_x(x),scr_y(y), c)
end

function scr_rect(x1, y1, x2, y2, col)
   rect(scr_x(x1),scr_y(y1),scr_x(x2)-1,scr_y(y2)-1,col)
end

function scr_rectfill(x1, y1, x2, y2, col)
   rectfill(scr_x(x1),scr_y(y1),scr_x(x2),scr_y(y2),col)
end

function scr_map(cel_x, cel_y, sx, sy, ...)
   map(cel_x, cel_y, scr_x(sx), scr_y(sy), ...)
end

function scr_circfill(x, y, r, col)
   circfill(scr_x(x),scr_y(y), r*8, col)
end

function scr_circ(x, y, r, col)
   circ(scr_x(x),scr_y(y), r*8, col)
end
