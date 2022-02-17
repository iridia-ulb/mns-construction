function init()
   reset()
end

function step()
   robot.debug.draw_arrow(vector3(0,0,0), vector3(0,0,-0.250), 'red')
   --robot.debug.draw_ring(vector3(0,0,0), 0.125, 0, 0, 255) -- 0,0,255 (blue)
   --robot.debug.write('hello')
   --robot.debug.write('world')
end

function reset()
   for id, interface in pairs(robot.cameras_system) do
      interface.enable()
   end
   robot.flight_system.set_target_pose(vector3(0,1,1), 0)
end

function destroy()
end
