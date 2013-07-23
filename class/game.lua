local Game = {}
	
--Game is single instance, so we create an instance on runtime--
Game.instance = nil
Game.isLoaded = false

local _game = {}
extend(_game,_instance)
_game.CreatorId = -1 --This will be replaced on runtime soon
_game.CreatorType = "User"

function _game:GetRemoteBuildMode() return false end
function _game:IsGearTypeAllowed( gearType ) return true end --TODO: Emulate this setting fully
function _game:IsLoaded() return Game.isLoaded end
function _game:GetService( serviceType ) return self._children[serviceType] end _game.service = _game.GetService
function _game:FindService( serviceType ) return self._children[serviceType] end --TODO: Get services working like they should
	
return Game,_game
