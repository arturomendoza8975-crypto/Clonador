-- ========================================================
-- SCRIPT OFICIAL CANDELA - CLONADOR + MODS INTERNOS
-- Especial para Candela Roblox | Optimizado para Delta Executor
-- ========================================================

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TextChatService = game:GetService("TextChatService")
local LocalPlayer = Players.LocalPlayer

-- Limpieza preventiva
if game:CoreGui:FindFirstChild("CandelaHubGUI") then
    game:CoreGui.CandelaHubGUI:Destroy()
end

-- 1. CREACIÓN DE LA INTERFAZ ESTILO DISCOTECA (DARK)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CandelaHubGUI"
ScreenGui.Parent = game:CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 340, 0, 420)
MainFrame.Position = UDim2.new(0.5, -170, 0.25, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = MainFrame

-- Título Principal
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 45)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "CANDELA HUB 💃🔥"
Title.TextColor3 = Color3.fromRGB(255, 60, 120)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

-- Botón Cerrar (✕)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -40, 0, 5)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = MainFrame
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- SECCIÓN 1: PANEL DE COMANDOS RÁPIDOS DE CANDELA
local CmdFrame = Instance.new("Frame")
CmdFrame.Size = UDim2.new(1, -30, 0, 80)
CmdFrame.Position = UDim2.new(0, 15, 0, 50)
CmdFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
CmdFrame.Parent = MainFrame

local CmdCorner = Instance.new("UICorner")
CmdCorner.CornerRadius = UDim.new(0, 8)
CmdCorner.Parent = CmdFrame

local function enviarComandoChat(textoCmd)
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        local channel = TextChatService.TextChannels.RBXGeneral
        channel:SendAsync(textoCmd)
    else
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(textoCmd, "All")
    end
end

-- Botones de comandos integrados de Candela
local function crearBtnCmd(texto, comando, x, y, w, h, color)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, w, 0, h)
    b.Position = UDim2.new(0, x, 0, y)
    b.BackgroundColor3 = color
    b.Text = texto
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 11
    b.Font = Enum.Font.GothamBold
    b.Parent = CmdFrame
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 5) c.Parent = b
    b.MouseButton1Click:Connect(function() enviarComandoChat(comando) end)
end

crearBtnCmd("Invisible Head", "/Headless", 10, 10, 135, 25, Color3.fromRGB(50, 50, 60))
crearBtnCmd("Quitar Headless", "/Unheadless", 155, 10, 135, 25, Color3.fromRGB(50, 50, 60))
crearBtnCmd("Pata Korblox", "/Korblox", 10, 45, 90, 25, Color3.fromRGB(50, 50, 60))
crearBtnCmd("Hacerse Enano", "/size 0.5", 110, 45, 90, 25, Color3.fromRGB(70, 40, 100))
crearBtnCmd("Normal", "/re", 210, 45, 80, 25, Color3.fromRGB(120, 30, 30))

-- SECCIÓN 2: EL MULTI-CLONADOR DE AVATARES
local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(1, -30, 0, 38)
InputBox.Position = UDim2.new(0, 15, 0, 145)
InputBox.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.PlaceholderText = "Inserta Nombre o ID del objetivo..."
InputBox.Text = ""
InputBox.TextSize = 13
InputBox.Font = Enum.Font.Gotham
InputBox.Parent = MainFrame
local IBC = Instance.new("UICorner") IBC.CornerRadius = UDim.new(0, 6) IBC.Parent = InputBox

local SearchBtn = Instance.new("TextButton")
SearchBtn.Size = UDim2.new(1, -30, 0, 38)
SearchBtn.Position = UDim2.new(0, 15, 0, 190)
SearchBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 120)
SearchBtn.Text = "Buscar Trajes Guardados"
SearchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBtn.TextSize = 13
SearchBtn.Font = Enum.Font.GothamBold
SearchBtn.Parent = MainFrame
local SBC = Instance.new("UICorner") SBC.CornerRadius = UDim.new(0, 6) SBC.Parent = SearchBtn

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, -30, 0, 20)
SubTitle.Position = UDim2.new(0, 15, 0, 235)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Lista de Atuendos Disponibles:"
SubTitle.TextColor3 = Color3.fromRGB(160, 160, 170)
SubTitle.TextSize = 11
SubTitle.Font = Enum.Font.GothamBold
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = MainFrame

