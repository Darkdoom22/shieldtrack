_addon.name = "Shieldtrack"
_addon.author = "Uwu/Darkdoom"

require('chat')
require('lists')
require('logger')
require('sets')
require('tables')
require('strings')
require('pack')
require('default_settings')
texts = require('texts')
extdata = require('extdata')

Shield = nil
Clock = os.clock()

settings = defaults
Percent_Box = texts.new(settings.player)

function has_value(tab, val)
    for index, value in ipairs(tab) do
       if value == val then
          return true
        end
   end
   return false
end

windower.register_event('load', function()
    
    
    local inventory = windower.ffxi.get_items()
    local bags = {0, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1}
    local shields = {26424, 26429, 26434, 26439, 26444, 26449, 26454, 26459, 26426, 26431, 26436, 26441, 26446,
                     26451, 26456, 26461}
                   
      for k,v in pairs(bags) do

        local bag = windower.ffxi.get_items(k)

        for i=1,bag.count,1 do
      
          if has_value(shields, bag[i].id) == true then
        
            Shield = bag[i]
            inventory = nil
            collectgarbage()
            
          end
        
        end
          
      end
        
  end)

function update_shield()

    local inventory = windower.ffxi.get_items()
    local bags = {0, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1}
    local shields = {26424, 26429, 26434, 26439, 26444, 26449, 26454, 26459, 26426, 26431, 26436, 26441, 26446,
                     26451, 26456, 26461}
                   
    for k,v in pairs(bags) do

      local bag = windower.ffxi.get_items(k)

      for i=1,bag.count,1 do
      --bag[i].id==
        if has_value(shields, bag[i].id) == true then
        
          Shield = bag[i]
          inventory = nil
          collectgarbage()

        end
        
      end
          
    end
      
end


function get_percent()
  
  if Shield ~= nil then

    local data = extdata.decode(Shield)
    Completion_Percent = data.completion / 3
  
  end

end

function box()
  
  if Completion_Percent ~= nil then
    
    box_text = "Current Craftsmanship %: " .. string.sub(Completion_Percent,0,5)
    
    if box_text ~= nil then
      
      Percent_Box:text(box_text)
      Percent_Box:visible(true)
      
    end
    
  end
      
end

windower.register_event('remove item', update_shield)
windower.register_event('remove item', get_percent)
windower.register_event('remove item', box)
  



  
  
  