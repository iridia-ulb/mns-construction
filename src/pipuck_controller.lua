function init()
   reset()
end

function step()
   robot.debug.draw_ring(vector3(0,0,0), 0.125, 0, 0, 255) -- 0,0,255 (blue)
   robot.leds.set_ring_leds(false)
   robot.leds.set_ring_led_index(count, true)
   count = count + 1
   if count > 8 then
      count = 1
   end
end

function reset()
   count = 1
   robot.differential_drive.set_linear_velocity(-0.05, 0.05)
end

function destroy()
end
