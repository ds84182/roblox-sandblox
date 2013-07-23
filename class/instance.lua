local _instance = {}

_instance._extends = {"<<<ROOT>>>"}
_instance._className = "Instance"
_instance.Name = "Object"
_instance.Parent = nil
_instance.Archivable = false
function _instance:ClearAllChildren() --TODO: Security stuff
	for i, v in pairs(self._children) do
		v:Destroy()
	end
	self._children = {}
end
function _instance:Clone() --TODO: Create new self
	if self.Archivable then
		return self -- MEH
	end
end
function _instance:Destroy() --TODO: Set evil erroring Metatable
	if self.Parent then
		for i, v in pairs(self.Parent:GetChildren()) do
			if v == self then
				self.Parent[i] = nil break
			end
		end
	end
	self:ClearAllChildren()
end
function _instance:FindFirstChild(name,recurse)
	for i, v in pairs(self.Parent:GetChildren()) do
		if v.Name == name then
			return v
		else
			if recurse then
				local c = v:FindFirstChild(name,recurse)
				if c then return c end
			end
		end
	end
end
function _instance:GetChildren()
	local t = {}
	for i, v in pairs(self._children) do
		t[#t+1] = v
	end
	return t
end
function _instance:GetFullName()
	local function get(obj,str)
		str = obj.Name..str
		if obj.Parent then
			str = get(obj.Parent,"."..str)
		end
		return str
	end
	return get(self,"")
end
function _instance:IsA(className)
	if self._className == className then return true end
	for i,v in pairs(self._extends) do
		if v == className then return true end
	end
	return false
end
function _instance:IsAncestorOf(dec)
	return self:GetFullName():sub(1,#dec:GetFullName()) == dec:GetFullName()
end
function _instance:IsDescendantOf(anc)
	return anc:IsAncestorOf(self)
end
function _instance:WaitForChild(child)
	while not self._children[child] do wait() end
end

_instance.AncestryChanged, _instance._IAncestryChanged = Event()
_instance.Changed, _instance._IChanged = Event()
_instance.ChildAdded, _instance._IChildAdded = Event()
_instance.ChildRemoved, _instance._IChildRemoved = Event()
_instance.DescendantAdded, _instance._IDescendantAdded = Event()
_instance.DescendantRemoving, _instance._IDescendantRemoving = Event()

return nil,_instance,_instance._className