-- Lista Deslizable
local ScrollList = Instance.new("ScrollingFrame")
ScrollList.Size = UDim2.new(1, -30, 0, 150)
ScrollList.Position = UDim2.new(0, 15, 0, 255)
ScrollList.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
ScrollList.BorderSizePixel = 0
ScrollList.ScrollBarThickness = 4
ScrollList.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollList.Parent = MainFrame
local SLC = Instance.new("UICorner") SLC.CornerRadius = UDim.new(0, 6) SLC.Parent = ScrollList

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollList
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end)

-- Lógica para equipar la skin elegida de la lista
local function aplicarApariencia(tipo, idAdquirido)
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    SearchBtn.Text = "Equipando Outfit..."
    local success, desc = pcall(function()
        if tipo == "Actual" then
            return Players:GetHumanoidDescriptionFromUserId(idAdquirido)
        else
            return Players:GetHumanoidDescriptionFromOutfitId(idAdquirido)
        end
    end)
    
    if success and desc then
        humanoid:ApplyDescription(desc)
        SearchBtn.Text = "¡Outfit Clonado con Éxito! ✨"
    else
        SearchBtn.Text = "❌ Error en servidores de Roblox"
    end
    task.wait(1.5)
    SearchBtn.Text = "Buscar Trajes Guardados"
end

local function crearBotonAtuendo(nombre, id, tipo)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -10, 0, 40)
    Btn.BackgroundColor3 = tipo == "Actual" and Color3.fromRGB(30, 60, 45) or Color3.fromRGB(38, 38, 46)
    Btn.Text = string.format(" [%s] %s\n ID: %s", tipo, nombre, tostring(id))
    Btn.TextColor3 = Color3.fromRGB(230, 230, 230)
    Btn.TextSize = 10
    Btn.Font = Enum.Font.Gotham
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.Parent = ScrollList
    local BC = Instance.new("UICorner") BC.CornerRadius = UDim.new(0, 5) BC.Parent = Btn
    local Pad = Instance.new("UIPadding") Pad.LeftPadding = UDim.new(0, 8) Pad.Parent = Btn

    Btn.MouseButton1Click:Connect(function() aplicarApariencia(tipo, id) end)
end

-- Ejecutar la búsqueda de cuentas y Outfits usando RoProxy
SearchBtn.MouseButton1Click:Connect(function()
    local texto = InputBox.Text:gsub("%s+", "")
    if texto == "" then return end
    
    for _, child in ipairs(ScrollList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    SearchBtn.Text = "Sincronizando con Roblox..."
    local userId = tonumber(texto)
    
    if not userId then
        local s, resultadoId = pcall(function() return Players:GetUserIdFromNameAsync(texto) end)
        if s then userId = resultadoId else SearchBtn.Text = "❌ No existe esa cuenta" task.wait(1.5) SearchBtn.Text = "Buscar Trajes Guardados" return end
    end
    
    SearchBtn.Text = "Cargando Catálogo..."
    crearBotonAtuendo("Skin que trae puesta hoy", userId, "Actual")
    
    -- API COMPLETADA Y CORREGIDA AQUÍ:
    local url = string.format("https://roproxy.com", userId)
    local success, response = pcall(function() return game:HttpGet(url) end)
    
    if success and response then
        local data = HttpService:JSONDecode(response)
        if data and data.data and #data.data > 0 then
            for _, outfit in ipairs(data.data) do
                crearBotonAtuendo(outfit.name or "Outfit Guardado", outfit.id, "Outfit")
            end
            SearchBtn.Text = "¡Resultados Listos! 👇"
        else
            SearchBtn.Text = "⚠️ No tiene trajes guardados"
        end
    else
        SearchBtn.Text = "❌ Servidor saturado. Reintenta"
    end
    task.wait(1.5)
    SearchBtn.Text = "Buscar Trajes Guardados"
end)
