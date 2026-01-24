
-----------------------------------------------------------------------
-- LibDBIcon-1.0
-- Allows addons to easily create a lightweight minimap icon
-----------------------------------------------------------------------

local DBICON10 = "LibDBIcon-1.0"
local DBICON10_MINOR = 48

local lib = LibStub:NewLibrary(DBICON10, DBICON10_MINOR)
if not lib then return end

lib.objects = lib.objects or {}
lib.callbackRegistered = lib.callbackRegistered or nil
lib.callbacks = lib.callbacks or LibStub("CallbackHandler-1.0"):New(lib)
lib.tooltip = lib.tooltip or nil
lib.radius = lib.radius or 80

local objects = lib.objects
local callbacks = lib.callbacks

local math_floor = math.floor
local math_sqrt = math.sqrt
local math_sin = math.sin
local math_cos = math.cos
local math_atan2 = math.atan2
local math_pi = math.pi

local function onEnter(self)
	if self.isMoving then return end
	local obj = self.dataObject
	if obj.OnTooltipShow then
		lib.tooltip = lib.tooltip or CreateFrame("GameTooltip", "LibDBIconTooltip", UIParent, "GameTooltipTemplate")
		lib.tooltip:SetOwner(self, "ANCHOR_NONE")
		lib.tooltip:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT")
		obj.OnTooltipShow(lib.tooltip)
		lib.tooltip:Show()
	elseif obj.OnEnter then
		obj.OnEnter(self)
	end
end

local function onLeave(self)
	local obj = self.dataObject
	if lib.tooltip then
		lib.tooltip:Hide()
	end
	if obj.OnLeave then
		obj.OnLeave(self)
	end
end

local function onClick(self, button)
	local obj = self.dataObject
	if obj.OnClick then
		obj.OnClick(self, button)
	end
end

local function onDragStart(self)
	if not self.db or self.db.lock then return end
	self.isMoving = true
	self:SetScript("OnUpdate", function(frame)
		local mx, my = Minimap:GetCenter()
		local px, py = GetCursorPosition()
		local scale = Minimap:GetEffectiveScale()
		px, py = px / scale, py / scale
		local angle = math_atan2(py - my, px - mx)
		frame.db.minimapPos = angle * 180 / math_pi
		frame:UpdatePosition()
	end)
	if lib.tooltip then
		lib.tooltip:Hide()
	end
end

local function onDragStop(self)
	self.isMoving = nil
	self:SetScript("OnUpdate", nil)
end

local function updatePosition(self)
	local angle = self.db.minimapPos or 225
	local radius = self.db.radius or lib.radius
	angle = math_pi * angle / 180
	local x = math_cos(angle) * radius
	local y = math_sin(angle) * radius
	self:ClearAllPoints()
	self:SetPoint("CENTER", Minimap, "CENTER", x, y)
end

function lib:Register(name, obj, db)
	if objects[name] then return end

	local button = CreateFrame("Button", "LibDBIcon10_"..name, Minimap)
	button:SetFrameStrata("MEDIUM")
	button:SetFrameLevel(8)
	button:SetSize(32, 32)
	button:SetHighlightTexture(136477)
	button:RegisterForClicks("AnyUp")
	button:RegisterForDrag("LeftButton")
	button:SetScript("OnEnter", onEnter)
	button:SetScript("OnLeave", onLeave)
	button:SetScript("OnClick", onClick)
	button:SetScript("OnDragStart", onDragStart)
	button:SetScript("OnDragStop", onDragStop)

	local overlay = button:CreateTexture(nil, "OVERLAY")
	overlay:SetSize(54, 54)
	overlay:SetTexture(136430)
	overlay:SetPoint("TOPLEFT")
	button.overlay = overlay

	local background = button:CreateTexture(nil, "BACKGROUND")
	background:SetSize(26, 26)
	background:SetTexture(136467)
	background:SetPoint("CENTER")
	button.background = background

	local icon = button:CreateTexture(nil, "ARTWORK")
	icon:SetSize(18, 18)
	icon:SetPoint("CENTER")
	icon:SetTexture(obj.icon or "Interface\\Icons\\INV_Misc_QuestionMark")
	button.icon = icon

	button.dataObject = obj
	button.db = db
	button.name = name
	button.UpdatePosition = updatePosition

	if db then
		if db.hide then
			button:Hide()
		else
			button:Show()
		end
		button:UpdatePosition()
	else
		button:SetPoint("CENTER", Minimap, "CENTER", -80, 0)
	end

	objects[name] = button
	callbacks:Fire("LibDBIcon_IconCreated", button, name)
end

function lib:Unregister(name)
	if objects[name] then
		objects[name]:Hide()
		objects[name] = nil
	end
end

function lib:Lock(name)
	if objects[name] and objects[name].db then
		objects[name].db.lock = true
	end
end

function lib:Unlock(name)
	if objects[name] and objects[name].db then
		objects[name].db.lock = nil
	end
end

function lib:Hide(name)
	if objects[name] then
		objects[name]:Hide()
	end
end

function lib:Show(name)
	if objects[name] then
		objects[name]:Show()
	end
end

function lib:IsRegistered(name)
	return objects[name] and true or false
end

function lib:Refresh(name, db)
	if objects[name] then
		if db then
			objects[name].db = db
		end
		objects[name]:UpdatePosition()
		if objects[name].db and objects[name].db.hide then
			objects[name]:Hide()
		else
			objects[name]:Show()
		end
	end
end

function lib:GetMinimapButton(name)
	return objects[name]
end

function lib:GetMinimapButtonIconTexture(name)
	if objects[name] then
		return objects[name].icon:GetTexture()
	end
end

function lib:SetMinimapButtonIconTexture(name, texture)
	if objects[name] then
		objects[name].icon:SetTexture(texture)
	end
end
