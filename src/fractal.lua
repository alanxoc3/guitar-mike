function fractal_gen(p,d)
   for i=0,3 do a=i/4+.125
      l=add(g_fractals,{x=p.x+p.r*cos(a),y=p.y+p.r*sin(a),r=p.r/2})
      if d>0 then
         fractal_gen(l,d-1)
      end
   end
end

function fractal_init()
   g_fractals={{x=64,y=64,r=64}}
   fractal_gen(g_fractals[1],2)
end

function fractal_draw()
   o=t()/2
   for c in all(g_fractals) do
      circ(c.x+cos(o)*sin(o/7)*5, c.y+sin(o)*cos(o/3)*5,abs(c.r*(sin(o)*6+15)), 1)
   end
end
