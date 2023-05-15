local building = require("lua/buildings/building.lua")
require("lua/utils/reflection.lua")
require("lua/utils/string_utils.lua")

class 'aoe_tower' ( building )

function aoe_tower:__init()
	building.__init(self,self)
end

local debug = false     -- change to enable debug output in the console

local function WriteIfVerbose( text )
    if debug == true and text ~= NIL then
        ConsoleService:Write(text)
    end
end

function aoe_tower:OnInit()
    self.srq = self:CreateStateMachine()
	self.srq:AddState( "working", { execute="OnWorking"} )
    self.range = self.data:GetFloatOrDefault("range", 30)
end

function aoe_tower:OnBuildingEnd()
    self.srq:ChangeState( "working" )
end

function aoe_tower:OnActivate()
	self.srq:ChangeState("working")
end

function aoe_tower:OnDeactivate()
	local state = self.srq:GetState("working")
	if ( state ~= nil ) then
		state:Exit()
	end	 
end







function aoe_tower:OnWorking( state )
    local l_level = BuildingService:GetBuildingLevel( self.entity )

    WriteIfVerbose("aoe tower level: " .. tostring(l_level))
    if (l_level == 1) then
        aoe_tower_mod1_id = ItemService:GetEquippedItem(self.entity, "MOD_1")
        aoe_tower_mod1_bp = EntityService:GetBlueprintName( aoe_tower_mod1_id )
        WriteIfVerbose("aoe_tower_mod1_id: " .. tostring(aoe_tower_mod1_id))
        if (aoe_tower_mod1_id == 4294967295) then
            WriteIfVerbose("aoe_tower_mod1_id is INVALID_ID")
        else
            WriteIfVerbose("aoe_tower_mod1_id is NOT INVALID_ID")
        end
        WriteIfVerbose("aoe_tower_mod1_bp: " ..  tostring(aoe_tower_mod1_bp))
    elseif (l_level == 2) then
        aoe_tower_mod1_id = ItemService:GetEquippedItem(self.entity, "MOD_1")
        aoe_tower_mod1_bp = EntityService:GetBlueprintName( aoe_tower_mod1_id )
            WriteIfVerbose("aoe_tower_mod1_id: " .. tostring(aoe_tower_mod1_id))
            WriteIfVerbose("aoe_tower_mod1_bp: " ..  tostring(aoe_tower_mod1_bp))
        aoe_tower_mod2_id = ItemService:GetEquippedItem(self.entity, "MOD_2")
        aoe_tower_mod2_bp = EntityService:GetBlueprintName( aoe_tower_mod2_id )
            WriteIfVerbose("aoe_tower_mod2_id: " .. tostring(aoe_tower_mod2_id))
            WriteIfVerbose("aoe_tower_mod2_bp: " ..  tostring(aoe_tower_mod2_bp))
    else
        aoe_tower_mod1_id = ItemService:GetEquippedItem(self.entity, "MOD_1")
        aoe_tower_mod1_bp = EntityService:GetBlueprintName( aoe_tower_mod1_id )
            WriteIfVerbose("aoe_tower_mod1_id: " .. tostring(aoe_tower_mod1_id))
            WriteIfVerbose("aoe_tower_mod1_bp: " ..  tostring(aoe_tower_mod1_bp))
        aoe_tower_mod2_id = ItemService:GetEquippedItem(self.entity, "MOD_2")
        aoe_tower_mod2_bp = EntityService:GetBlueprintName( aoe_tower_mod2_id )
            WriteIfVerbose("aoe_tower_mod2_id: " .. tostring(aoe_tower_mod2_id))
            WriteIfVerbose("aoe_tower_mod2_bp: " ..  tostring(aoe_tower_mod2_bp))
        aoe_tower_mod3_id = ItemService:GetEquippedItem(self.entity, "MOD_3")
        aoe_tower_mod3_bp = EntityService:GetBlueprintName( aoe_tower_mod3_id )
            WriteIfVerbose("aoe_tower_mod3_id: " .. tostring(aoe_tower_mod3_id))
            WriteIfVerbose("aoe_tower_mod3_bp: " ..  tostring(aoe_tower_mod3_bp))
    end

    affected_towers = FindService:FindEntitiesByTypeInRadius( self.entity, "tower", self.range )
    for j=1, #affected_towers do
        if affected_towers[j] ~= self.entity and BuildingService:IsBuildingFinished( affected_towers[j] ) then

            local l_affected_towers_level = BuildingService:GetBuildingLevel( affected_towers[j] )

            ConsoleService:Write("affected_tower_name: " .. BuildingService:GetBuildingName(affected_towers[j]))
            ConsoleService:Write("affected_tower_bp: " .. EntityService:GetBlueprintName( affected_towers[j] ))
            ConsoleService:Write("affected_tower_level: " .. tostring(l_affected_towers_level))
            ConsoleService:Write("affected_tower_id: " .. tostring(affected_towers[j]))
            
            if (l_affected_towers_level == 1 and l_level >= 1) then
                affected_towers_mod1_id = ItemService:GetEquippedItem(affected_towers[j], "MOD_1")

                if (affected_towers_mod1_id == 4294967295 and aoe_tower_mod1_id ~= 4294967295) then
                    ItemService:EquipItemInSlot(affected_towers[j], aoe_tower_mod1_id, "MOD_1")
                    EffectService:AttachEffect( affected_towers[j], "effects/messages_and_markers/aoe_modshare_tower_slotted" )
                end

                WriteIfVerbose("affected_towers_mod1_id: " .. tostring(affected_towers_mod1_id))
                if (affected_towers_mod1_id == 4294967295) then
                    WriteIfVerbose("affected_towers_mod1_id is INVALID_ID")
                else
                    WriteIfVerbose("affected_towers_mod1_id is NOT INVALID_ID")
                end
            elseif (l_affected_towers_level == 2 and l_level >= 2) then
                affected_towers_mod1_id = ItemService:GetEquippedItem(affected_towers[j], "MOD_1")
                affected_towers_mod2_id = ItemService:GetEquippedItem(affected_towers[j], "MOD_2")

                if (affected_towers_mod1_id == 4294967295 and aoe_tower_mod1_id ~= 4294967295) then
                    ItemService:EquipItemInSlot(affected_towers[j], aoe_tower_mod1_id, "MOD_1")
                    EffectService:AttachEffect( affected_towers[j], "effects/messages_and_markers/aoe_modshare_tower_slotted" )
                end
                
                if (affected_towers_mod2_id == 4294967295 and aoe_tower_mod2_id ~= 4294967295) then
                    ItemService:EquipItemInSlot(affected_towers[j], aoe_tower_mod2_id, "MOD_2")
                    EffectService:AttachEffect( affected_towers[j], "effects/messages_and_markers/aoe_modshare_tower_slotted" )
                end
            elseif (l_affected_towers_level == 3 and l_level >= 3) then
                affected_towers_mod1_id = ItemService:GetEquippedItem(affected_towers[j], "MOD_1")
                affected_towers_mod2_id = ItemService:GetEquippedItem(affected_towers[j], "MOD_2")
                affected_towers_mod3_id = ItemService:GetEquippedItem(affected_towers[j], "MOD_3")

                if (affected_towers_mod1_id == 4294967295 and aoe_tower_mod1_id ~= 4294967295) then
                    ItemService:EquipItemInSlot(affected_towers[j], aoe_tower_mod1_id, "MOD_1")
                    EffectService:AttachEffect( affected_towers[j], "effects/messages_and_markers/aoe_modshare_tower_slotted" )
                end
                
                if (affected_towers_mod2_id == 4294967295 and aoe_tower_mod2_id ~= 4294967295) then
                    ItemService:EquipItemInSlot(affected_towers[j], aoe_tower_mod2_id, "MOD_2")
                    EffectService:AttachEffect( affected_towers[j], "effects/messages_and_markers/aoe_modshare_tower_slotted" )
                end

                if (affected_towers_mod3_id == 4294967295 and aoe_tower_mod3_id ~= 4294967295) then
                    ItemService:EquipItemInSlot(affected_towers[j], aoe_tower_mod3_id, "MOD_3")
                    EffectService:AttachEffect( affected_towers[j], "effects/messages_and_markers/aoe_modshare_tower_slotted" )
                end
            end
            ConsoleService:Write("-------------------------------------------------------------------------------------------")
        end
    end

end

return aoe_tower