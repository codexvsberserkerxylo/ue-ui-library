-- nick
-- ask ai to reconstruct this with my other .txt files in this repo or something
-- instances.txt is good for rebuilding

-- nick
-- nick.buttons
-- nick
function Native.buttons(captures)
    local createButton = captures[3]
    local button = captures[1]
    local onButtonCreated = captures[0]
    local deps = captures[2]
    local uiLibrary = captures[4]

    return function()
        function button:AddButton(...)
            local value008 = typeof(select(1, ...)) == 'table' and select(1, ...) or {
                Text = select(1, ...),
                Func = select(2, ...),
            }

            assert(typeof(value008.Func) == 'function', 'AddButton: `Func` callback is missing.')

            self.Outer.Size = UDim2.new(0.5, -2, 0, 20)
            value008.Outer, value008.Inner, value008.Label = createButton(value008)
            value008.Outer.Position = UDim2.new(1, 3, 0, 0)
            value008.Outer.Size = UDim2.new(1, -3, 1, 0)
            value008.Outer.Parent = self.Outer

            function value008:AddTooltip(value010)
                if typeof(value010) == 'string' then
                    uiLibrary:AddToolTip(value010, self.Outer)
                end

                return value008
            end

            if typeof(value008.Tooltip) == 'string' then
                value008:AddTooltip(value008.Tooltip)
            end

            onButtonCreated(value008)

            return value008
        end

        local value011 = {}

        function button:Remove()
            for key, value in value011 do
                value:Destroy()
            end

            button.Outer:Destroy()
            table.clear(button)
            deps:Resize()
        end

        if typeof(button.Tooltip) == 'string' then
            button:AddTooltip(button.Tooltip)
        end

        table.insert(value011, deps:AddBlank(5))
        deps:Resize()
    end
end

-- nick
-- nick.colorPicker
-- nick
function Native.colorPicker(captures)
    local colorPicker = captures[0]
    local textBox = captures[6]
    local imageButton = captures[10]
    local frameInstanceCell_23 = captures[23]
    local textBox_7 = captures[7]
    local frame_20 = captures[20]
    local renderStepped = captures[1]
    local frame_21 = captures[21]
    local colorPickerObject = captures[8]
    local frame_22 = captures[22]
    local sharedObject_18 = captures[18]
    local frame_13 = captures[13]
    local userInputService = captures[17]
    local imageLabel_12 = captures[12]
    local frame = captures[11]
    local outlineColorNameCell = captures[2]
    local imageLabel = captures[9]
    local sharedObject = captures[4]
    local frame_15 = captures[15]
    local frame_16 = captures[16]
    local frameInstanceCell = captures[14]
    local flagName = captures[19]
    local mouse = captures[5]
    local frame_24 = captures[24]
    local uiLibrary = captures[3]

    return function()
        local outlineColorName = outlineColorNameCell[3][outlineColorNameCell[2]]
        local frameInstance = frameInstanceCell[3][frameInstanceCell[2]]
        local frameInstance_23 = frameInstanceCell_23[3][frameInstanceCell_23[2]]
        local value027 = uiLibrary:AddContextMenu(frame_15)

        value027:AddOption('Make gradient', function()
            local value028 = {}

            for key, value in sharedObject_18.Addons do

                if value.Type == 'ColorPicker' then
                    table.insert(value028, value)
                end
            end

            if #value028 < 3 then
                value027:Hide()

                return uiLibrary:Notify('not enough colors for a gradient.', 2)
            end

            local value6, value7 = value028[1].Value, value028[#value028].Value

            for index = 2, #value028 - 1 do

                local value034 = value028[index]

                value034:SetValueRGB(value6:Lerp(value7, index / #value028), value034.Transparency)
            end

            uiLibrary:Notify('created gradient!', 2)
            value027:Hide()
        end)
        value027:AddOption('Match color', function()
            local value035 = {}

            for key2, value2 in sharedObject_18.Addons do

                if value2.Type == 'ColorPicker' then
                    table.insert(value035, value2)
                end
            end
            for key3, value3 in value035 do
                value3:SetValueRGB(colorPicker.Value, value3.Transparency)
            end

            uiLibrary:Notify('matched all colors!', 2)
            value027:Hide()
        end)
        value027:AddOption('Copy color', function()
            uiLibrary.ColorClipboard = colorPicker

            uiLibrary:Notify('Copied color!', 2)
            value027:Hide()
        end)
        value027:AddOption('Paste color', function()
            if not uiLibrary.ColorClipboard then
                return uiLibrary:Notify('You have not copied a color!', 2)
            end

            colorPicker:SetValueRGB(uiLibrary.ColorClipboard.Value, uiLibrary.ColorClipboard.Transparency)
            value027:Hide()
        end)

        if uiLibrary.FlagCopying then
            value027:AddOption('Copy Flag', function()
                pcall(setclipboard, colorPicker.Idx)
                task.wait()
                uiLibrary:Notify('Copied flag to clipboard!', 2)
                value027:Hide()
            end)
        end

        uiLibrary:AddToRegistry(frame_13, {
            BackgroundColor3 = 'BackgroundColor',
            BorderColor3 = outlineColorName,
        })
        uiLibrary:AddToRegistry(frame_16, {
            BackgroundColor3 = 'AccentColor',
        })
        uiLibrary:AddToRegistry(frame_21, {
            BackgroundColor3 = 'BackgroundColor',
            BorderColor3 = outlineColorName,
        })
        uiLibrary:AddToRegistry(frame_20, {
            BackgroundColor3 = 'MainColor',
            BorderColor3 = outlineColorName,
        })
        uiLibrary:AddToRegistry(frame_24.Frame, {
            BackgroundColor3 = 'MainColor',
            BorderColor3 = outlineColorName,
        })
        uiLibrary:AddToRegistry(textBox, {
            TextColor3 = 'FontColor',
        })
        uiLibrary:AddToRegistry(textBox_7, {
            TextColor3 = 'FontColor',
        })

        local value040 = {}

        for index2 = 0, 1, 0.1 do
            table.insert(value040, ColorSequenceKeypoint.new(index2, Color3.fromHSV(index2, 1, 1)))
        end

        local uIGradient = uiLibrary:Create('UIGradient', {
            Color = ColorSequence.new(value040),
            Rotation = 90,
            Parent = frame,
        })

        textBox_7.FocusLost:Connect(function(value043)
            if value043 then
                local success, resultOrError = pcall(Color3.fromHex, textBox_7.Text)

                if success and typeof(resultOrError) == 'Color3' then
                    colorPicker.Hue, colorPicker.Sat, colorPicker.Vib = Color3.toHSV(resultOrError)
                end
            end

            colorPicker:Display()
        end)
        textBox.FocusLost:Connect(function(value046)
            if value046 then
                local value047, value048, value049 = textBox.Text:match('(%d+),%s*(%d+),%s*(%d+)')

                if value047 and value048 and value049 then
                    colorPicker.Hue, colorPicker.Sat, colorPicker.Vib = Color3.toHSV(Color3.fromRGB(value047, value048, value049))
                end
            end

            colorPicker:Display()
        end)

        function colorPicker:Display()
            colorPicker.Value = Color3.fromHSV(colorPicker.Hue, colorPicker.Sat, colorPicker.Vib)
            imageLabel_12.BackgroundColor3 = Color3.fromHSV(colorPicker.Hue, 1, 1)

            uiLibrary:Create(frame_15, {
                BackgroundColor3 = colorPicker.Value,
                BackgroundTransparency = colorPicker.Transparency,
                BorderColor3 = uiLibrary:GetDarkerColor(colorPicker.Value),
            })

            if frameInstance then
                frameInstance.BackgroundColor3 = colorPicker.Value
                frameInstance_23.Position = UDim2.new(1 - colorPicker.Transparency, 0, 0, 0)
            end

            imageLabel.Position = UDim2.new(colorPicker.Sat, 0, 1 - colorPicker.Vib, 0)
            frame_22.Position = UDim2.new(0, 0, colorPicker.Hue, 0)
            textBox_7.Text = '#' .. colorPicker.Value:ToHex()
            textBox.Text = table.concat({
                math.floor(colorPicker.Value.R * 255),
                math.floor(colorPicker.Value.G * 255),
                math.floor(colorPicker.Value.B * 255),
            }, ', ')

            uiLibrary:SafeCallback(colorPicker.Callback, colorPicker.Value)
            uiLibrary:SafeCallback(colorPicker.Changed, colorPicker.Value)
        end
        function colorPicker:OnChanged(callback)
            colorPicker.Changed = callback

            callback(colorPicker.Value)
        end

        local value053 = false

        function colorPicker:Show()
            value053 = true

            for key4, value4 in next, uiLibrary.OpenedFrames do

                if key4.Name == 'Color' then
                    key4.Visible = false
                    uiLibrary.OpenedFrames[key4] = nil
                end
            end

            imageButton.Visible = true
            uiLibrary.OpenedFrames[imageButton] = true
        end
        function colorPicker:Hide()
            value053 = false
            imageButton.Visible = false
            uiLibrary.OpenedFrames[imageButton] = nil
        end
        function colorPicker:SetValue(newValue, value060)
            local value061 = Color3.fromHSV(newValue[1], newValue[2], newValue[3])

            colorPicker.Transparency = value060 or 0

            colorPicker:SetHSVFromRGB(value061)
            colorPicker:Display()
        end
        function colorPicker:Remove()
            colorPickerObject[flagName] = nil

            table.clear(colorPicker)
        end
        function colorPicker:SetValueRGB(color, transparency)
            colorPicker.Transparency = transparency or 0

            colorPicker:SetHSVFromRGB(color)
            colorPicker:Display()
        end

        imageLabel_12.InputBegan:Connect(function(input)
            if uiLibrary.IsDragging then
                return
            end
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                local value067 = true
                local value068

                if input.UserInputType == Enum.UserInputType.Touch then
                    value068 = input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            value067 = false
                        end
                    end)
                end

                while value067 and (input.UserInputType == Enum.UserInputType.MouseButton1 and userInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or input.UserInputType == Enum.UserInputType.Touch) do

                    local value069 = input.UserInputType == Enum.UserInputType.MouseButton1 and mouse.X or input.Position.X
                    local value070 = input.UserInputType == Enum.UserInputType.MouseButton1 and mouse.Y or input.Position.Y
                    local value071, value072 = imageLabel_12.AbsolutePosition.X, imageLabel_12.AbsolutePosition.X + imageLabel_12.AbsoluteSize.X
                    local value073, value074 = imageLabel_12.AbsolutePosition.Y, imageLabel_12.AbsolutePosition.Y + imageLabel_12.AbsoluteSize.Y
                    local value075 = math.clamp(value069, value071, value072)
                    local value076 = math.clamp(value070, value073, value074)

                    colorPicker.Sat = (value075 - value071) / (value072 - value071)
                    colorPicker.Vib = 1 - (value076 - value073) / (value074 - value073)

                    colorPicker:Display()
                    renderStepped:Wait()
                end

                if value068 then
                    value068:Disconnect()
                end

                uiLibrary:AttemptSave()
            end
        end)
        frame.InputBegan:Connect(function(input2)
            if uiLibrary.IsDragging then
                return
            end
            if input2.UserInputType == Enum.UserInputType.MouseButton1 or input2.UserInputType == Enum.UserInputType.Touch then
                local value078 = true
                local value079

                if input2.UserInputType == Enum.UserInputType.Touch then
                    value079 = input2.Changed:Connect(function()
                        if input2.UserInputState == Enum.UserInputState.End then
                            value078 = false
                        end
                    end)
                end

                while value078 and (input2.UserInputType == Enum.UserInputType.MouseButton1 and userInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or input2.UserInputType == Enum.UserInputType.Touch) do

                    local value080 = input2.UserInputType == Enum.UserInputType.MouseButton1 and mouse.Y or input2.Position.Y
                    local value081, value082 = frame.AbsolutePosition.Y, frame.AbsolutePosition.Y + frame.AbsoluteSize.Y
                    local value083 = math.clamp(value080, value081, value082)

                    colorPicker.Hue = (value083 - value081) / (value082 - value081)

                    colorPicker:Display()
                    renderStepped:Wait()
                end

                if value079 then
                    value079:Disconnect()
                end

                uiLibrary:AttemptSave()
            end
        end)
        frame_15.InputBegan:Connect(function(input3)
            if uiLibrary.IsDragging then
                return
            end
            if input3.UserInputType == Enum.UserInputType.MouseButton1 or input3.UserInputType == Enum.UserInputType.Touch then
                if not uiLibrary:MouseIsOverOpenedFrame() then
                    if imageButton.Visible then
                        colorPicker:Hide()
                    else
                        colorPicker:Show()
                    end
                end
            elseif input3.UserInputType == Enum.UserInputType.MouseButton2 and not uiLibrary:MouseIsOverOpenedFrame() then
                colorPicker:Hide()
            end
        end)

        if frameInstance then
            frameInstance.InputBegan:Connect(function(input4)
                if uiLibrary.IsDragging then
                    return
                end
                if input4.UserInputType == Enum.UserInputType.MouseButton1 or input4.UserInputType == Enum.UserInputType.Touch then
                    local value086 = true
                    local value087

                    if input4.UserInputType == Enum.UserInputType.Touch then
                        value087 = input4.Changed:Connect(function()
                            if input4.UserInputState == Enum.UserInputState.End then
                                value086 = false
                            end
                        end)
                    end

                    while value086 and (input4.UserInputType == Enum.UserInputType.MouseButton1 and userInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or input4.UserInputType == Enum.UserInputType.Touch) do

                        local value088 = input4.UserInputType == Enum.UserInputType.MouseButton1 and mouse.X or input4.Position.X
                        local value089, value090 = frameInstance.AbsolutePosition.X, frameInstance.AbsolutePosition.X + frameInstance.AbsoluteSize.X
                        local value091 = math.clamp(value088, value089, value090)

                        colorPicker.Transparency = 1 - (value091 - value089) / (value090 - value089)

                        colorPicker:Display()
                        renderStepped:Wait()
                    end

                    if value087 then
                        value087:Disconnect()
                    end

                    uiLibrary:AttemptSave()
                end
            end)
        end

        local value092 = function()
            if not value053 then
                return
            end

            local absolutePosition, absoluteSize = imageButton.AbsolutePosition, imageButton.AbsoluteSize

            if mouse.X < absolutePosition.X or mouse.X > absolutePosition.X + absoluteSize.X or mouse.Y < absolutePosition.Y - 20 - 1 or mouse.Y > absolutePosition.Y + absoluteSize.Y then
                colorPicker:Hide()
            end
        end

        for key5, value5 in {
            Enum.UserInputType.MouseButton1,
            Enum.UserInputType.MouseButton2,
        }do
            uiLibrary:BindToInput(value5, value092)
        end

        colorPicker:Display()

        colorPicker.DisplayFrame = frame_15
        colorPickerObject[flagName] = colorPicker
        sharedObject.Addons = sharedObject.Addons or {}

        table.insert(sharedObject.Addons, colorPicker)

        if sharedObject.ToggleRegion then
            sharedObject.ColorPickerCount = sharedObject.ColorPickerCount + 1

            if sharedObject.ColorPickerCount > 2 then
                sharedObject.ToggleRegion.Size = sharedObject.ToggleRegion.Size - UDim2.new(0, 32, 0, 0)
            end
        end
    end
end

-- nick
-- nick.configuration
-- nick
function Native.configuration(captures)
    local toggles = captures[2]
    local options = captures[1]
    local outlineColorNameCell = captures[3]
    local configManager = captures[0]

    return function()
        local outlineColorName = outlineColorNameCell[3][outlineColorNameCell[2]]
        local cloneReference = cloneref or function(value007)
            return value007
        end
        local httpService = cloneReference(game:GetService('HttpService'))
        local isfolderFn, isfileFn, listfilesFn = isfolder, isfile, listfiles

        do
            configManager.Folder = ''
            configManager.Ignore = {}
            configManager.Parser = {
                Toggle = {
                    Save = function(optionId, option)
                        return {
                            type = 'Toggle',
                            idx = optionId,
                            value = option.Value,
                        }
                    end,
                    Load = function(optionId2, savedValue)
                        if toggles[optionId2] then
                            toggles[optionId2]:SetValue(savedValue.value)
                        end
                    end,
                },
                Slider = {
                    Save = function(optionId3, option2)
                        return {
                            type = 'Slider',
                            idx = optionId3,
                            value = tostring(option2.Value),
                        }
                    end,
                    Load = function(optionId4, savedValue2)
                        if options[optionId4] then
                            options[optionId4]:SetValue(savedValue2.value)
                        end
                    end,
                },
                Dropdown = {
                    Save = function(optionId5, option3)
                        return {
                            type = 'Dropdown',
                            idx = optionId5,
                            value = option3.Value,
                            mutli = option3.Multi,
                        }
                    end,
                    Load = function(optionId6, savedValue3)
                        if options[optionId6] then
                            options[optionId6]:SetValue(savedValue3.value)
                        end
                    end,
                },
                ColorPicker = {
                    Save = function(optionId7, option4)
                        return {
                            type = 'ColorPicker',
                            idx = optionId7,
                            value = option4.Value:ToHex(),
                            transparency = option4.Transparency,
                        }
                    end,
                    Load = function(optionId8, savedValue4)
                        if options[optionId8] then
                            options[optionId8]:SetValueRGB(Color3.fromHex(savedValue4.value), savedValue4.transparency)
                        end
                    end,
                },
                KeyPicker = {
                    Save = function(optionId9, option5)
                        return {
                            type = 'KeyPicker',
                            idx = optionId9,
                            mode = option5.Mode,
                            key = option5.Value,
                        }
                    end,
                    Load = function(optionId10, savedValue5)
                        if options[optionId10] then
                            options[optionId10]:SetValue({
                                savedValue5.key,
                                savedValue5.mode,
                            })
                        end
                    end,
                },
                Input = {
                    Save = function(optionId11, option6)
                        return {
                            type = 'Input',
                            idx = optionId11,
                            text = option6.Value,
                        }
                    end,
                    Load = function(optionId12, savedValue6)
                        if options[optionId12] and type(savedValue6.text) == 'string' then
                            options[optionId12]:SetValue(savedValue6.text)
                        end
                    end,
                },
            }

            function configManager:BuildFolderTree()
                local folders = {
                    self.Folder,
                    self.Folder .. '/settings',
                    self.Folder .. '/themes',
                }

                for index = 1, #folders do

                    local folderPath = folders[index]

                    if not isfolderFn(folderPath) then
                        makefolder(folderPath)
                    end
                end
            end
            function configManager:CheckFolderTree()
                if not isfolderFn(self.Folder) then
                    configManager:BuildFolderTree()
                    task.wait()
                end
            end
            function configManager:SetIgnoreIndexes(indexes)
                for key, value in next, indexes do

                    self.Ignore[value] = true
                end
            end
            function configManager:SetFolder(folder)
                self.Folder = folder

                self:BuildFolderTree()
            end
            function configManager:Save(configName, value049)
                if not configName then
                    return false, 'no config file is selected'
                end

                configManager:CheckFolderTree()

                local configPath = self.Folder .. '/settings/' .. configName .. '.json'
                local savedConfig = {objects = {}}

                for key2, value2 in next, toggles do

                    if self.Ignore[key2] then
                        continue
                    end

                    table.insert(savedConfig.objects, self.Parser[value2.Type].Save(key2, value2))
                end
                for key3, value3 in next, options do

                    if not self.Parser[value3.Type] then
                        continue
                    end
                    if self.Ignore[key3] then
                        continue
                    end

                    table.insert(savedConfig.objects, self.Parser[value3.Type].Save(key3, value3))
                end

                local success, resultOrError = pcall(httpService.JSONEncode, httpService, savedConfig)

                if not success then
                    return false, 'failed to encode data'
                end
                if not value049 then
                    writefile(configPath, resultOrError)
                end

                return true, resultOrError
            end
            function configManager:Load(configOrName)
                if not configOrName then
                    return false, 'no config file is selected'
                end
                if type(configOrName) == 'table' then
                    for key4, value4 in next, configOrName.objects do

                        if self.Parser[value4.type] then
                            task.spawn(function()
                                self.Parser[value4.type].Load(value4.idx, value4)
                            end)
                        end
                    end

                    return true
                end

                configManager:CheckFolderTree()

                local configPath2 = self.Folder .. '/settings/' .. configOrName .. '.json'

                if not isfileFn(configPath2) then
                    return false, 'invalid file'
                end

                local success2, resultOrError2 = pcall(httpService.JSONDecode, httpService, readfile(configPath2))

                if not success2 then
                    return false, 'decode error'
                end

                for key5, value5 in next, resultOrError2.objects do

                    if self.Parser[value5.type] then
                        task.spawn(function()
                            self.Parser[value5.type].Load(value5.idx, value5)
                        end)
                    end
                end

                return true
            end
            function configManager:Delete(configName2)
                if not configName2 then
                    return false, 'no config file is selected'
                end

                local configPath3 = self.Folder .. '/settings/' .. configName2 .. '.json'

                if not isfileFn(configPath3) then
                    return false, 'invalid file'
                end

                local success3, resultOrError3 = pcall(delfile, configPath3)

                if not success3 then
                    return false, 'delete file error'
                end

                return true
            end
            function configManager:IgnoreThemeSettings()
                self:SetIgnoreIndexes({
                    'ThemeManager_ThemeList',
                    'ThemeManager_CustomThemeList',
                    'ThemeManager_CustomThemeName',
                    'VideoLink',
                    'Brightness',
                    'Contrast',
                    'Saturation',
                    'Brightness',
                    'BlurSize',
                    'FontColor',
                    'RiskColor',
                    'MainColor',
                    'AccentColor',
                    'BackgroundColor',
                    outlineColorName,
                    'SwordColor',
                    'ItemType',
                    'BackTransparency',
                    'BackColor',
                    'SwordTransparency',
                    'SwordReflectance',
                    'SwordMaterial',
                    'SwordSpeed',
                })
            end
            function configManager:RefreshConfigList()
                local value074 = listfilesFn(self.Folder .. '/settings')
                local value075 = {}

                for index2 = 1, #value074 do

                    local value077 = value074[index2]

                    if value077:sub(-5) == '.json' then
                        local matchStart = value077:find('.json', 1, true)
                        local value079 = matchStart
                        local value080 = value077:sub(matchStart, matchStart)

                        while value080 ~= '/' and value080 ~= '\\' and value080 ~= '' do

                            matchStart = matchStart - 1
                            value080 = value077:sub(matchStart, matchStart)
                        end

                        if value080 == '/' or value080 == '\\' then
                            table.insert(value075, value077:sub(matchStart + 1, value079 - 1))
                        end
                    end
                end

                return value075
            end
            function configManager:SetLibrary(library)
                self.Library = library
            end
            function configManager:LoadAutoloadConfig()
                configManager:CheckFolderTree()

                if isfileFn(self.Folder .. '/settings/autoload.txt') then
                    local value084 = readfile(self.Folder .. '/settings/autoload.txt')
                    local value085, value086 = self:Load(value084)

                    if not value085 then
                        return self.Library:Notify('Failed to load autoload config: ' .. value086)
                    end
                    if not SILENT then
                        self.Library:Notify(string.format('Auto loaded config %q', value084))
                    end
                end
            end
        end

        getgenv().SaveManager = configManager
    end
end

-- nick
-- nick.containerSize
-- nick
function Native.containerSize(captures)
    local inner = captures[1]
    local outer = captures[0]
    local container = captures[3]
    local object = captures[2]
    local object2 = captures[4]

    return function()
        function container:SetSize(value008)
            inner.Size = UDim2.new(1, -4, 0, value008)

            object2:Resize()
        end
        function container:GetOuter()
            return inner
        end
        function container:GetInner()
            return outer
        end
        function container:GetSize()
            return outer.AbsoluteSize
        end

        local value012 = {}

        table.insert(value012, object:AddBlank(5))
        object:Resize()
    end
end

-- nick
-- nick.dependencies
-- nick
function Native.dependencies(captures)
    local uiLibrary = captures[0]
    local frame_5 = captures[5]
    local depsObject = captures[4]
    local groupBoxApi = captures[2]
    local uiListLayout = captures[6]
    local frame = captures[3]
    local sharedObject = captures[1]

    return function()
        function sharedObject:Resize()
            frame.Size = UDim2.new(1, 0, 0, uiListLayout.AbsoluteContentSize.Y)

            depsObject:Resize()
        end

        uiListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
            sharedObject:Resize()
        end)
        frame:GetPropertyChangedSignal('Visible'):Connect(function()
            sharedObject:Resize()
        end)

        function sharedObject:Update()
            local value011 = false

            for key, value in next, sharedObject.Dependencies do

                if value[1].Value == value[2] then
                    value011 = true

                    break
                end
            end

            frame.Visible = value011

            sharedObject:Resize()
        end
        function sharedObject:SetupDependencies(value015)
            for key2, value2 in next, value015 do
                assert(type(value2) == 'table', 'SetupDependencies: Dependency is not of type `table`.')
                assert(value2[1], 'SetupDependencies: Dependency is missing element argument.')
                assert(value2[2] ~= nil, 'SetupDependencies: Dependency is missing value argument.')
            end

            sharedObject.Dependencies = value015

            sharedObject:Update()
        end
        function sharedObject:Remove()
            table.remove(uiLibrary.DependencyBoxes, table.find(uiLibrary.DependencyBoxes, sharedObject))
            table.clear(sharedObject)
            frame:Destroy()
            depsObject:Resize()
        end

        sharedObject.Container = frame_5

        setmetatable(sharedObject, groupBoxApi)
        table.insert(uiLibrary.DependencyBoxes, sharedObject)
    end
end

-- nick
-- nick.drawing
-- nick
function Native.drawing(captures)
    local integrityProductRef = captures[2]
    local smallIntegrityRef = captures[4]
    local integrityOffsetRef = captures[0]
    local outlineColorNameRef = captures[8]
    local largeIntegrityRef = captures[6]
    local frameClassRef = captures[1]
    local integrityModuloRef = captures[5]
    local cloneFunctionRef = captures[3]
    local enabledRef = captures[7]

    return function()
        if integrityOffsetRef[3][integrityOffsetRef[2] ](1386) ~= 4293 then
            while true do
            end
        else
            local textService = cloneref(game:GetService('TextService'))
            local value012 = {
                Fonts = {
                    UI = 0,
                    System = 1,
                    Plex = 2,
                    Monospace = 3,
                },
            }
            local value013 = getrenv()
            local value014 = value013.math.pi
            local value015 = value013.math.huge
            local value016 = cloneFunctionRef[3][cloneFunctionRef[2] ](value013.assert)
            local value017 = cloneFunctionRef[3][cloneFunctionRef[2] ](value013.Color3.new)
            local value018 = cloneFunctionRef[3][cloneFunctionRef[2] ](value013.Instance.new)
            local value019 = cloneFunctionRef[3][cloneFunctionRef[2] ](value013.math.atan2)
            local value020 = cloneFunctionRef[3][cloneFunctionRef[2] ](value013.math.clamp)
            local value021 = cloneFunctionRef[3][cloneFunctionRef[2] ](value013.math.max)
            local value022 = cloneFunctionRef[3][cloneFunctionRef[2] ](value013.setmetatable)
            local value023 = cloneFunctionRef[3][cloneFunctionRef[2] ](value013.string.format)
            local value024 = cloneFunctionRef[3][cloneFunctionRef[2] ](value013.task.spawn)
            local value025 = cloneFunctionRef[3][cloneFunctionRef[2] ](value013.UDim.new)
            local value026 = cloneFunctionRef[3][cloneFunctionRef[2] ](value013.UDim2.fromOffset)
            local value027 = cloneFunctionRef[3][cloneFunctionRef[2] ](value013.UDim2.new)
            local value028 = cloneFunctionRef[3][cloneFunctionRef[2] ](value013.Vector2.new)
            local value029 = cloneFunctionRef[3][cloneFunctionRef[2] ](game.Destroy)
            local value030 = cloneFunctionRef[3][cloneFunctionRef[2] ](textService.GetTextBoundsAsync)
            local value031 = cloneFunctionRef[3][cloneFunctionRef[2] ](game.HttpGet)
            local value032 = writecustomasset and cloneFunctionRef[3][cloneFunctionRef[2] ](writecustomasset)
            local value033 = protectinstance and cloneFunctionRef[3][cloneFunctionRef[2] ](protectinstance)

            local function value034(value035, value036, value037)
                local value038 = value018(value035)

                for key, value in value036 do

                    if key ~= 'Parent' then
                        value038[key] = value
                    end
                end

                if value037 then
                    for key2, value2 in value037 do

                        value2.Parent = value038
                    end
                end
                if value033 then
                    if 15746 ~= integrityOffsetRef[3][integrityOffsetRef[2] ](3592) then
                        while true do
                        end
                    else
                        value033(value038)
                    end
                end

                value038.Parent = value036.Parent

                return value038
            end

            do
                local value043 = {
                    Font.new('rbxasset://fonts/families/Arial.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                    Font.new('rbxasset://fonts/families/HighwayGothic.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                    Font.new('rbxasset://fonts/families/Roboto.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                    Font.new('rbxasset://fonts/families/Ubuntu.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                }

                for key3, value3 in value043 do
                    game:GetService('TextService'):GetTextBoundsAsync(value034('GetTextBoundsParams', {
                        Text = '\\\\',
                        Size = 12,
                        Font = value3,
                        Width = value015,
                    }))
                end
            end
            do
                local value046 = value034('ScreenGui', {
                    DisplayOrder = 15,
                    IgnoreGuiInset = true,
                    Name = 'drawingDirectory',
                    Parent = cloneref(game:GetService('CoreGui')),
                    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                })

                local function value047(value048, value049, value050, value051)
                    local value052 = (value049 + value050) / 2
                    local value053 = value050 - value049

                    value048.Position = value026(value052.X, value052.Y)
                    value048.Rotation = value019(value053.Y, value053.X) * 180 / value014
                    value048.Size = value026(value053.Magnitude, value051)
                end

                if largeIntegrityRef[3][largeIntegrityRef[2] ] + 8181 ~= 17576 then
                    while true do
                    end
                end

                local value054 = 0
                local value055 = {}
                local value056 = {}

                do
                    if smallIntegrityRef[3][smallIntegrityRef[2] ] - 610 ~= 354 then
                        if integrityOffsetRef[3][integrityOffsetRef[2] ](5140) <= 21280 and 21280 >= integrityOffsetRef[3][integrityOffsetRef[2] ](5140) then
                            while true do
                            end
                        else
                            while true do
                            end
                        end
                    end

                    local drawingClass = {}

                    function drawingClass.new()
                        value054 = value054 + 1

                        if largeIntegrityRef[3][largeIntegrityRef[2] ] + 3788 ~= 13183 then
                            while true do
                            end
                        end

                        local value058 = value054
                        local value059 = value022({
                            _id = value058,
                            __OBJECT_EXISTS = true,
                            _properties = {
                                Color = value017(),
                                From = value028(),
                                Thickness = 1,
                                To = value028(),
                                Transparency = 1,
                                Visible = false,
                                ZIndex = 0,
                            },
                            _frame = value034(frameClassRef[3][frameClassRef[2] ], {
                                Name = value058,
                                AnchorPoint = value028(0.5, 0.5),
                                BackgroundColor3 = value017(),
                                BorderSizePixel = 0,
                                Parent = value046,
                                Position = value027(),
                                Size = value027(),
                                Visible = false,
                                ZIndex = 0,
                            }),
                        }, drawingClass)

                        value055[value058] = value059

                        return value059
                    end
                    function drawingClass:__index(value061)
                        local value062 = self._properties[value061]

                        if value062 ~= nil then
                            return value062
                        end

                        return drawingClass[value061]
                    end
                    function drawingClass:__newindex(value064, value065)
                        if enabledRef[3][enabledRef[2] ] and self.__OBJECT_EXISTS == true then
                            if 26282 >= integrityOffsetRef[3][integrityOffsetRef[2] ](8694) and 26282 <= integrityOffsetRef[3][integrityOffsetRef[2] ](8694) then
                                local value066 = self._properties

                                if enabledRef[3][enabledRef[2] ] and (value066[value064] == nil or value066[value064] == value065 or typeof(value066[value064]) ~= typeof(value065)) then
                                    return
                                end

                                value066[value064] = value065

                                if value064 == 'Color' then
                                    self._frame.BackgroundColor3 = value065
                                elseif value064 == 'From' then
                                    self:_updatePosition()
                                elseif value064 == 'Thickness' then
                                    self._frame.Size = value026(self._frame.AbsoluteSize.X, value021(value065, 1))
                                elseif value064 == 'To' then
                                    self:_updatePosition()
                                elseif value064 == 'Transparency' then
                                    if integrityOffsetRef[3][integrityOffsetRef[2] ](3864) ~= 13262 then
                                        while true do
                                        end
                                    else
                                        self._frame.BackgroundTransparency = value020(1 - value065, 0, 1)
                                    end
                                elseif value064 == 'Visible' then
                                    self._frame.Visible = value065
                                elseif value064 == 'ZIndex' then
                                    self._frame.ZIndex = value065
                                end
                            else
                                while true do
                                end
                            end
                        end
                    end
                    function drawingClass:__iter()
                        return next, self._properties
                    end
                    function drawingClass:__tostring()
                        return 'Drawing'
                    end
                    function drawingClass:Destroy()
                        value055[self._id] = nil
                        self.__OBJECT_EXISTS = false

                        value029(self._frame)
                    end
                    function drawingClass:_updatePosition()
                        local value071 = self._properties

                        value047(self._frame, value071.From, value071.To, value071.Thickness)
                    end

                    drawingClass.Remove = drawingClass.Destroy
                    value056.Line = drawingClass
                end
                do
                    local drawingClass2 = {}

                    function drawingClass2.new()
                        if integrityOffsetRef[3][integrityOffsetRef[2] ](1085) >= 7565 and 7565 <= integrityOffsetRef[3][integrityOffsetRef[2] ](1085) then
                            value054 = value054 + 1

                            local value073 = value054
                            local value074 = value022({
                                _id = value073,
                                __OBJECT_EXISTS = true,
                                _properties = {
                                    Color = value017(),
                                    Filled = false,
                                    NumSides = 0,
                                    Position = value028(),
                                    Radius = 0,
                                    Thickness = 1,
                                    Transparency = 1,
                                    Visible = false,
                                    ZIndex = 0,
                                },
                                _frame = value034(frameClassRef[3][frameClassRef[2] ], {
                                    Name = value073,
                                    AnchorPoint = value028(0.5, 0.5),
                                    BackgroundColor3 = value017(),
                                    BackgroundTransparency = 1,
                                    BorderSizePixel = 0,
                                    Parent = value046,
                                    Position = value027(),
                                    Size = value027(),
                                    Visible = false,
                                    ZIndex = 0,
                                }, {
                                    value034('UICorner', {
                                        Name = '_corner',
                                        CornerRadius = value025(1, 0),
                                    }),
                                    value034('UIStroke', {
                                        Name = '_stroke',
                                        Color = value017(),
                                        Thickness = 1,
                                    }),
                                }),
                            }, drawingClass2)

                            value055[value073] = value074

                            return value074
                        else
                            while true do
                            end
                        end
                    end
                    function drawingClass2:__index(value076)
                        local value077 = self._properties[value076]

                        if value077 ~= nil then
                            return value077
                        end

                        return drawingClass2[value076]
                    end
                    function drawingClass2:__newindex(value079, value080)
                        if self.__OBJECT_EXISTS == true then
                            if integrityOffsetRef[3][integrityOffsetRef[2] ](1603) == 7229 then
                                local value081 = self._properties

                                if value081[value079] == nil or value081[value079] == value080 or typeof(value081[value079]) ~= typeof(value080) then
                                    return
                                end

                                value081[value079] = value080

                                if value079 == 'Color' then
                                    if 9871 == integrityModuloRef[3][integrityModuloRef[2] ](8073) then
                                        self._frame.BackgroundColor3 = value080
                                        self._frame._stroke.Color = value080
                                    else
                                        while true do
                                        end
                                    end
                                elseif value079 == 'Filled' then
                                    if 738 <= integrityProductRef[3][integrityProductRef[2] ](6578) and integrityProductRef[3][integrityProductRef[2] ](6578) >= 738 then
                                        self._frame.BackgroundTransparency = value080 and 1 - value081.Transparency or 1
                                    else
                                        while true do
                                        end
                                    end
                                elseif value079 == 'Position' then
                                    self._frame.Position = value026(value080.X, value080.Y)
                                elseif value079 == 'Radius' then
                                    self:_updateRadius()
                                elseif value079 == 'Thickness' then
                                    self._frame._stroke.Thickness = value021(value080, 1)

                                    self:_updateRadius()
                                elseif value079 == 'Transparency' then
                                    self._frame._stroke.Transparency = 1 - value080

                                    if value081.Filled then
                                        self._frame.BackgroundTransparency = 1 - value080
                                    end
                                elseif value079 == 'Visible' then
                                    self._frame.Visible = value080
                                elseif value079 == 'ZIndex' then
                                    self._frame.ZIndex = value080
                                end
                            else
                                while true do
                                end
                            end
                        end
                    end
                    function drawingClass2:__iter()
                        return next, self._properties
                    end
                    function drawingClass2:__tostring()
                        return 'Drawing'
                    end
                    function drawingClass2:Destroy()
                        value055[self._id] = nil
                        self.__OBJECT_EXISTS = false

                        value029(self._frame)
                    end
                    function drawingClass2:_updateRadius()
                        if 30197 >= integrityOffsetRef[3][integrityOffsetRef[2] ](8884) and 30197 <= integrityOffsetRef[3][integrityOffsetRef[2] ](8884) then
                            local value086 = self._properties
                            local value087 = value086.Radius * 2 - value086.Thickness * 2

                            self._frame.Size = value026(value087, value087)
                        else
                            while true do
                            end
                        end
                    end

                    drawingClass2.Remove = drawingClass2.Destroy
                    value056.Circle = drawingClass2
                end
                do
                    if integrityProductRef[3][integrityProductRef[2] ](7049) >= 108 and integrityProductRef[3][integrityProductRef[2] ](7049) <= 108 then
                        local value088 = {
                            [value012.Fonts.UI] = Font.new('rbxasset://fonts/families/Arial.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                            [value012.Fonts.System] = Font.new('rbxasset://fonts/families/HighwayGothic.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                            [value012.Fonts.Plex] = Font.new('rbxasset://fonts/families/Roboto.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                            [value012.Fonts.Monospace] = Font.new('rbxasset://fonts/families/Ubuntu.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                        }
                        local drawingClass3 = {}

                        function drawingClass3.new()
                            value054 = value054 + 1

                            local value090 = value054
                            local value091 = value022({
                                _id = value090,
                                __OBJECT_EXISTS = true,
                                _properties = {
                                    Center = false,
                                    RichText = false,
                                    Color = value017(),
                                    FontFace = value088[0],
                                    Outline = false,
                                    OutlineColor = value017(),
                                    Position = value028(),
                                    Size = 12,
                                    TextSize = 12,
                                    Text = '',
                                    TextBounds = value028(),
                                    Transparency = 1,
                                    Visible = false,
                                    ZIndex = 0,
                                },
                                _frame = value034('TextLabel', {
                                    Name = value090,
                                    BackgroundTransparency = 1,
                                    FontFace = value088[0],
                                    Parent = value046,
                                    Position = value027(),
                                    Size = value027(),
                                    Text = '',
                                    TextColor3 = value017(),
                                    TextSize = 12,
                                    TextXAlignment = Enum.TextXAlignment.Left,
                                    TextYAlignment = Enum.TextYAlignment.Top,
                                    Visible = false,
                                    ZIndex = 0,
                                }, {
                                    value034('UIStroke', {
                                        Name = '_stroke',
                                        Color = value017(),
                                        Enabled = false,
                                        Thickness = 1,
                                        LineJoinMode = Enum.LineJoinMode.Miter,
                                    }),
                                }),
                            }, drawingClass3)

                            value055[value090] = value091

                            return value091
                        end
                        function drawingClass3:__index(value093)
                            local value094 = self._properties[value093]

                            if value094 ~= nil then
                                if integrityProductRef[3][integrityProductRef[2] ](7282) ~= 810 then
                                    while true do
                                    end
                                else
                                    return value094
                                end
                            end

                            return drawingClass3[value093]
                        end
                        function drawingClass3:__newindex(value096, value097)
                            if self.__OBJECT_EXISTS == true then
                                if integrityProductRef[3][integrityProductRef[2] ](6820) >= 332 and integrityProductRef[3][integrityProductRef[2] ](6820) <= 332 then
                                    local value098 = self._properties

                                    if value096 == 'TextBounds' or value098[value096] == nil or value098[value096] == value097 or typeof(value098[value096]) ~= typeof(value097) then
                                        return
                                    end

                                    value098[value096] = value097

                                    if value096 == 'Position' then
                                        self._frame.Position = value026(value097.X, value097.Y)
                                    elseif value096 == 'Text' then
                                        self._frame.Text = value097

                                        self:_updateTextBounds()
                                    elseif value096 == 'Transparency' then
                                        self._frame.TextTransparency = 1 - value097
                                        self._frame._stroke.Transparency = 1 - value097
                                    elseif value096 == 'Size' or value096 == 'TextSize' then
                                        if 7594 <= integrityModuloRef[3][integrityModuloRef[2] ](5222) and 7594 >= integrityModuloRef[3][integrityModuloRef[2] ](5222) then
                                            self._frame.TextSize = value097

                                            self:_updateTextBounds()
                                        else
                                            while true do
                                            end
                                        end
                                    elseif value096 == 'Visible' then
                                        self._frame.Visible = value097
                                    elseif value096 == 'Center' then
                                        self._frame.TextXAlignment = value097 and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left
                                    elseif value096 == 'Color' then
                                        self._frame.TextColor3 = value097
                                    elseif value096 == 'Font' then
                                        local value099 = value088[value097]

                                        self._frame.FontFace, value098.FontFace = value099, value099

                                        self:_updateTextBounds()
                                    elseif value096 == 'Outline' then
                                        self._frame._stroke.Enabled = value097
                                    elseif value096 == outlineColorNameRef[3][outlineColorNameRef[2] ] then
                                        self._frame._stroke.Color = value097
                                    elseif value096 == 'ZIndex' then
                                        self._frame.ZIndex = value097
                                    elseif value096 == 'FontFace' then
                                        if integrityModuloRef[3][integrityModuloRef[2] ](6592) == 5584 then
                                            self._frame.FontFace = value097

                                            self:_updateTextBounds()
                                        else
                                            while true do
                                            end
                                        end
                                    elseif value096 == 'RichText' then
                                        self._frame.RichText = value097
                                    end
                                else
                                    while true do
                                    end
                                end
                            end
                        end
                        function drawingClass3:__iter()
                            return next, self._properties
                        end
                        function drawingClass3:__tostring()
                            return 'Drawing'
                        end
                        function drawingClass3:Destroy()
                            value055[self._id] = nil
                            self.__OBJECT_EXISTS = false

                            value029(self._frame)
                        end
                        function drawingClass3:_updateTextBounds()
                            local value104 = self._properties

                            value104.TextBounds = value030(textService, value034('GetTextBoundsParams', {
                                Text = value104.Text,
                                Size = value104.Size,
                                Font = value104.FontFace,
                                Width = value015,
                            }))
                        end

                        drawingClass3.Remove = drawingClass3.Destroy
                        value056.Text = drawingClass3
                    else
                        while true do
                        end
                    end
                end
                do
                    local drawingClass4 = {}

                    function drawingClass4.new()
                        value054 = value054 + 1

                        local value106 = value054
                        local value107 = value022({
                            _id = value106,
                            __OBJECT_EXISTS = true,
                            _properties = {
                                Color = value017(),
                                Filled = false,
                                Position = value028(),
                                Size = value028(),
                                Thickness = 1,
                                Transparency = 1,
                                Visible = false,
                                ZIndex = 0,
                            },
                            _frame = value034(frameClassRef[3][frameClassRef[2] ], {
                                BackgroundColor3 = value017(),
                                BackgroundTransparency = 1,
                                BorderSizePixel = 0,
                                Parent = value046,
                                Position = value027(),
                                Size = value027(),
                                Visible = false,
                                ZIndex = 0,
                            }, {
                                value034('UIStroke', {
                                    Name = '_stroke',
                                    Color = value017(),
                                    Thickness = 1,
                                    LineJoinMode = Enum.LineJoinMode.Miter,
                                }),
                            }),
                        }, drawingClass4)

                        value055[value106] = value107

                        return value107
                    end
                    function drawingClass4:__index(value109)
                        local value110 = self._properties[value109]

                        if value110 ~= nil then
                            return value110
                        end

                        return drawingClass4[value109]
                    end
                    function drawingClass4:__newindex(value112, value113)
                        if self.__OBJECT_EXISTS == true then
                            local value114 = self._properties

                            if value114[value112] == nil or value114[value112] == value113 or typeof(value114[value112]) ~= typeof(value113) then
                                return
                            end

                            value114[value112] = value113

                            if value112 == 'Position' then
                                self:_updateScale()
                            elseif value112 == 'Size' then
                                self:_updateScale()
                            elseif value112 == 'Color' then
                                self._frame.BackgroundColor3 = value113
                                self._frame._stroke.Color = value113
                            elseif value112 == 'Filled' then
                                if -1118 == integrityProductRef[3][integrityProductRef[2] ](5065) then
                                    while true do
                                    end
                                else
                                    self._frame.BackgroundTransparency = value113 and 1 - value114.Transparency or 1
                                end
                            elseif value112 == 'Thickness' then
                                self._frame._stroke.Thickness = value113

                                self:_updateScale()
                            elseif value112 == 'Transparency' then
                                self._frame._stroke.Transparency = 1 - value113

                                if value114.Filled then
                                    if integrityOffsetRef[3][integrityOffsetRef[2] ](7134) ~= 26717 then
                                        while true do
                                        end
                                    else
                                        self._frame.BackgroundTransparency = 1 - value113
                                    end
                                end
                            elseif value112 == 'Visible' then
                                self._frame.Visible = value113
                            elseif value112 == 'ZIndex' then
                                self._frame.ZIndex = value113
                            end
                        end
                    end
                    function drawingClass4:__iter()
                        return next, self._properties
                    end
                    function drawingClass4:__tostring()
                        return 'Drawing'
                    end
                    function drawingClass4:Destroy()
                        value055[self._id] = nil
                        self.__OBJECT_EXISTS = false

                        value029(self._frame)
                    end
                    function drawingClass4:_updateScale()
                        local value119 = self._properties

                        self._frame.Position = value026(value119.Position.X + value119.Thickness, value119.Position.Y + value119.Thickness)

                        local thickness = value119.Thickness

                        self._frame.Size = value026(value119.Size.X - thickness * 2, value119.Size.Y - thickness * 2)
                    end

                    drawingClass4.Remove = drawingClass4.Destroy
                    value056.Square = drawingClass4
                end
                do
                    local drawingClass5 = {}

                    function drawingClass5.new()
                        value054 = value054 + 1

                        local value122 = value054
                        local value123 = value022({
                            _id = value122,
                            _imageId = 0,
                            __OBJECT_EXISTS = true,
                            _properties = {
                                Color = value017(1, 1, 1),
                                Data = '',
                                Position = value028(),
                                Rounding = 0,
                                Size = value028(),
                                Transparency = 1,
                                Uri = '',
                                Visible = false,
                                ZIndex = 0,
                            },
                            _frame = value034('ImageLabel', {
                                BackgroundTransparency = 1,
                                BorderSizePixel = 0,
                                Image = '',
                                ImageColor3 = value017(1, 1, 1),
                                Parent = value046,
                                Position = value027(),
                                Size = value027(),
                                Visible = false,
                                ZIndex = 0,
                            }, {
                                value034('UICorner', {
                                    Name = '_corner',
                                    CornerRadius = value025(),
                                }),
                            }),
                        }, drawingClass5)

                        value055[value122] = value123

                        return value123
                    end
                    function drawingClass5:__index(value125)
                        if 108 == integrityProductRef[3][integrityProductRef[2] ](6249) then
                            value016(value125 ~= 'Data', value023("Attempt to read writeonly property '%s'", value125))

                            if value125 == 'Loaded' then
                                return self._frame.IsLoaded
                            end

                            local value126 = self._properties[value125]

                            if value126 ~= nil then
                                return value126
                            end

                            return drawingClass5[value125]
                        else
                            while true do
                            end
                        end
                    end
                    function drawingClass5:__newindex(value128, value129)
                        if integrityProductRef[3][integrityProductRef[2] ](2673) == 3516 then
                            while true do
                            end
                        elseif self.__OBJECT_EXISTS == true then
                            local value130 = self._properties

                            if value130[value128] == nil or value130[value128] == value129 or typeof(value130[value128]) ~= typeof(value129) then
                                return
                            end

                            value130[value128] = value129

                            if value128 == 'Color' then
                                self._frame.ImageColor3 = value129
                            elseif value128 == 'Data' then
                                self:_newImage(value129)
                            elseif value128 == 'Position' then
                                self._frame.Position = value026(value129.X, value129.Y)
                            elseif value128 == 'Rounding' then
                                self._frame._corner.CornerRadius = value025(0, value129)
                            elseif value128 == 'Size' then
                                if 27215 ~= integrityOffsetRef[3][integrityOffsetRef[2] ](8145) then
                                    while true do
                                    end
                                else
                                    self._frame.Size = value026(value129.X, value129.Y)
                                end
                            elseif value128 == 'Transparency' then
                                self._frame.ImageTransparency = 1 - value129
                            elseif value128 == 'Uri' then
                                self:_newImage(value129, true)
                            elseif value128 == 'Visible' then
                                self._frame.Visible = value129
                            elseif value128 == 'ZIndex' then
                                self._frame.ZIndex = value129
                            end
                        end
                    end
                    function drawingClass5:__iter()
                        return next, self._properties
                    end
                    function drawingClass5:__tostring()
                        return 'Drawing'
                    end
                    function drawingClass5:Destroy()
                        value055[self._id] = nil
                        self.__OBJECT_EXISTS = false

                        value029(self._frame)
                    end
                    function drawingClass5:_newImage(value135, value136)
                        value024(function()
                            self._imageId = self._imageId + 1

                            local value137 = value023('%s-%s.png', self._id, self._imageId)

                            if value136 then
                                local value138

                                while value138 == nil do

                                    local success, resultOrError = pcall(value031, game, value135, true)

                                    if success then
                                        value138 = resultOrError
                                    elseif string.find(string.lower(resultOrError), 'too many requests') then
                                        task.wait(3)
                                    else
                                        error(resultOrError, 2)

                                        return
                                    end
                                end

                                self._properties.Data = value135
                            else
                                self._properties.Uri = ''
                            end

                            self._frame.Image = value032(value137, value135)
                        end)
                    end

                    drawingClass5.Remove = drawingClass5.Destroy
                    value056.Image = drawingClass5
                end

                value012.new = newcclosure(function(value141)
                    return value016(value056[value141], value023("Invalid drawing type '%s'", value141)).new()
                end)
                value012.clear = newcclosure(function()
                    for key4, value4 in value055 do

                        if value4.__OBJECT_EXISTS then
                            value4:Destroy()
                        end
                    end
                end)
                value012.cache = value055
            end

            setreadonly(value012, true)
            setreadonly(value012.Fonts, true)

            return value012
        end
    end
end

-- nick
-- nick.dropdown
-- nick
function Native.dropdown(captures)
    local scalar = captures[7]
    local colorPickerObject = captures[6]
    local dropdown = captures[0]
    local frame = captures[2]
    local mouse = captures[9]
    local textLabel_13 = captures[13]
    local userInputService = captures[14]
    local textLabel = captures[10]
    local outlineColorNameCell = captures[4]
    local textLabel_11 = captures[11]
    local frameClassCell = captures[15]
    local flagName = captures[12]
    local frame_8 = captures[8]
    local config = captures[3]
    local sharedObject = captures[5]
    local uiLibrary = captures[1]

    return function()
        local outlineColorName = outlineColorNameCell[3][outlineColorNameCell[2]]
        local frameClass = frameClassCell[3][frameClassCell[2]]
        local function value018()
            frame.Position = UDim2.fromOffset(frame_8.AbsolutePosition.X, frame_8.AbsolutePosition.Y + frame_8.Size.Y.Offset + 1)
        end
        local function value019(value020)
            local value021 = value020 or math.clamp(#dropdown.Values * 20, 0, scalar * 20) + 1

            frame.Size = UDim2.fromOffset(frame_8.AbsoluteSize.X + 0.5, value021)
        end

        value018()
        value019()
        frame_8:GetPropertyChangedSignal('AbsolutePosition'):Connect(value018)

        local value022 = uiLibrary:Create(frameClass, {
            BackgroundColor3 = uiLibrary.MainColor,
            BorderColor3 = uiLibrary.OutlineColor,
            BorderMode = Enum.BorderMode.Inset,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = 21,
            Parent = frame,
        })

        uiLibrary:AddToRegistry(value022, {
            BackgroundColor3 = 'MainColor',
            BorderColor3 = outlineColorName,
        })

        local scrollingFrame = uiLibrary:Create('ScrollingFrame', {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = 21,
            Parent = value022,
            TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png',
            BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png',
            ScrollingDirection = Enum.ScrollingDirection.Y,
            ScrollBarThickness = uiLibrary.IsMobile and 15 or 3,
            ScrollBarImageColor3 = uiLibrary.AccentColor,
        })

        uiLibrary:AddToRegistry(scrollingFrame, {
            ScrollBarImageColor3 = 'AccentColor',
        })
        uiLibrary:Create('UIListLayout', {
            Padding = UDim.new(0, 0),
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = scrollingFrame,
        })

        function dropdown:Display()
            local values = dropdown.Values
            local value026 = ''

            if config.Multi then
                for key, value in next, values do

                    if dropdown.Value[value] then
                        value026 = value026 .. value .. ', '
                    end
                end

                value026 = value026:sub(1, #value026 - 2)
            else
                value026 = dropdown.Value or ''
            end

            textLabel_11.Text = value026 == '' and '...' or value026
        end
        function dropdown:GetActiveValues()
            if config.Multi then
                local value030 = {}

                for key2, value2 in next, dropdown.Value do
                    table.insert(value030, key2)
                end

                return value030
            else
                return dropdown.Value and 1 or 0
            end
        end
        function dropdown:BuildDropdownList()
            local values2 = dropdown.Values
            local value035 = {}

            for key3, value3 in next, scrollingFrame:GetChildren()do

                if not value3:IsA('UIListLayout') then
                    value3:Destroy()
                end
            end

            local value038 = 0

            for key4, value4 in next, values2 do

                local value041 = {}

                value038 = value038 + 1

                local imageButton = uiLibrary:Create('ImageButton', {
                    BackgroundColor3 = uiLibrary.MainColor,
                    BorderColor3 = uiLibrary.OutlineColor,
                    BorderMode = Enum.BorderMode.Middle,
                    Size = UDim2.new(1, -1, 0, 20),
                    ZIndex = 23,
                    Active = true,
                    Parent = scrollingFrame,
                    Image = '',
                    Active = false,
                    AutoButtonColor = false,
                })

                uiLibrary:AddToRegistry(imageButton, {
                    BackgroundColor3 = 'MainColor',
                    BorderColor3 = outlineColorName,
                })

                local value043 = uiLibrary:CreateLabel({
                    Active = false,
                    Size = UDim2.new(1, -6, 1, 0),
                    Position = UDim2.new(0, 6, 0, 0),
                    TextSize = 14,
                    Text = value4,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 25,
                    Parent = imageButton,
                })

                uiLibrary:OnHighlight(imageButton, imageButton, {
                    BorderColor3 = outlineColorName,
                    ZIndex = 24,
                }, {
                    BorderColor3 = outlineColorName,
                    ZIndex = 23,
                })

                local value044

                if config.Multi then
                    value044 = dropdown.Value[value4]
                else
                    value044 = dropdown.Value == value4
                end

                function value041:UpdateButton()
                    if config.Multi then
                        value044 = dropdown.Value[value4]
                    else
                        value044 = dropdown.Value == value4
                    end

                    value043.TextColor3 = value044 and uiLibrary.AccentColor or uiLibrary.FontColor
                    uiLibrary.RegistryMap[value043].Properties.TextColor3 = value044 and 'AccentColor' or 'FontColor'
                end

                value043.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        local value047 = not value044

                        if dropdown:GetActiveValues() == 1 and not value047 and not config.AllowNull then
                        else
                            if config.Multi then
                                value044 = value047

                                if value044 then
                                    dropdown.Value[value4] = true
                                else
                                    dropdown.Value[value4] = nil
                                end
                            else
                                value044 = value047

                                if value044 then
                                    dropdown.Value = value4
                                else
                                    dropdown.Value = nil
                                end

                                for key5, value5 in next, value035 do
                                    value5:UpdateButton()
                                end
                            end

                            value041:UpdateButton()
                            dropdown:Display()
                            uiLibrary:UpdateDependencyBoxes()
                            uiLibrary:SafeCallback(dropdown.Callback, dropdown.Value)
                            uiLibrary:SafeCallback(dropdown.Changed, dropdown.Value)
                            uiLibrary:AttemptSave()
                        end
                    end
                end)
                value041:UpdateButton()

                value035[imageButton] = value041
            end

            dropdown:Display()

            scrollingFrame.CanvasSize = UDim2.fromOffset(0, value038 * 20 + 1)
            scrollingFrame.Visible = false
            scrollingFrame.Visible = true

            local value050 = math.clamp(value038 * 20, 0, scalar * 20) + 1

            value019(value050)
        end
        function dropdown:SetValues(values3)
            if values3 then
                dropdown.Values = values3
            end

            dropdown:BuildDropdownList()
        end
        function dropdown:OpenDropdown()
            if uiLibrary.IsMobile then
                uiLibrary.CanDrag = false
            end

            frame.Visible = true
            uiLibrary.OpenedFrames[frame] = true
            textLabel.Rotation = 90

            value019()
        end
        function dropdown:CloseDropdown()
            if uiLibrary.IsMobile then
                uiLibrary.CanDrag = true
            end

            frame.Visible = false
            uiLibrary.OpenedFrames[frame] = nil
            textLabel.Rotation = 0
        end
        function dropdown:OnChanged(callback)
            dropdown.Changed = callback

            callback(dropdown.Value)
        end
        function dropdown:SetValue(newValue)
            if dropdown.Multi then
                local value059 = {}

                for key6, value6 in next, newValue do

                    if dropdown.Illegal or table.find(dropdown.Values, key6) then
                        value059[key6] = true
                    end
                end

                dropdown.Value = value059
            elseif not newValue then
                dropdown.Value = nil
            elseif dropdown.Illegal or table.find(dropdown.Values, newValue) then
                dropdown.Value = newValue
            end

            dropdown:BuildDropdownList()
            uiLibrary:SafeCallback(dropdown.Callback, dropdown.Value)
            uiLibrary:SafeCallback(dropdown.Changed, dropdown.Value)
        end
        function dropdown:Remove()
            for key7, value7 in textLabel_13 do
                value7:Destroy()
            end

            colorPickerObject[flagName] = nil

            frame_8:Destroy()
            table.clear(dropdown)
        end

        frame_8.InputBegan:Connect(function(input2)
            if uiLibrary.IsDragging then
                return
            end
            if input2.UserInputType == Enum.UserInputType.MouseButton1 and not uiLibrary:MouseIsOverOpenedFrame() or input2.UserInputType == Enum.UserInputType.Touch then
                if frame.Visible then
                    dropdown:CloseDropdown()
                else
                    dropdown:OpenDropdown()
                end
            end
        end)
        userInputService.InputBegan:Connect(function(input3)
            if uiLibrary.IsDragging then
                return
            end
            if input3.UserInputType == Enum.UserInputType.MouseButton1 or input3.UserInputType == Enum.UserInputType.Touch then
                local absolutePosition, absoluteSize = frame.AbsolutePosition, frame.AbsoluteSize

                if mouse.X < absolutePosition.X or mouse.X > absolutePosition.X + absoluteSize.X or mouse.Y < absolutePosition.Y - 20 - 1 or mouse.Y > absolutePosition.Y + absoluteSize.Y then
                    dropdown:CloseDropdown()
                end
            end
        end)

        if uiLibrary.FlagCopying then
            local value069 = uiLibrary:AddContextMenu(frame_8)

            value069:AddOption('Copy Flag', function()
                pcall(setclipboard, dropdown.Idx)
                task.wait()
                uiLibrary:Notify('Copied flag to clipboard!', 2)
                value069:Hide()
            end)
        end

        dropdown:BuildDropdownList()
        dropdown:Display()

        local value070 = {}

        if typeof(config.Default) == 'string' then
            local matchStart = table.find(dropdown.Values, config.Default)

            if matchStart then
                table.insert(value070, matchStart)
            end
        elseif typeof(config.Default) == 'table' then
            for key8, value8 in next, config.Default do

                local matchStart2 = table.find(dropdown.Values, value8)

                if matchStart2 then
                    table.insert(value070, matchStart2)
                end
            end
        elseif typeof(config.Default) == 'number' and dropdown.Values[config.Default] ~= nil then
            table.insert(value070, config.Default)
        end
        if next(value070) then
            for index = 1, #value070 do

                local value076 = value070[index]

                if config.Multi then
                    dropdown.Value[dropdown.Values[value076] ] = true
                else
                    dropdown.Value = dropdown.Values[value076]
                end
                if not config.Multi then
                    break
                end
            end

            dropdown:BuildDropdownList()
            dropdown:Display()
        end

        table.insert(textLabel_13, sharedObject:AddBlank(config.BlankSize or 5))
        sharedObject:Resize()

        colorPickerObject[flagName] = dropdown
    end
end

-- nick
-- nick.emptyCallback
-- nick
function Native.emptyCallback()
    return function() end
end

-- nick
-- nick.keyPicker
-- nick
function Native.keyPicker(captures)
    local textLabel_7 = captures[7]
    local frame_9 = captures[9]
    local config = captures[3]
    local frame = captures[2]
    local sharedObject = captures[8]
    local keypickerObject = captures[0]
    local flagName = captures[6]
    local textLabel = captures[5]
    local uiLibrary = captures[4]
    local colorPickerObject = captures[10]
    local userInputService = captures[1]

    return function()
        local value013 = config.Modes or {
            'Always',
            'Toggle',
            'Hold',
        }
        local value014 = uiLibrary:AddContextMenu(frame)
        local value015 = {}

        for key, value in value013 do

            local value018

            value018 = value014:AddOption(value, function()
                keypickerObject.Mode = value
                value018.TextColor3 = uiLibrary.AccentColor

                for key2, value2 in value015 do

                    if value2 ~= value018 then
                        value2.TextColor3 = key2 == keypickerObject.Mode and uiLibrary.AccentColor or uiLibrary.FontColor
                    end
                end

                uiLibrary:AttemptSave()
            end)

            value018:GetPropertyChangedSignal('TextColor3'):Connect(function()
                if value == keypickerObject.Mode then
                    value018.TextColor3 = uiLibrary.AccentColor
                else
                    value018.TextColor3 = uiLibrary.FontColor
                end
            end)

            value015[value] = value018
        end

        if uiLibrary.FlagCopying then
            value014:AddOption('Copy Flag', function()
                pcall(setclipboard, keypickerObject.Idx)
                task.wait()
                uiLibrary:Notify('Copied flag to clipboard!', 2)
                value014:Hide()
            end)
        end

        for key3, value3 in value015 do

            value3.TextColor3 = key3 == keypickerObject.Mode and uiLibrary.AccentColor or uiLibrary.FontColor
        end

        local value023 = function(value024)
            local mode = keypickerObject.Mode

            mode = mode ~= 'Always' and keypickerObject.Override and 'Override' or mode
            textLabel.Text = string.format('[%s] %s (%s)', keypickerObject.Value, config.Text, mode)
            textLabel.Visible = true
            textLabel.TextColor3 = value024 and uiLibrary.AccentColor or uiLibrary.FontColor
            uiLibrary.RegistryMap[textLabel].Properties.TextColor3 = value024 and 'AccentColor' or 'FontColor'
        end

        function keypickerObject:Update()
            if not keypickerObject.NoUI then
                local keypickerListMode = uiLibrary.KeypickerListMode
                local value028 = keypickerObject:GetState()

                if keypickerListMode == 'Active' and keypickerObject.Parent.Type == 'Toggle' and (not value028 or not keypickerObject.Parent.Value) then
                    textLabel.Visible = false
                elseif keypickerListMode == 'Toggled' and keypickerObject.Parent.Type == 'Toggle' and not keypickerObject.Parent.Value then
                    textLabel.Visible = false
                else
                    value023(value028)
                end
            else
                textLabel.Visible = false
            end

            local value029 = 0
            local value030 = 0

            for key4, value4 in next, uiLibrary.KeybindContainer:GetChildren()do

                if value4:IsA('TextLabel') and value4.Visible then
                    value029 = value029 + 18

                    if value4.TextBounds.X > value030 then
                        value030 = value4.TextBounds.X
                    end
                end
            end

            uiLibrary.KeybindFrame.Size = UDim2.new(0, math.max(value030 + 10, 210), 0, value029 + 23)
            uiLibrary.KeybindFrame.Visible = uiLibrary.KeypickerListVisible and value029 ~= 0
        end
        function keypickerObject:OverrideState(overrideState)
            if self.Override == overrideState then
                return
            end

            self.Override = overrideState
            keypickerObject.Toggled = false

            keypickerObject:Update()
        end

        local isMouseButtonPressed, isKeyDown = userInputService.IsMouseButtonPressed, userInputService.IsKeyDown
        local mouseButton1, mouseButton2 = Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2
        local keyCode = Enum.KeyCode

        function keypickerObject:GetState()
            local mode2 = keypickerObject.Mode

            if mode2 == 'Always' then
                return true
            end

            local value7 = keypickerObject.Value

            if value7 == '...' then
                return true
            end

            local value043 = nil

            if mode2 == 'Hold' then
                if value7 == 'MB1' or value7 == 'MB2' then
                    value043 = value7 == 'MB1' and isMouseButtonPressed(userInputService, mouseButton1) or value7 == 'MB2' and isMouseButtonPressed(userInputService, mouseButton2)
                else
                    value043 = isKeyDown(userInputService, keyCode[value7])
                end
            else
                value043 = keypickerObject.Toggled
            end
            if value043 and self.Override then
                keypickerObject:OverrideState(false)
            end

            return value043 or self.Override
        end
        function keypickerObject:SetValue(newValue)
            local value046, value047 = newValue[1], newValue[2]

            textLabel_7.Text = value046
            keypickerObject.Value, keypickerObject.Mode = value046, value047

            for key5, value5 in value015 do

                value5.TextColor3 = key5 == keypickerObject.Mode and uiLibrary.AccentColor or uiLibrary.FontColor
            end

            keypickerObject:Update()
        end
        function keypickerObject:OnClick(callback)
            keypickerObject.Clicked = callback
        end
        function keypickerObject:OnChanged(callback2)
            keypickerObject.Changed = callback2

            callback2(keypickerObject.Value)
        end

        if sharedObject.Addons then
            table.insert(sharedObject.Addons, keypickerObject)
        end

        function keypickerObject:DoClick()
            if keypickerObject.Override then
                keypickerObject.Override = false
                keypickerObject.Toggled = false
            end
            if sharedObject.Type == 'Toggle' and keypickerObject.SyncToggleState then
                sharedObject:SetValue(not sharedObject.Value)
            end

            uiLibrary:SafeCallback(keypickerObject.Callback, keypickerObject.Toggled)
            uiLibrary:SafeCallback(keypickerObject.Clicked, keypickerObject.Toggled)
        end
        function keypickerObject:SetupConnection(connection)
            table.insert(self.Connections, connection)
            uiLibrary:GiveSignal(connection)
        end
        function keypickerObject:Remove()
            colorPickerObject[flagName] = nil

            for key6, value6 in keypickerObject.Connections do
                value6:Disconnect()
            end

            table.clear(keypickerObject)
            frame:Destroy()
            textLabel:Destroy()
        end
        function keypickerObject:SetModePickerVisibility(visible)
            frame_9.Visible = visible
        end
        function keypickerObject:GetModePickerVisibility()
            return frame_9.Visible
        end

        local value063 = false
        local value064 = {
            [Enum.KeyCode.Escape] = true,
            [Enum.KeyCode.Backspace] = true,
        }

        frame.InputBegan:Connect(function(input)
            if not value063 and input.UserInputType == Enum.UserInputType.MouseButton1 and not uiLibrary:MouseIsOverOpenedFrame() then
                value063 = true
                textLabel_7.Text = ''

                local value066
                local value067 = ''

                task.spawn(function()
                    while not value066 do

                        if value067 == '...' then
                            value067 = ''
                        end

                        value067 = value067 .. '.'
                        textLabel_7.Text = value067

                        wait(0.4)
                    end
                end)
                wait(0.2)

                local value068

                value068 = userInputService.InputBegan:Connect(function(input2)
                    local value070

                    if input2.UserInputType == Enum.UserInputType.Keyboard then
                        value070 = value064[input2.KeyCode] and '...' or input2.KeyCode.Name
                    elseif input2.UserInputType == Enum.UserInputType.MouseButton1 then
                        value070 = 'MB1'
                    elseif input2.UserInputType == Enum.UserInputType.MouseButton2 then
                        value070 = 'MB2'
                    end

                    value066 = true
                    value063 = false
                    textLabel_7.Text = value070
                    keypickerObject.Value = value070

                    uiLibrary:SafeCallback(keypickerObject.ChangedCallback, input2.KeyCode or input2.UserInputType)
                    uiLibrary:SafeCallback(keypickerObject.Changed, input2.KeyCode or input2.UserInputType)
                    uiLibrary:AttemptSave()
                    value068:Disconnect()
                end)
            end
        end)
        keypickerObject:SetupConnection(userInputService.InputBegan:Connect(function(input3, gameProcessed)
            if not value063 and not gameProcessed then
                if keypickerObject.Mode == 'Toggle' then
                    local value8 = keypickerObject.Value

                    if value8 == 'MB1' or value8 == 'MB2' then
                        if value8 == 'MB1' and input3.UserInputType == Enum.UserInputType.MouseButton1 or value8 == 'MB2' and input3.UserInputType == Enum.UserInputType.MouseButton2 then
                            keypickerObject.Toggled = not keypickerObject.Toggled

                            keypickerObject:DoClick()
                        end
                    elseif input3.UserInputType == Enum.UserInputType.Keyboard then
                        if input3.KeyCode.Name == value8 then
                            keypickerObject.Toggled = not keypickerObject.Toggled

                            keypickerObject:DoClick()
                        end
                    end
                end

                keypickerObject:Update()
            end
        end))
        keypickerObject:SetupConnection(userInputService.InputEnded:Connect(function(input4)
            if not value063 then
                keypickerObject:Update()
            end
        end))
        keypickerObject:Update()

        colorPickerObject[flagName] = keypickerObject
    end
end

-- nick
-- nick.library
-- nick
function Native.library(captures)
    local screenGui_9 = captures[9]
    local fnCell_11 = captures[11]
    local uiLibrary = captures[0]
    local coreGui = captures[10]
    local callbackFn = captures[17]
    local playersService = captures[22]
    local frameInstanceCell = captures[12]
    local runService = captures[19]
    local textService = captures[18]
    local userInputService = captures[6]
    local fnCell = captures[8]
    local groupBoxApi = captures[14]
    local eventClassCell = captures[2]
    local teamsService = captures[21]
    local contextActionService = captures[13]
    local frameClassCell = captures[1]
    local screenGui_5 = captures[5]
    local mouse = captures[3]
    local blur = captures[16]
    local colorCorrection = captures[20]
    local renderStepped = captures[4]
    local flagCell = captures[7]
    local callbackFn_23 = captures[23]
    local outlineColorNameCell = captures[15]

    return function()
        local frameClass = frameClassCell[3][frameClassCell[2]]
        local eventClass = eventClassCell[3][eventClassCell[2]]
        local flag = flagCell[3][flagCell[2]]
        local fn = fnCell[3][fnCell[2]]
        local fn_11 = fnCell_11[3][fnCell_11[2]]
        local frameInstance = frameInstanceCell[3][frameInstanceCell[2]]
        local outlineColorName = outlineColorNameCell[3][outlineColorNameCell[2]]
        fn, fnCell[3][fnCell[2]] = function()
            local players = playersService:GetPlayers()

            for index = 1, #players do

                players[index] = players[index].Name
            end

            table.sort(players, function(value028, value029)
                return value028 < value029
            end)

            return players
        end
        fn_11, fnCell_11[3][fnCell_11[2]] = function()
            local teams = teamsService:GetTeams()

            for index2 = 1, #teams do

                teams[index2] = teams[index2].Name
            end

            table.sort(teams, function(value032, value033)
                return value032 < value033
            end)

            return teams
        end

        function uiLibrary:SafeCallback(callback, ...)
            if not callback then
                return
            end
            if not uiLibrary.NotifyOnError then
                return callback(...)
            end

            local success, resultOrError = pcall(callback, ...)

            if not success then
                local matchStart, matchEnd = resultOrError:find(':%d+: ')

                if not matchEnd then
                    return uiLibrary:Notify(resultOrError)
                end

                return uiLibrary:Notify(resultOrError:sub(matchEnd + 1), 3)
            end
        end
        function uiLibrary:AttemptSave()
            if uiLibrary.SaveManager then
                uiLibrary.SaveManager:Save()
            end
        end
        function uiLibrary:Create(classOrInstance, properties)
            local instance3 = classOrInstance

            if typeof(classOrInstance) == 'string' then
                instance3 = Instance.new(classOrInstance)
            end

            for key, value in next, properties do

                local success2, resultOrError2 = pcall(function()
                    instance3[key] = value
                end)

                if not success2 then
                    callbackFn(resultOrError2)
                end
            end

            return instance3
        end
        function uiLibrary:EnableFlagCopying(enabled)
            uiLibrary.FlagCopying = enabled
        end
        function uiLibrary:ApplyTextStroke(label)
            label.TextStrokeTransparency = 1

            return uiLibrary:Create('UIStroke', {
                Color = Color3.new(0, 0, 0),
                Thickness = 1,
                LineJoinMode = Enum.LineJoinMode.Miter,
                Parent = label,
            })
        end
        function uiLibrary:CreateLabel(properties2, isHud)
            local textLabel = uiLibrary:Create('TextLabel', {
                BackgroundTransparency = 1,
                Font = uiLibrary.Font,
                TextColor3 = uiLibrary.FontColor,
                TextSize = 16,
                TextStrokeTransparency = 0,
            })

            uiLibrary:ApplyTextStroke(textLabel)
            uiLibrary:AddToRegistry(textLabel, {
                TextColor3 = 'FontColor',
            }, isHud)

            return uiLibrary:Create(textLabel, properties2)
        end
        function uiLibrary:MakeDraggable(frame, dragHeight, respectDragLock)
            frame.Active = true

            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    if respectDragLock == true and uiLibrary.CantDragForced == true then
                        return
                    end

                    local dragOffset = Vector2.new(mouse.X - frame.AbsolutePosition.X, mouse.Y - frame.AbsolutePosition.Y)

                    if dragOffset.Y > (dragHeight or 40) then
                        return
                    end

                    while userInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do

                        frame.Position = UDim2.new(0, mouse.X - dragOffset.X + frame.Size.X.Offset * frame.AnchorPoint.X, 0, mouse.Y - dragOffset.Y + frame.Size.Y.Offset * frame.AnchorPoint.Y)

                        renderStepped:Wait()
                    end
                end
            end)
        end

        local screenGui = Instance.new('ScreenGui', coreGui)

        function uiLibrary:MakeDraggableOutline(frame2, dragHeight2, respectDragLock2)
            frame2.Active = true

            frame2.InputBegan:Connect(function(input2)
                if input2.UserInputType == Enum.UserInputType.MouseButton1 then
                    if respectDragLock2 == true and uiLibrary.CantDragForced == true then
                        return
                    end

                    local dragOffset2 = Vector2.new(mouse.X - frame2.AbsolutePosition.X, mouse.Y - frame2.AbsolutePosition.Y)

                    if dragOffset2.Y > (dragHeight2 or 40) then
                        return
                    end

                    local value070 = uiLibrary:Create(frameClass, {
                        Parent = screenGui,
                        AnchorPoint = frame2.AnchorPoint,
                        BackgroundTransparency = 1,
                        Size = frame2.Size,
                        Position = frame2.Position,
                    })
                    local uIStroke = uiLibrary:Create('UIStroke', {
                        Parent = value070,
                        Color = uiLibrary.AccentColor or Color3.new(0, 0, 0),
                    })

                    uiLibrary.IsDragging = true

                    while(userInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)) do

                        value070.Position = UDim2.new(0, mouse.X - dragOffset2.X + frame2.Size.X.Offset * frame2.AnchorPoint.X, 0, mouse.Y - dragOffset2.Y + frame2.Size.Y.Offset * frame2.AnchorPoint.Y)
                        uIStroke.Color = uiLibrary.AccentColor or Color3.new(0, 0, 0)

                        renderStepped:Wait()
                    end

                    frame2.Position = value070.Position

                    value070:Destroy()

                    uiLibrary.IsDragging = false
                end
                if input2.UserInputType == Enum.UserInputType.Touch then
                    if respectDragLock2 == true and uiLibrary.CantDragForced == true then
                        return
                    end

                    local value072 = Vector2.new(input2.Position.X - frame2.AbsolutePosition.X, input2.Position.Y - frame2.AbsolutePosition.Y)

                    if value072.Y > (dragHeight2 or 40) then
                        return
                    end

                    local value073 = uiLibrary:Create(frameClass, {
                        Parent = screenGui,
                        AnchorPoint = frame2.AnchorPoint,
                        BackgroundTransparency = 1,
                        Size = frame2.Size,
                        Position = frame2.Position,
                    })
                    local uIStroke2 = uiLibrary:Create('UIStroke', {
                        Parent = value073,
                        Color = uiLibrary.AccentColor or Color3.new(0, 0, 0),
                    })

                    uiLibrary.IsDragging = true

                    local value075 = true
                    local value076

                    value076 = input2.Changed:Connect(function()
                        if input2.UserInputState == Enum.UserInputState.End then
                            value075 = false
                        end
                    end)

                    while value075 do

                        value073.Position = UDim2.new(0, input2.Position.X - value072.X + frame2.Size.X.Offset * frame2.AnchorPoint.X, 0, input2.Position.Y - value072.Y + frame2.Size.Y.Offset * frame2.AnchorPoint.Y)
                        uIStroke2.Color = uiLibrary.AccentColor or Color3.new(0, 0, 0)

                        renderStepped:Wait()
                    end

                    frame2.Position = value073.Position

                    if value076 then
                        value076:Disconnect()
                    end

                    value073:Destroy()

                    uiLibrary.IsDragging = false
                end
            end)
        end
        function uiLibrary:MakeDraggableUsingParent(handle, frame3, dragHeight3, respectDragLock3)
            handle.Active = true

            if uiLibrary.IsMobile == false then
                handle.InputBegan:Connect(function(input3)
                    if input3.UserInputType == Enum.UserInputType.MouseButton1 or input3.UserInputType == Enum.UserInputType.Touch then
                        if respectDragLock3 == true and uiLibrary.CantDragForced == true then
                            return
                        end

                        local dragOffset3 = Vector2.new(mouse.X - frame3.AbsolutePosition.X, mouse.Y - frame3.AbsolutePosition.Y)

                        if dragOffset3.Y > (dragHeight3 or 40) then
                            return
                        end

                        while userInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do

                            frame3.Position = UDim2.new(0, mouse.X - dragOffset3.X + frame3.Size.X.Offset * frame3.AnchorPoint.X, 0, mouse.Y - dragOffset3.Y + frame3.Size.Y.Offset * frame3.AnchorPoint.Y)

                            renderStepped:Wait()
                        end
                    end
                end)
            else
                uiLibrary:MakeDraggable(frame3, dragHeight3, respectDragLock3)
            end
        end
        function uiLibrary:MakeResizable(value085, value086)
            value085.Active = true

            local value087 = 25
            local value088 = 0.5
            local value089 = uiLibrary:Create(frameClass, {
                SizeConstraint = Enum.SizeConstraint.RelativeXX,
                BackgroundColor3 = Color3.new(0, 0, 0),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.new(0, 30, 0, 30),
                Position = UDim2.new(1, -30, 1, -30),
                Visible = true,
                ClipsDescendants = true,
                ZIndex = 1,
                Parent = value085,
            })
            local imageButton = uiLibrary:Create('ImageButton', {
                BackgroundColor3 = uiLibrary.AccentColor,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.new(2, 0, 2, 0),
                Position = UDim2.new(1, -30, 1, -30),
                ZIndex = 2,
                Parent = value089,
            })
            local uICorner = uiLibrary:Create('UICorner', {
                CornerRadius = UDim.new(0.5, 0),
                Parent = imageButton,
            })

            uiLibrary:AddToRegistry(imageButton, {
                BackgroundColor3 = 'AccentColor',
            })

            value089.Size = UDim2.fromOffset(value087, value087)
            value089.Position = UDim2.new(1, -value087, 1, -value087)
            value086 = value086 or uiLibrary.MinSize

            local value092
            local value093, uIStroke3 = nil, uiLibrary:Create('UIStroke', {
                Color = uiLibrary.AccentColor or Color3.new(0, 0, 0),
            })

            uIStroke3.Color = uiLibrary.AccentColor or Color3.new(0, 0, 0)

            local function value095(value096)
                imageButton.Position = UDim2.new()
                imageButton.Size = UDim2.new(2, 0, 2, 0)
                imageButton.Parent = value089
                imageButton.BackgroundTransparency = value096
                uICorner.Parent = imageButton
                value092 = nil

                if value093 then
                    uIStroke3.Parent = nil
                    value085.Size = value093.Size

                    value093:Destroy()
                end
            end

            if uiLibrary.IsMobile ~= true then
                imageButton.MouseButton1Down:Connect(function()
                    if value092 then
                        return
                    end

                    value092 = Vector2.new(mouse.X - (value085.AbsolutePosition.X + value085.AbsoluteSize.X), mouse.Y - (value085.AbsolutePosition.Y + value085.AbsoluteSize.Y))
                    value093 = uiLibrary:Create(frameClass, {
                        Parent = screenGui,
                        AnchorPoint = value085.AnchorPoint,
                        BackgroundTransparency = 1,
                        Size = value085.Size,
                        Position = value085.Position,
                    })
                    uIStroke3.Parent = value093
                    imageButton.BackgroundTransparency = 1
                    imageButton.Size = UDim2.fromOffset(uiLibrary.ScreenGui.AbsoluteSize.X, uiLibrary.ScreenGui.AbsoluteSize.Y)
                    imageButton.Position = UDim2.new()
                    uICorner.Parent = nil
                    imageButton.Parent = uiLibrary.ScreenGui
                end)
                imageButton.MouseMoved:Connect(function()
                    if not value092 then
                        return
                    end

                    local value097 = Vector2.new(mouse.X - value092.X, mouse.Y - value092.Y)
                    local value098 = Vector2.new(math.clamp(value097.X - value085.AbsolutePosition.X, value086.X, math.huge), math.clamp(value097.Y - value085.AbsolutePosition.Y, value086.Y, math.huge))

                    value093.Size = UDim2.fromOffset(value098.X, value098.Y)
                end)
                imageButton.MouseButton1Up:Connect(function()
                    value095(value088)
                end)
            else
                imageButton.InputBegan:Connect(function(input4)
                    if input4.UserInputType ~= Enum.UserInputType.Touch then
                        return
                    end
                    if value092 then
                        return
                    end

                    value092 = Vector2.new(input4.Position.X - (value085.AbsolutePosition.X + value085.AbsoluteSize.X), input4.Position.Y - (value085.AbsolutePosition.Y + value085.AbsoluteSize.Y))
                    value093 = uiLibrary:Create(frameClass, {
                        Parent = screenGui,
                        AnchorPoint = value085.AnchorPoint,
                        BackgroundTransparency = 1,
                        Size = value085.Size,
                        Position = value085.Position,
                    })
                    uIStroke3.Parent = value093
                end)
                imageButton.InputChanged:Connect(function(input5)
                    if input5.UserInputType ~= Enum.UserInputType.Touch then
                        return
                    end
                    if not value092 then
                        return
                    end

                    local value101 = Vector2.new(input5.Position.X - value092.X, input5.Position.Y - value092.Y)
                    local value102 = Vector2.new(math.clamp(value101.X - value085.AbsolutePosition.X, value086.X, math.huge), math.clamp(value101.Y - value085.AbsolutePosition.Y, value086.Y, math.huge))

                    value093.Size = UDim2.fromOffset(value102.X, value102.Y)
                end)
                imageButton.InputEnded:Connect(function(input6)
                    if input6.UserInputType ~= Enum.UserInputType.Touch then
                        return
                    end

                    value095(value088)
                end)
            end

            value095(value088)
        end
        function uiLibrary:AddToolTip(text, target)
            local textWidth, textHeight = uiLibrary:GetTextBounds(text, uiLibrary.Font, 14)
            local value109 = uiLibrary:Create(frameClass, {
                BackgroundColor3 = uiLibrary.MainColor,
                BorderColor3 = uiLibrary.OutlineColor,
                Size = UDim2.fromOffset(textWidth + 5, textHeight + 4),
                ZIndex = 100,
                Parent = uiLibrary.ScreenGui,
                Visible = false,
            })
            local value110 = uiLibrary:CreateLabel({
                Position = UDim2.fromOffset(3, 1),
                Size = UDim2.fromOffset(textWidth, textHeight),
                TextSize = 14,
                Text = text,
                TextColor3 = uiLibrary.FontColor,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = value109.ZIndex + 1,
                Parent = value109,
            })

            uiLibrary:AddToRegistry(value109, {
                BackgroundColor3 = 'MainColor',
                BorderColor3 = outlineColorName,
            })
            uiLibrary:AddToRegistry(value110, {
                TextColor3 = 'FontColor',
            })

            local value111 = false

            target.MouseEnter:Connect(function()
                if uiLibrary:MouseIsOverOpenedFrame() then
                    return
                end

                value111 = true
                value109.Position = UDim2.fromOffset(mouse.X + 15, mouse.Y + 12)
                value109.Visible = true

                while value111 do
                    runService.Heartbeat:Wait()

                    value109.Position = UDim2.fromOffset(mouse.X + 15, mouse.Y + 12)
                end
            end)
            target.MouseLeave:Connect(function()
                value111 = false
                value109.Visible = false
            end)

            if frameInstance then
                frameInstance:GetPropertyChangedSignal('Visible'):Connect(function()
                    if frameInstance.Visible == false then
                        value111 = false
                        value109.Visible = false
                    end
                end)
            end
        end
        function uiLibrary:OnHighlight(target2, styledInstance, highlightProperties, normalProperties, canHighlight)
            local function value118()
                local registryEntry = uiLibrary.RegistryMap[styledInstance]

                for key2, value2 in next, normalProperties do

                    styledInstance[key2] = uiLibrary[value2] or value2

                    if registryEntry and registryEntry.Properties[key2] then
                        registryEntry.Properties[key2] = value2
                    end
                end
            end
            local function value122()
                if canHighlight and not canHighlight() then
                    value118()

                    return
                end

                local registryEntry2 = uiLibrary.RegistryMap[styledInstance]

                for key3, value3 in next, highlightProperties do

                    styledInstance[key3] = uiLibrary[value3] or value3

                    if registryEntry2 and registryEntry2.Properties[key3] then
                        registryEntry2.Properties[key3] = value3
                    end
                end
            end

            target2.MouseEnter:Connect(function()
                value122()
            end)
            target2.MouseMoved:Connect(function()
                value122()
            end)
            target2.MouseLeave:Connect(function()
                value118()
            end)
        end
        function uiLibrary:MouseIsOverOpenedFrame()
            for key4, value4 in next, uiLibrary.OpenedFrames do

                local absolutePosition, absoluteSize = key4.AbsolutePosition, key4.AbsoluteSize

                if mouse.X >= absolutePosition.X and mouse.X <= absolutePosition.X + absoluteSize.X and mouse.Y >= absolutePosition.Y and mouse.Y <= absolutePosition.Y + absoluteSize.Y then
                    return true
                end
            end
        end
        function uiLibrary:IsMouseOverFrame(frame4)
            local absolutePosition2, absoluteSize2 = frame4.AbsolutePosition, frame4.AbsoluteSize

            if mouse.X >= absolutePosition2.X and mouse.X <= absolutePosition2.X + absoluteSize2.X and mouse.Y >= absolutePosition2.Y and mouse.Y <= absolutePosition2.Y + absoluteSize2.Y then
                return true
            end
        end
        function uiLibrary:UpdateDependencyBoxes()
            for key5, value5 in next, uiLibrary.DependencyBoxes do
                value5:Update()
            end
        end
        function uiLibrary:MapValue(inputValue, inputMin, inputMax, outputMin, outputMax)
            return (1 - (inputValue - inputMin) / (inputMax - inputMin)) * outputMin + (inputValue - inputMin) / (inputMax - inputMin) * outputMax
        end
        function uiLibrary:GetTextBounds(text2, font, fontSize, bounds)
            local textSize = textService:GetTextSize(text2, fontSize, font, bounds or Vector2.new(1920, 1080))

            return textSize.X, textSize.Y
        end
        function uiLibrary:GetDarkerColor(color)
            local hue, saturation, brightness = Color3.toHSV(color)

            return Color3.fromHSV(hue, saturation, brightness / 1.5)
        end

        uiLibrary.AccentColorDark = uiLibrary:GetDarkerColor(uiLibrary.AccentColor)

        function uiLibrary:AddToRegistry(instance, properties3, isHud2)
            local registryIndex = #uiLibrary.Registry + 1
            local registryEntry3 = {
                Instance = instance,
                Properties = properties3,
                Idx = registryIndex,
            }

            table.insert(uiLibrary.Registry, registryEntry3)

            uiLibrary.RegistryMap[instance] = registryEntry3

            if isHud2 then
                table.insert(uiLibrary.HudRegistry, registryEntry3)
            end
        end
        function uiLibrary:RemoveFromRegistry(instance2)
            local registryEntry4 = uiLibrary.RegistryMap[instance2]

            if registryEntry4 then
                for index3 = #uiLibrary.Registry, 1, -1 do

                    if uiLibrary.Registry[index3] == registryEntry4 then
                        table.remove(uiLibrary.Registry, index3)
                    end
                end
                for index4 = #uiLibrary.HudRegistry, 1, -1 do

                    if uiLibrary.HudRegistry[index4] == registryEntry4 then
                        table.remove(uiLibrary.HudRegistry, index4)
                    end
                end

                uiLibrary.RegistryMap[instance2] = nil
            end
        end
        function uiLibrary:UpdateColorsUsingRegistry()
            for key6, value6 in next, uiLibrary.Registry do

                for key7, value7 in next, value6.Properties do

                    if typeof(value7) == 'string' then
                        value6.Instance[key7] = uiLibrary[value7]
                    elseif typeof(value7) == 'function' then
                        value6.Instance[key7] = value7()
                    end
                end
            end
        end
        function uiLibrary:GiveSignal(connection)
            table.insert(uiLibrary.Signals, connection)
        end
        function uiLibrary:Unload()
            for index5 = #uiLibrary.Signals, 1, -1 do

                local connection2 = table.remove(uiLibrary.Signals, index5)

                connection2:Disconnect()
            end

            if uiLibrary.OnUnload then
                uiLibrary.OnUnload()
            end

            contextActionService:UnbindAction('Freeze')
            blur:Destroy()
            colorCorrection:Destroy()
            screenGui_5:Destroy()
            screenGui_9:Destroy()
        end
        function uiLibrary:CreateEvent(eventName)
            self.Events[eventName] = Instance.new(eventClass)
        end
        function uiLibrary:FireEvent(eventName2, ...)
            self.Events[eventName2]:Fire(...)
        end
        function uiLibrary:OnEvent(eventName3)
            return self.Events[eventName3].Event
        end
        function uiLibrary:OnUnload(callback2)
            uiLibrary.OnUnload = callback2
        end

        local inputCallbacks = {}

        function uiLibrary:BindToInput(inputType, callback3)
            inputCallbacks[inputType] = inputCallbacks[inputType] or {}

            table.insert(inputCallbacks[inputType], callback3)
        end

        uiLibrary:GiveSignal(userInputService.InputBegan:Connect(function(input7, ...)
            if not flag then
                return
            end

            local value189 = inputCallbacks[input7.KeyCode] or inputCallbacks[input7.UserInputType]

            if value189 then
                for key8, value8 in pairs(value189)do
                    task.spawn(value8, input7, ...)
                end
            end
        end))

        function uiLibrary:AddContextMenu(value193, value194)
            local panel = {Visible = false}

            panel.Options = {}
            panel.Container = uiLibrary:Create('ImageButton', {
                BorderColor3 = Color3.new(),
                ZIndex = 14,
                Visible = false,
                Parent = screenGui_9,
                Image = '',
                Active = false,
                AutoButtonColor = false,
            })
            panel.Inner = uiLibrary:Create(frameClass, {
                BackgroundColor3 = uiLibrary.BackgroundColor,
                BorderColor3 = uiLibrary.OutlineColor,
                BorderMode = Enum.BorderMode.Inset,
                Size = UDim2.fromScale(1, 1),
                ZIndex = 15,
                Parent = panel.Container,
            })

            uiLibrary:Create('UIListLayout', {
                Name = 'Layout',
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Parent = panel.Inner,
            })
            uiLibrary:Create('UIPadding', {
                Name = 'Padding',
                PaddingLeft = UDim.new(0, 0),
                Parent = panel.Inner,
            })

            local function value196()
                panel.Container.Position = UDim2.fromOffset(value193.AbsolutePosition.X + value193.AbsoluteSize.X + 4, value193.AbsolutePosition.Y + 1)
            end
            local function value197()
                local value198 = 60

                for key9, value9 in next, panel.Inner:GetChildren()do

                    if value9:IsA('TextLabel') then
                        value198 = math.max(value198, value9.TextBounds.X)
                    end
                end

                panel.Container.Size = UDim2.fromOffset(value198 + 8, panel.Inner.Layout.AbsoluteContentSize.Y + 4)
            end

            local value201 = false

            (value194 or value193).InputBegan:Connect(function(input8)
                if input8.UserInputType == Enum.UserInputType.MouseButton1 and not uiLibrary:MouseIsOverOpenedFrame() then
                    return panel:Hide()
                elseif input8.UserInputType == Enum.UserInputType.MouseButton2 and not uiLibrary:MouseIsOverOpenedFrame() then
                    return panel:Show()
                end
            end)
            uiLibrary:BindToInput(Enum.UserInputType.MouseButton1, function()
                if value201 and not uiLibrary:IsMouseOverFrame(panel.Container) then
                    panel:Hide()
                end
            end)
            uiLibrary:BindToInput(Enum.UserInputType.MouseButton2, function()
                if value201 and not uiLibrary:IsMouseOverFrame(panel.Container) and not uiLibrary:IsMouseOverFrame(value193) then
                    panel:Hide()
                end
            end)
            task.spawn(value196)
            task.spawn(value197)
            uiLibrary:AddToRegistry(panel.Inner, {
                BackgroundColor3 = 'BackgroundColor',
                BorderColor3 = outlineColorName,
            })

            function panel:Show()
                value196()
                value197()

                value201 = true

                for key10, value10 in next, uiLibrary.OpenedFrames do

                    if key10.Name == 'Color' then
                        key10.Visible = false
                        uiLibrary.OpenedFrames[key10] = nil
                    end
                end

                self.Container.Visible = true
                uiLibrary.OpenedFrames[panel.Container] = true
            end
            function panel:Hide()
                value201 = false
                self.Container.Visible = false

                task.wait()

                uiLibrary.OpenedFrames[panel.Container] = nil
            end
            function panel:AddOption(text3, callback4)
                if type(callback4) ~= 'function' then
                    callback4 = function() end
                end

                local value210 = uiLibrary:CreateLabel({
                    Active = false,
                    Size = UDim2.new(1, 0, 0, 15),
                    TextSize = 13,
                    Text = text3,
                    ZIndex = 16,
                    Parent = self.Inner,
                    TextXAlignment = Enum.TextXAlignment.Center,
                })

                uiLibrary:OnHighlight(value210, value210, {
                    TextColor3 = 'AccentColor',
                }, {
                    TextColor3 = 'FontColor',
                })
                value210.InputBegan:Connect(function(input9)
                    if input9.UserInputType ~= Enum.UserInputType.MouseButton1 then
                        return
                    end

                    callback4()
                end)

                return value210
            end

            return panel
        end

        uiLibrary:GiveSignal(screenGui_9.DescendantRemoving:Connect(function(value212)
            if flag and uiLibrary.RegistryMap[value212] then
                uiLibrary:RemoveFromRegistry(value212)
            end
        end))

        function uiLibrary:SetWatermarkVisibility(visible)
            uiLibrary.Watermark.Visible = visible
        end
        function uiLibrary:SetWatermark(text4)
            local textWidth2, textHeight2 = uiLibrary:GetTextBounds(text4, uiLibrary.Font, 14)

            uiLibrary.Watermark.Size = UDim2.new(0, textWidth2 + 15, 0, textHeight2 * 1.5 + 3)
            uiLibrary.WatermarkText.Text = text4
        end

        local value219 = {
            BarPosition = {
                Top = UDim2.new(0, -1, 0, 0),
                Left = UDim2.new(0, -1, 0, -1),
                Right = UDim2.new(1, -2, 0, -1),
                Bottom = UDim2.new(0, -1, 1, -2),
            },
            BarSize = {
                Top = UDim2.new(1, 3, 0, 2),
                Left = UDim2.new(0, 3, 1, 2),
                Right = UDim2.new(0, 3, 1, 2),
                Bottom = UDim2.new(1, 3, 0, 2),
            },
        }
        local notificationStyle = uiLibrary.NotificationStyle
        local charFn, maxFn = string.char, math.max
        local value223 = function()
            local overrideColor = notificationStyle.OverrideColor

            if overrideColor then
                return overrideColor()
            end

            return uiLibrary.MainColor, uiLibrary.AccentColor, uiLibrary.OutlineColor, uiLibrary.FontColor
        end
        local value225

        do
            local value226 = uiLibrary:Create(frameClass, {
                BorderColor3 = Color3.new(0, 0, 0),
                Position = UDim2.new(0, 100, 0, 10),
                ClipsDescendants = true,
                ZIndex = 100,
            })
            local value227 = uiLibrary:Create(frameClass, {
                BorderMode = Enum.BorderMode.Inset,
                Size = UDim2.new(1, 0, 1, 0),
                ZIndex = 101,
                Parent = value226,
                Name = 'inner',
            })
            local value228 = uiLibrary:Create(frameClass, {
                BackgroundColor3 = Color3.new(1, 1, 1),
                BorderSizePixel = 0,
                Position = UDim2.new(0, 1, 0, 1),
                Size = UDim2.new(1, -2, 1, -2),
                ZIndex = 102,
                Parent = value227,
                Name = 'inner',
            })
            local uIGradient = uiLibrary:Create('UIGradient', {
                Rotation = -90,
                Parent = value228,
            })
            local value230 = uiLibrary:CreateLabel({
                Position = UDim2.new(0, 4, 0, 0),
                Size = UDim2.new(1, -4, 1, 0),
                TextXAlignment = Enum.TextXAlignment.Left,
                TextSize = 14,
                ZIndex = 103,
                Name = 'label',
                Parent = value228,
            })
            local value231 = uiLibrary:Create(frameClass, {
                BorderSizePixel = 0,
                ZIndex = 104,
                Name = 'bar',
                Parent = value226,
            })

            value225 = value226
        end

        function uiLibrary:CreatePopout(settings)
            if type(settings.Title) ~= 'string' then
                settings.Title = 'No title'
            end
            if typeof(settings.Position) ~= 'UDim2' then
                settings.Position = UDim2.fromOffset(175, 50)
            end

            local screenGui2 = Instance.new('ScreenGui')

            callbackFn_23(screenGui2)

            screenGui2.ZIndexBehavior = Enum.ZIndexBehavior.Global
            screenGui2.Parent = coreGui
            screenGui2.DisplayOrder = (settings.ZIndex or 0) + 19

            if settings.Center then
                settings.AnchorPoint = Vector2.new(0.5, 0.5)
                settings.Position = UDim2.fromScale(0.5, 0.5)
            end

            local popout = {}
            local value236 = uiLibrary:Create(frameClass, {
                AnchorPoint = settings.AnchorPoint,
                BackgroundColor3 = Color3.new(0, 0, 0),
                BorderSizePixel = 0,
                Position = settings.Position,
                Size = UDim2.fromOffset(settings.Size.X, settings.Size.Y),
                Visible = settings.AutoShow,
                ZIndex = 1,
                Parent = screenGui2,
            })

            if not settings.RemoveTopbar then
                uiLibrary:MakeDraggableOutline(value236, 25)
            end

            local value237 = uiLibrary:Create(frameClass, {
                BackgroundColor3 = uiLibrary.MainColor,
                BorderColor3 = uiLibrary.OutlineColor,
                BorderMode = Enum.BorderMode.Inset,
                Position = UDim2.new(0, 1, 0, 1),
                Size = UDim2.new(1, -2, 1, -2),
                ZIndex = 1,
                Parent = value236,
            })

            uiLibrary:AddToRegistry(value237, {
                BackgroundColor3 = 'MainColor',
                BorderColor3 = outlineColorName,
            })

            if not settings.RemoveTopbar then
                local value238 = uiLibrary:CreateLabel({
                    Position = UDim2.new(0, 0, 0, 0),
                    Size = UDim2.new(1, 0, 0, 25),
                    Text = settings.Title or '',
                    TextXAlignment = Enum.TextXAlignment.Center,
                    ZIndex = 1,
                    Font = uiLibrary.Font,
                    Parent = value237,
                })
                local textLabel2 = uiLibrary:Create('TextLabel', {
                    BackgroundTransparency = 1,
                    Font = uiLibrary.Font,
                    TextColor3 = uiLibrary.AccentColor,
                    TextSize = 16,
                    TextStrokeTransparency = 0,
                    Position = UDim2.new(0, -8, 0, 0),
                    Size = UDim2.new(1, 0, 0, 25),
                    Text = settings.Version or '',
                    RichText = true,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    ZIndex = 1,
                    Parent = value237,
                })

                uiLibrary:AddToRegistry(textLabel2, {
                    TextColor3 = 'AccentColor',
                })
            end

            local value240 = settings.RemoveTopbar and 8 or 25
            local value241 = settings.RemoveTopbar and -16 or -33
            local value242 = uiLibrary:Create(frameClass, {
                BackgroundColor3 = uiLibrary.BackgroundColor,
                BorderColor3 = uiLibrary.OutlineColor,
                Position = UDim2.new(0, 8, 0, value240),
                Size = UDim2.new(1, -16, 1, value241),
                ZIndex = 1,
                Parent = value237,
            })

            uiLibrary:AddToRegistry(value242, {
                BackgroundColor3 = 'BackgroundColor',
                BorderColor3 = outlineColorName,
            })

            local value243 = uiLibrary:Create(frameClass, {
                BackgroundColor3 = uiLibrary.BackgroundColor,
                BorderColor3 = Color3.new(0, 0, 0),
                BorderMode = Enum.BorderMode.Inset,
                Position = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(1, 0, 1, 0),
                ZIndex = 1,
                Parent = value242,
            })

            uiLibrary:AddToRegistry(value243, {
                BackgroundColor3 = 'BackgroundColor',
            })

            local value244 = uiLibrary:Create(frameClass, {
                BackgroundColor3 = uiLibrary.BackgroundColor,
                BorderColor3 = uiLibrary.OutlineColor,
                Position = UDim2.new(0, 8, 0, 8),
                Size = UDim2.new(1, -16, 1, -16),
                ZIndex = 2,
                Visible = true,
                Parent = value243,
            })
            local value245 = uiLibrary:Create(frameClass, {
                BackgroundTransparency = 1,
                Parent = value244,
                Size = UDim2.fromScale(1, 1),
                Position = UDim2.fromOffset(2, 2),
            })

            uiLibrary:Create('UIListLayout', {
                Padding = UDim.new(0, 0),
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                Parent = value245,
            })
            uiLibrary:AddToRegistry(value244, {
                BackgroundColor3 = 'BackgroundColor',
                BorderColor3 = outlineColorName,
            })
            uiLibrary:AddToRegistry(value245, {
                BackgroundColor3 = 'MainColor',
                BorderColor3 = outlineColorName,
            })

            popout.Holder = value236
            popout.Container = value245

            function popout:Resize()
                local contentHeight = 0

                for key11, value11 in next, value245:GetChildren()do

                    if not value11:IsA('UIListLayout') and value11.Visible then
                        contentHeight = contentHeight + value11.AbsoluteSize.Y
                    end
                end

                value236.Size = UDim2.fromOffset(settings.Size.X, 16 + contentHeight + (value245.AbsolutePosition.Y - value236.AbsolutePosition.Y))
            end
            function popout:Toggle()
                value236.Visible = not value236.Visible
            end
            function popout:GetSize()
                return value245.AbsoluteSize
            end

            value245:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()
                task.wait()
                popout:Resize()
            end)
            popout:Resize()
            setmetatable(popout, groupBoxApi)

            return popout
        end

        local newFn, newFn2, newFn3 = UDim2.new, ColorSequence.new, ColorSequenceKeypoint.new

        function uiLibrary:Notify(text5, duration)
            local textWidth3, textHeight3 = uiLibrary:GetTextBounds(text5, uiLibrary.Font, 14)

            textHeight3 = textHeight3 + 7

            local transparency = notificationStyle.Transparency
            local value261, value262, value263, value264 = value223()
            local value265 = value225:Clone()

            value265.BackgroundColor3 = value261
            value265.Name = charFn(256 - maxFn(1, #text5 % 256))
            value265.Size = newFn(0, 0, 0, textHeight3)
            value265.Transparency = transparency

            local value266 = value265.inner

            value266.BackgroundColor3 = value261
            value266.BorderColor3 = value263
            value266.Transparency = transparency

            local value267 = value266.inner

            value267.Transparency = transparency

            local uIGradient2 = value267.UIGradient

            uIGradient2.Color = newFn2({
                newFn3(0, uiLibrary:GetDarkerColor(value261)),
                newFn3(1, value261),
            })

            local value269 = value267.label

            value269.Text = text5
            value269.TextColor3 = value264

            local value270 = value265.bar

            value270.BackgroundColor3 = value262
            value270.Size = value219.BarSize[notificationStyle.BarSide] or newFn(0, 3, 1, 2)
            value270.Position = value219.BarPosition[notificationStyle.BarSide]
            value265.Parent = uiLibrary.NotificationArea

            pcall(value265.TweenSize, value265, UDim2.new(0, textWidth3 + 8 + 4, 0, textHeight3), 'Out', 'Quad', 0.4, true)
            task.spawn(function()
                wait(duration or 5)
                pcall(value265.TweenSize, value265, UDim2.new(0, 0, 0, textHeight3), 'Out', 'Quad', 0.4, true)
                wait(0.4)
                value265:Destroy()
            end)
        end
        function uiLibrary:IsVisible()
            return flag
        end

        uiLibrary:CreateEvent('VisibilityChanged')
    end
end

-- nick
-- nick.slider
-- nick
function Native.slider(captures)
    local config = captures[4]
    local frame = captures[3]
    local mouse = captures[6]
    local groupBoxApi = captures[11]
    local sharedObject = captures[2]
    local frame_8 = captures[8]
    local userInputService = captures[16]
    local textLabel = captures[10]
    local uiLibrary = captures[7]
    local depsObject = captures[0]
    local flagName = captures[13]
    local slider = captures[1]
    local tweenCell = captures[5]
    local frame_12 = captures[12]
    local valueBox = captures[15]
    local renderStepped = captures[17]
    local colorPickerObject = captures[14]
    local tweenService = captures[9]

    return function()
        local tween = tweenCell[3][tweenCell[2]]
        function slider:UpdateColors()
            frame.BackgroundColor3 = uiLibrary.AccentColor
            frame.BorderColor3 = uiLibrary.AccentColorDark
        end
        function slider:Display()
            local value022 = config.Suffix or ''

            if config.Compact then
                textLabel.Text = config.Text .. ': ' .. slider.Value .. value022
            elseif config.HideMax then
                textLabel.Text = string.format('%s', slider.Value .. value022)
            else
                textLabel.Text = string.format('%s/%s', slider.Value .. value022, slider.Max .. value022)
            end

            local value023 = uiLibrary:MapValue(slider.Value, slider.Min, slider.Max, 0, 1)

            if tween then
                tween:Cancel()
            end

            tween, tweenCell[3][tweenCell[2]] = tweenService:Create(frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(value023, 0, 1, 0),
            })

            tween:Play()

            frame_8.Visible = not (value023 == 1 or value023 == 0)
        end
        function slider:OnChanged(callback)
            table.insert(slider.ChangedFuncs, callback)
            callback(slider.Value)
        end

        local function value026(value027)
            if slider.Increment then
                local value028 = math.round(value027 / slider.Increment) * slider.Increment

                return tonumber(string.format('%.10f', value028))
            elseif slider.Rounding == 0 then
                return math.floor(value027)
            end

            return tonumber(string.format('%.' .. slider.Rounding .. 'f', value027))
        end

        function slider:GetValueFromXOffset(offsetX)
            return value026(uiLibrary:MapValue(offsetX, 0, slider.MaxSize, slider.Min, slider.Max)) + 0
        end
        function slider:Remove()
            for key, value in valueBox do
                value:Destroy()
            end

            colorPickerObject[flagName] = nil

            slider.HolderFrame:Destroy()
            table.clear(slider)
            depsObject:Resize()
        end
        function slider:SetValue(newValue)
            local value036 = tonumber(newValue)

            if not value036 then
                return
            end

            value036 = math.clamp(value036, slider.Min, slider.Max)
            slider.Value = value036

            slider:Display()
            uiLibrary:SafeCallback(slider.Callback, slider.Value)

            for key2, value2 in self.ChangedFuncs do
                uiLibrary:SafeCallback(value2, value036)
            end
        end
        function slider:AddSlider(value040, value041)
            return groupBoxApi.AddSlider(depsObject, value040, value041, slider)
        end

        frame_12.InputBegan:Connect(function(input)
            if uiLibrary.IsDragging then
                return
            end
            if input.UserInputType == Enum.UserInputType.MouseButton1 and not uiLibrary:MouseIsOverOpenedFrame() then
                local value043 = mouse.X
                local offset = frame.Size.X.Offset
                local value045 = value043 - (frame.AbsolutePosition.X + offset)

                while(userInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)) do

                    local value046 = mouse.X
                    local value047 = math.clamp(offset + (value046 - value043) + value045, 0, slider.MaxSize)
                    local value048 = slider:GetValueFromXOffset(value047)
                    local value5 = slider.Value

                    slider.Value = value048

                    slider:Display()

                    if value048 ~= value5 then
                        uiLibrary:SafeCallback(slider.Callback, slider.Value)

                        for key3, value3 in slider.ChangedFuncs do
                            uiLibrary:SafeCallback(value3, value048)
                        end
                    end

                    renderStepped:Wait()
                end

                uiLibrary:AttemptSave()
            end
            if input.UserInputType == Enum.UserInputType.Touch and not uiLibrary:MouseIsOverOpenedFrame() then
                local value052 = input.Position.X
                local offset2 = frame.Size.X.Offset
                local value054 = value052 - (frame.AbsolutePosition.X + offset2)
                local value055 = true
                local value056

                value056 = input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        value055 = false
                    end
                end)

                while value055 do

                    local value057 = input.Position.X
                    local value058 = math.clamp(offset2 + (value057 - value052) + value054, 0, slider.MaxSize)
                    local value059 = slider:GetValueFromXOffset(value058)
                    local value6 = slider.Value

                    slider.Value = value059

                    slider:Display()

                    if value059 ~= value6 then
                        uiLibrary:SafeCallback(slider.Callback, slider.Value)

                        for key4, value4 in slider.ChangedFuncs do
                            uiLibrary:SafeCallback(value4, value059)
                        end
                    end

                    renderStepped:Wait()
                end

                if value056 then
                    value056:Disconnect()
                end

                uiLibrary:AttemptSave()
            end
        end)

        if uiLibrary.FlagCopying then
            local value063 = uiLibrary:AddContextMenu(frame_12)

            value063:AddOption('Copy Flag', function()
                pcall(setclipboard, slider.Idx)
                task.wait()
                uiLibrary:Notify('Copied flag to clipboard!', 2)
                value063:Hide()
            end)
        end

        slider:Display()

        if not sharedObject then
            table.insert(valueBox, depsObject:AddBlank(config.BlankSize or 6))
            depsObject:Resize()
        end

        colorPickerObject[flagName] = slider
    end
end

-- nick
-- nick.tab
-- nick
function Native.tab(captures)
    local uiStroke = captures[15]
    local uiListLayout = captures[0]
    local flagName = captures[10]
    local sharedObject = captures[12]
    local scrollingFrame = captures[3]
    local tab = captures[2]
    local frame_13 = captures[13]
    local textLabel = captures[7]
    local frameInstanceCell = captures[4]
    local textLabelCell_11 = captures[11]
    local scrollingFrame_5 = captures[5]
    local uiLibrary = captures[1]
    local frame = captures[6]
    local frame_8 = captures[8]
    local frameInstanceCell_14 = captures[14]
    local textLabelCell = captures[9]

    return function()
        local frameInstance = frameInstanceCell[3][frameInstanceCell[2]]
        local textLabel_9 = textLabelCell[3][textLabelCell[2]]
        local textLabel_11 = textLabelCell_11[3][textLabelCell_11[2]]
        local frameInstance_14 = frameInstanceCell_14[3][frameInstanceCell_14[2]]
        if uiLibrary.IsMobile then
            local value018 = {
                Left = tick(),
                Right = tick(),
            }

            scrollingFrame:GetPropertyChangedSignal('CanvasPosition'):Connect(function()
                uiLibrary.CanDrag = false

                local value019 = tick()

                value018.Left = value019

                task.wait(0.15)

                if value018.Left == value019 then
                    uiLibrary.CanDrag = true
                end
            end)
            scrollingFrame_5:GetPropertyChangedSignal('CanvasPosition'):Connect(function()
                uiLibrary.CanDrag = false

                local value020 = tick()

                value018.Right = value020

                task.wait(0.15)

                if value018.Right == value020 then
                    uiLibrary.CanDrag = true
                end
            end)
        end

        for key, value in next, {scrollingFrame, scrollingFrame_5}do
            value:WaitForChild('UIListLayout'):GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
                value.CanvasSize = UDim2.fromOffset(0, value.UIListLayout.AbsoluteContentSize.Y)
            end)
        end

        function tab:Resize()
            if frameInstance.Visible == true then
                local value024 = 10

                for key2, value2 in next, frameInstance_14:GetChildren()do

                    if not value2:IsA('UIListLayout') and value2.Visible then
                        value024 = value024 + value2.Size.Y.Offset
                    end
                end

                frameInstance.Size = UDim2.new(1, -10, 0, value024)
                value024 = value024 + 10
                scrollingFrame.Position = UDim2.new(0, 7, 0, 7 + value024)
                scrollingFrame.Size = UDim2.new(0.5, -10, 1, -14 - value024)
                scrollingFrame_5.Position = UDim2.new(0.5, 5, 0, 7 + value024)
                scrollingFrame_5.Size = UDim2.new(0.5, -10, 1, -14 - value024)
            else
                scrollingFrame.Position = UDim2.new(0, 7, 0, 7)
                scrollingFrame.Size = UDim2.new(0.5, -10, 1, -14)
                scrollingFrame_5.Position = UDim2.new(0.5, 5, 0, 7)
                scrollingFrame_5.Size = UDim2.new(0.5, -10, 1, -14)
            end
        end
        function tab:UpdateWarningBox(value028)
            if typeof(value028.Visible) == 'boolean' then
                frameInstance.Visible = value028.Visible

                tab:Resize()
            end
            if typeof(value028.Title) == 'string' then
                textLabel_11.Text = value028.Title
            end
            if typeof(value028.Text) == 'string' then
                textLabel_9.Text = value028.Text

                local value029 = select(2, uiLibrary:GetTextBounds(value028.Text, uiLibrary.Font, 14, Vector2.new(textLabel_9.AbsoluteSize.X, math.huge)))

                textLabel_9.Size = UDim2.new(1, -4, 0, value029)

                tab:Resize()
            end
        end
        function tab:ShowTab()
            uiLibrary.ActiveTab = flagName

            for key3, value3 in next, sharedObject.Tabs do
                value3:HideTab()
            end

            uiLibrary.RegistryMap[frame].Properties.BackgroundColor3 = 'BackgroundColor'
            frame.BackgroundColor3 = uiLibrary.MainColor
            frame_13.Visible = true
            uiStroke.Color = Color3.fromRGB(0, 0, 0)
            textLabel.TextColor3 = uiLibrary.FontColor
            frame_8.Visible = true

            tab:Resize()
        end
        function tab:HideTab()
            frame.BackgroundColor3 = uiLibrary.BackgroundColor
            uiLibrary.RegistryMap[frame].Properties.BackgroundColor3 = 'MainColor'
            uiStroke.Color = Color3.fromRGB(25, 25, 25)
            textLabel.TextColor3 = uiLibrary:GetDarkerColor(uiLibrary.FontColor)
            frame_8.Visible = false
            frame_13.Visible = false
        end
        function tab:SetLayoutOrder(order)
            frame.LayoutOrder = order

            uiListLayout:ApplyLayout()
        end
        function tab:GetSides()
            return {
                Left = scrollingFrame,
                Right = scrollingFrame_5,
            }
        end
        function tab:AddLeftGroupbox(value038)
            return self:AddGroupbox({
                Side = 1,
                Name = value038,
            })
        end
        function tab:AddRightGroupbox(value040)
            return self:AddGroupbox({
                Side = 2,
                Name = value040,
            })
        end
        function tab:AddLeftTabbox(value042)
            return tab:AddTabbox({
                Name = value042,
                Side = 1,
            })
        end
        function tab:AddRightTabbox(value044)
            return tab:AddTabbox({
                Name = value044,
                Side = 2,
            })
        end
        function tab:Remove()
            table.clear(tab)
            frame_13:Destroy()
            frame:Destroy()

            sharedObject.Tabs[flagName] = nil
        end

        frame.InputBegan:Connect(function(input)
            if uiLibrary.IsDragging then
                return
            end
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                tab:ShowTab()
            end
        end)
        frameInstance:GetPropertyChangedSignal('Visible'):Connect(function()
            tab:Resize()
        end)

        uiLibrary.TotalTabs = uiLibrary.TotalTabs + 1

        if uiLibrary.TotalTabs == 1 then
            tab:ShowTab()
        end

        sharedObject.Tabs[flagName] = tab
    end
end

-- nick
-- nick.tabBox
-- nick
function Native.tabBox(captures)
    local frame_4 = captures[4]
    local tabContainer = captures[3]
    local sharedObject = captures[8]
    local frameClassCell = captures[1]
    local frame_7 = captures[7]
    local sideConfig = captures[6]
    local uiLibrary = captures[0]
    local frame = captures[2]
    local groupBoxApi = captures[5]
    local outlineColorNameCell = captures[9]

    return function()
        local frameClass = frameClassCell[3][frameClassCell[2]]
        local outlineColorName = outlineColorNameCell[3][outlineColorNameCell[2]]
        local tabboxes = sharedObject.Tabboxes

        function tabContainer:Remove()
            frame_4:Destroy()
            table.clear(tabContainer)

            tabboxes[sideConfig.Name or ''] = nil
        end
        function tabContainer:AddTab(value015, value016)
            local panel = {}
            local value018 = uiLibrary:Create(frameClass, {
                BackgroundColor3 = uiLibrary.MainColor,
                BorderSizePixel = 1,
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                Size = UDim2.new(0.5, 0, 1, 0),
                ZIndex = 6,
                Parent = frame,
            })
            local value019 = uiLibrary:Create(frameClass, {
                BackgroundColor3 = uiLibrary.AccentColor,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(1, 0, 0, 1),
                ZIndex = 8,
                Visible = value016 or false,
                Parent = value018,
            })

            uiLibrary:AddToRegistry(value019, {
                BackgroundColor3 = 'AccentColor',
            })

            local value020 = value016 and UDim2.new(1, -1, 1, 0) or UDim2.new(1, 0, 1, 0)
            local value021 = uiLibrary:Create(frameClass, {
                BackgroundTransparency = 0,
                BackgroundColor3 = uiLibrary.MainColor,
                BorderSizePixel = 1,
                BorderColor3 = uiLibrary.OutlineColor,
                BorderMode = Enum.BorderMode.Inset,
                Size = value020,
                ZIndex = 7,
                Parent = value018,
            })

            uiLibrary:AddToRegistry(value018, {
                BackgroundColor3 = 'MainColor',
            })
            uiLibrary:AddToRegistry(value021, {
                BackgroundColor3 = 'MainColor',
                BorderColor3 = outlineColorName,
            })

            local value022 = uiLibrary:CreateLabel({
                Size = UDim2.new(1, 0, 1, 0),
                TextSize = 14,
                Text = value015,
                TextXAlignment = Enum.TextXAlignment.Center,
                ZIndex = 7,
                Parent = value018,
            })
            local value023 = uiLibrary:Create(frameClass, {
                BackgroundColor3 = uiLibrary.BackgroundColor,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 1, 0),
                Size = UDim2.new(1, 0, 0, 1),
                Visible = false,
                ZIndex = 9,
                Parent = value018,
            })

            uiLibrary:AddToRegistry(value023, {
                BackgroundColor3 = 'BackgroundColor',
            })

            local value024 = uiLibrary:Create(frameClass, {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 4, 0, 20),
                Size = UDim2.new(1, -4, 1, -20),
                ZIndex = 1,
                Visible = false,
                Parent = frame_7,
            })

            uiLibrary:Create('UIListLayout', {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Parent = value024,
            })

            function panel:Show()
                for key, value in next, tabContainer.Tabs do
                    value:Hide()
                end

                value024.Visible = true
                value023.Visible = true
                value021.Visible = false
                value019.Visible = true
                value018.BackgroundColor3 = uiLibrary.BackgroundColor
                uiLibrary.RegistryMap[value018].Properties.BackgroundColor3 = 'BackgroundColor'

                panel:Resize()
            end
            function panel:Hide()
                value024.Visible = false
                value023.Visible = false
                value021.Visible = true
                value019.Visible = false
                value018.BackgroundColor3 = uiLibrary.MainColor
                uiLibrary.RegistryMap[value018].Properties.BackgroundColor3 = 'MainColor'
            end
            function panel:Resize()
                local value030 = 0

                for key2, value2 in next, tabContainer.Tabs do

                    value030 = value030 + 1
                end
                for key3, value3 in next, frame:GetChildren()do

                    if not value3:IsA('UIListLayout') then
                        value3.Size = UDim2.new(1 / value030, 0, 1, 0)
                    end
                end

                if not value024.Visible then
                    return
                end

                local value035 = 0

                for key4, value4 in next, panel.Container:GetChildren()do

                    if not value4:IsA('UIListLayout') and value4.Visible then
                        value035 = value035 + value4.Size.Y.Offset
                    end
                end

                frame_4.Size = UDim2.new(1, 0, 0, 20 + value035 + 2 + 2)
            end

            value018.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and not uiLibrary:MouseIsOverOpenedFrame() or input.UserInputType == Enum.UserInputType.Touch then
                    panel:Show()
                    panel:Resize()
                end
            end)

            panel.Container = value024
            tabContainer.Tabs[value015] = panel

            setmetatable(panel, groupBoxApi)
            panel:AddBlank(3)
            panel:Resize()

            if #frame:GetChildren() == 2 then
                panel:Show()
            end

            return panel
        end

        sharedObject.Tabboxes[sideConfig.Name or ''] = tabContainer
    end
end

-- nick
-- nick.textLabel
-- nick
function Native.textLabel(captures)
    local depsBox = captures[0]
    local autoResize = captures[5]
    local uiLibrary = captures[2]
    local object = captures[4]
    local labelMetatable = captures[1]
    local textLabel = captures[3]

    return function()
        function object:SetText(text)
            textLabel.Text = text

            if autoResize then
                local value010 = select(2, uiLibrary:GetTextBounds(text, uiLibrary.Font, 14, Vector2.new(textLabel.AbsoluteSize.X, math.huge)))

                textLabel.Size = UDim2.new(1, -4, 0, value010)
            end

            depsBox:Resize()
        end

        local value011 = {}

        function object:Remove()
            for key, value in value011 do
                value:Destroy()
            end

            textLabel:Destroy()
            table.clear(object)
            depsBox:Resize()
        end

        if not autoResize then
            setmetatable(object, labelMetatable)
        end

        table.insert(value011, depsBox:AddBlank(5))
        depsBox:Resize()
    end
end

-- nick
-- nick.themes
-- nick
function Native.themes(captures)
    local themeManager = captures[1]
    local outlineColorNameCell = captures[2]
    local colorPickerObject = captures[0]

    return function()
        local outlineColorName = outlineColorNameCell[3][outlineColorNameCell[2]]
        local value005 = cloneref or function(value006)
            return value006
        end
        local httpService = value005(game:GetService('HttpService'))
        local value008 = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request
        local value009 = getcustomasset or getsynasset

        do
            themeManager.Folder = ''
            themeManager.Library = nil
            themeManager.BuiltInThemes = {
                Default = {
                    1,
                    httpService:JSONDecode('{\n\t\t\t\t"FontColor":"ffffff",\n\t\t\t\t"MainColor":"131313",\n\t\t\t\t"AccentColor":"a2cdff",\n\t\t\t\t"BackgroundColor":"151515",\n\t\t\t\t"OutlineColor":"212121",\n\t\t\t\t"RiskColor":"ff7425",\n\n\t\t\t\t"ItemType":"Unnamed Enhancements - discord.gg/enhancements",\n\t\t\t\t"SwordColor":"ffffff",\n\t\t\t\t"SwordTransparency":"0",\n\t\t\t\t"SwordReflectance":"0",\n\t\t\t\t"SwordSpeed":"0.15",\n\t\t\t\t"SwordMaterial":"Neon",\n\n\t\t\t\t"Contrast":"0",\n\t\t\t\t"Saturation":"0",\n\t\t\t\t"Brightness":"0",\n\n\t\t\t\t"BackColor":"000000",\n\t\t\t\t"BlurSize":"15",\n\t\t\t\t"BackTransparency":"0.7"\n\t\t\t}'),
                },
                ['Tokyo Night'] = {
                    1,
                    httpService:JSONDecode('{\n\t\t\t\t"FontColor":"ffffff",\n\t\t\t\t"MainColor":"191925",\n\t\t\t\t"AccentColor":"6956cb",\n\t\t\t\t"BackgroundColor":"15151e",\n\t\t\t\t"OutlineColor":"272727",\n\t\t\t\t"RiskColor":"fb5f5f",\n\n\t\t\t\t"ItemType":"Unnamed Enhancements - discord.gg/enhancements",\n\t\t\t\t"SwordColor":"ffffff",\n\t\t\t\t"SwordTransparency":"0",\n\t\t\t\t"SwordReflectance":"0",\n\t\t\t\t"SwordSpeed":"0.15",\n\t\t\t\t"SwordMaterial":"Neon",\n\n\t\t\t\t"Contrast":"0",\n\t\t\t\t"Saturation":"0",\n\t\t\t\t"Brightness":"0",\n\n\n\t\t\t\t"BackColor":"000000",\n\t\t\t\t"BlurSize":"15",\n\t\t\t\t"BackTransparency":"0.7"\n\t\t\t}'),
                },
                Nord = {
                    1,
                    httpService:JSONDecode('{\n\t\t\t\t"FontColor":"ffffff",\n\t\t\t\t"MainColor":"1c1e20",\n\t\t\t\t"AccentColor":"9effc8",\n\t\t\t\t"BackgroundColor":"1c1e20",\n\t\t\t\t"OutlineColor":"24282d",\n\t\t\t\t"RiskColor":"ff7a00",\n\n\t\t\t\t"ItemType":"Unnamed Enhancements - discord.gg/enhancements",\n\t\t\t\t"SwordColor":"ffffff",\n\t\t\t\t"SwordTransparency":"0",\n\t\t\t\t"SwordReflectance":"0",\n\t\t\t\t"SwordSpeed":"0.15",\n\t\t\t\t"SwordMaterial":"Neon",\n\n\t\t\t\t"Contrast":"0",\n\t\t\t\t"Saturation":"0",\n\t\t\t\t"Brightness":"0",\n\n\n\t\t\t\t"BackColor":"000000",\n\t\t\t\t"BlurSize":"15",\n\t\t\t\t"BackTransparency":"0.7"\n\t\t\t}'),
                },
                Skeet = {
                    1,
                    httpService:JSONDecode('{\n\t\t\t\t"FontColor":"ffffff",\n\t\t\t\t"MainColor":"131313",\n\t\t\t\t"AccentColor":"81ff54",\n\t\t\t\t"BackgroundColor":"151515",\n\t\t\t\t"OutlineColor":"2a2a2a",\n\t\t\t\t"RiskColor":"e50000",\n\n\t\t\t\t"ItemType":"Unnamed Enhancements - discord.gg/enhancements",\n\t\t\t\t"SwordColor":"ffffff",\n\t\t\t\t"SwordTransparency":"0",\n\t\t\t\t"SwordReflectance":"0",\n\t\t\t\t"SwordSpeed":"0.15",\n\t\t\t\t"SwordMaterial":"Neon",\n\n\t\t\t\t"Contrast":"0",\n\t\t\t\t"Saturation":"0",\n\t\t\t\t"Brightness":"0",\n\n\n\t\t\t\t"BackColor":"000000",\n\t\t\t\t"BlurSize":"15",\n\t\t\t\t"BackTransparency":"0.7"\n\t\t\t}'),
                },
                Fatality = {
                    1,
                    httpService:JSONDecode('{\n\t\t\t\t"FontColor":"ffffff",\n\t\t\t\t"MainColor":"181537",\n\t\t\t\t"AccentColor":"ca0756",\n\t\t\t\t"BackgroundColor":"201c46",\n\t\t\t\t"OutlineColor":"39335a",\n\t\t\t\t"RiskColor":"e50000",\n\n\t\t\t\t"ItemType":"Unnamed Enhancements - discord.gg/enhancements",\n\t\t\t\t"SwordColor":"ffffff",\n\t\t\t\t"SwordTransparency":"0",\n\t\t\t\t"SwordReflectance":"0",\n\t\t\t\t"SwordSpeed":"0.15",\n\t\t\t\t"SwordMaterial":"Neon",\n\n\t\t\t\t"Contrast":"0",\n\t\t\t\t"Saturation":"0",\n\t\t\t\t"Brightness":"0",\n\n\n\t\t\t\t"BackColor":"000000",\n\t\t\t\t"BlurSize":"15",\n\t\t\t\t"BackTransparency":"0.7"\n\t\t\t}'),
                },
                Neverlose = {
                    1,
                    httpService:JSONDecode('{\n\t\t\t\t"FontColor":"ffffff",\n\t\t\t\t"MainColor":"0c1014",\n\t\t\t\t"AccentColor":"01a3f1",\n\t\t\t\t"BackgroundColor":"0c0f14",\n\t\t\t\t"OutlineColor":"191919",\n\t\t\t\t"RiskColor":"e50000",\n\n\t\t\t\t"ItemType":"Unnamed Enhancements - discord.gg/enhancements",\n\t\t\t\t"SwordColor":"ffffff",\n\t\t\t\t"SwordTransparency":"0",\n\t\t\t\t"SwordReflectance":"0",\n\t\t\t\t"SwordSpeed":"0.15",\n\t\t\t\t"SwordMaterial":"Neon",\n\n\t\t\t\t"Contrast":"0",\n\t\t\t\t"Saturation":"0",\n\t\t\t\t"Brightness":"0",\n\n\n\t\t\t\t"BackColor":"000000",\n\t\t\t\t"BlurSize":"15",\n\t\t\t\t"BackTransparency":"0.7"\n\t\t\t}'),
                },
                Onetap = {
                    1,
                    httpService:JSONDecode('{\n\t\t\t\t"FontColor":"ffffff",\n\t\t\t\t"MainColor":"1e1d22",\n\t\t\t\t"AccentColor":"faa614",\n\t\t\t\t"BackgroundColor":"18181c",\n\t\t\t\t"OutlineColor":"313033",\n\t\t\t\t"RiskColor":"e50000",\n\n\t\t\t\t"ItemType":"Unnamed Enhancements - discord.gg/enhancements",\n\t\t\t\t"SwordColor":"ffffff",\n\t\t\t\t"SwordTransparency":"0",\n\t\t\t\t"SwordReflectance":"0",\n\t\t\t\t"SwordSpeed":"0.15",\n\t\t\t\t"SwordMaterial":"Neon",\n\n\t\t\t\t"Contrast":"0",\n\t\t\t\t"Saturation":"0",\n\t\t\t\t"Brightness":"0",\n\n\n\t\t\t\t"BackColor":"000000",\n\t\t\t\t"BlurSize":"15",\n\t\t\t\t"BackTransparency":"0.7"\n\t\t\t}'),
                },
                Imgui = {
                    1,
                    httpService:JSONDecode('{\n\t\t\t\t"FontColor":"ffffff",\n\t\t\t\t"MainColor":"151617",\n\t\t\t\t"AccentColor":"406ba8",\n\t\t\t\t"BackgroundColor":"151617",\n\t\t\t\t"OutlineColor":"242424",\n\t\t\t\t"RiskColor":"e50000",\n\n\t\t\t\t"ItemType":"Unnamed Enhancements - discord.gg/enhancements",\n\t\t\t\t"SwordColor":"ffffff",\n\t\t\t\t"SwordTransparency":"0",\n\t\t\t\t"SwordReflectance":"0",\n\t\t\t\t"SwordSpeed":"0.15",\n\t\t\t\t"SwordMaterial":"Neon",\n\n\t\t\t\t"Contrast":"0",\n\t\t\t\t"Saturation":"0",\n\t\t\t\t"Brightness":"0",\n\n\n\t\t\t\t"BackColor":"000000",\n\t\t\t\t"BlurSize":"15",\n\t\t\t\t"BackTransparency":"0.7"\n\t\t\t}'),
                },
                Iniuria = {
                    1,
                    httpService:JSONDecode('{\n\t\t\t\t"FontColor":"ffffff",\n\t\t\t\t"MainColor":"1e1d1e",\n\t\t\t\t"AccentColor":"c41275",\n\t\t\t\t"BackgroundColor":"1e1d1e",\n\t\t\t\t"OutlineColor":"33252b",\n\t\t\t\t"RiskColor":"e50000",\n\n\t\t\t\t"ItemType":"Unnamed Enhancements - discord.gg/enhancements",\n\t\t\t\t"SwordColor":"ffffff",\n\t\t\t\t"SwordTransparency":"0",\n\t\t\t\t"SwordReflectance":"0",\n\t\t\t\t"SwordSpeed":"0.15",\n\t\t\t\t"SwordMaterial":"Neon",\n\n\t\t\t\t"Contrast":"0",\n\t\t\t\t"Saturation":"0",\n\t\t\t\t"Brightness":"0",\n\n\n\t\t\t\t"BackColor":"000000",\n\t\t\t\t"BlurSize":"15",\n\t\t\t\t"BackTransparency":"0.7"\n\t\t\t}'),
                },
                Primordial = {
                    1,
                    httpService:JSONDecode('{\n\t\t\t\t"FontColor":"ffffff",\n\t\t\t\t"MainColor":"181818",\n\t\t\t\t"AccentColor":"d7a6b0",\n\t\t\t\t"BackgroundColor":"1f1f1f",\n\t\t\t\t"OutlineColor":"2a2a2a",\n\t\t\t\t"RiskColor":"e50000",\n\n\t\t\t\t"ItemType":"Unnamed Enhancements - discord.gg/enhancements",\n\t\t\t\t"SwordColor":"ffffff",\n\t\t\t\t"SwordTransparency":"0",\n\t\t\t\t"SwordReflectance":"0",\n\t\t\t\t"SwordSpeed":"0.15",\n\t\t\t\t"SwordMaterial":"Neon",\n\n\t\t\t\t"Contrast":"0",\n\t\t\t\t"Saturation":"0",\n\t\t\t\t"Brightness":"0",\n\n\n\t\t\t\t"BackColor":"000000",\n\t\t\t\t"BlurSize":"15",\n\t\t\t\t"BackTransparency":"0.7"\n\t\t\t}'),
                },
                Monolith = {
                    1,
                    httpService:JSONDecode('{\n\t\t\t\t"FontColor":"ffffff",\n\t\t\t\t"MainColor":"141115",\n\t\t\t\t"AccentColor":"c707bd",\n\t\t\t\t"BackgroundColor":"171417",\n\t\t\t\t"OutlineColor":"272427",\n\t\t\t\t"RiskColor":"e50000",\n\n\t\t\t\t"ItemType":"Unnamed Enhancements - discord.gg/enhancements",\n\t\t\t\t"SwordColor":"ffffff",\n\t\t\t\t"SwordTransparency":"0",\n\t\t\t\t"SwordReflectance":"0",\n\t\t\t\t"SwordSpeed":"0.15",\n\t\t\t\t"SwordMaterial":"Neon",\n\n\t\t\t\t"Contrast":"0",\n\t\t\t\t"Saturation":"0",\n\t\t\t\t"Brightness":"0",\n\n\n\t\t\t\t"BackColor":"000000",\n\t\t\t\t"BlurSize":"15",\n\t\t\t\t"BackTransparency":"0.7"\n\t\t\t}'),
                },
                V3rmillion = {
                    1,
                    httpService:JSONDecode('{\n\t\t\t\t"FontColor":"ffffff",\n\t\t\t\t"MainColor":"202020",\n\t\t\t\t"AccentColor":"cd1818",\n\t\t\t\t"BackgroundColor":"202020",\n\t\t\t\t"OutlineColor":"2a2a2a",\n\t\t\t\t"RiskColor":"e50000",\n\n\t\t\t\t"ItemType":"Unnamed Enhancements - discord.gg/enhancements",\n\t\t\t\t"SwordColor":"ffffff",\n\t\t\t\t"SwordTransparency":"0",\n\t\t\t\t"SwordReflectance":"0",\n\t\t\t\t"SwordSpeed":"0.15",\n\t\t\t\t"SwordMaterial":"Neon",\n\n\t\t\t\t"Contrast":"0",\n\t\t\t\t"Saturation":"0",\n\t\t\t\t"Brightness":"0",\n\n\n\t\t\t\t"BackColor":"000000",\n\t\t\t\t"BlurSize":"15",\n\t\t\t\t"BackTransparency":"0.7"\n\t\t\t}'),
                },
                Dark = {
                    1,
                    httpService:JSONDecode('{\n\t\t\t\t"FontColor":"ffffff",\n\t\t\t\t"MainColor":"0a0a0a",\n\t\t\t\t"AccentColor":"5945ff",\n\t\t\t\t"BackgroundColor":"0a0a0a",\n\t\t\t\t"OutlineColor":"171717",\n\t\t\t\t"RiskColor":"e50000",\n\n\t\t\t\t"ItemType":"Unnamed Enhancements - discord.gg/enhancements",\n\t\t\t\t"SwordColor":"ffffff",\n\t\t\t\t"SwordTransparency":"0",\n\t\t\t\t"SwordReflectance":"0",\n\t\t\t\t"SwordSpeed":"0.15",\n\t\t\t\t"SwordMaterial":"Neon",\n\n\t\t\t\t"Contrast":"0",\n\t\t\t\t"Saturation":"0",\n\t\t\t\t"Brightness":"0",\n\n\n\t\t\t\t"BackColor":"000000",\n\t\t\t\t"BlurSize":"15",\n\t\t\t\t"BackTransparency":"0.7"\n\t\t\t}'),
                },
            }

            function themeManager:ApplyTheme(themeName)
                if not themeName then
                    return
                end

                local value012 = self:GetCustomTheme(themeName)
                local value013 = value012 or self.BuiltInThemes[themeName]

                if not value013 then
                    return
                end
                if self.Library.InnerVideoBackground ~= nil then
                    self.Library.InnerVideoBackground.Visible = false
                end

                local value014 = value013[2]

                for key, value in next, value012 or value014 do

                    if key:find('Color') then
                        self.Library[key] = Color3.fromHex(value)

                        if colorPickerObject[key] then
                            colorPickerObject[key]:SetValueRGB(Color3.fromHex(value))
                        end
                    else
                        self.Library[key] = value

                        if colorPickerObject[key] then
                            colorPickerObject[key]:SetValue(value)
                        end
                    end
                end

                self:ThemeUpdate()
            end
            function themeManager:ThemeUpdate()
                if self.Library.InnerVideoBackground ~= nil then
                    self.Library.InnerVideoBackground.Visible = false
                end

                local value018 = {
                    'Contrast',
                    'Saturation',
                    'Brightness',
                    'BlurSize',
                    'FontColor',
                    'RiskColor',
                    'MainColor',
                    'AccentColor',
                    'BackgroundColor',
                    outlineColorName,
                    'SwordColor',
                    'ItemType',
                    'BackTransparency',
                    'BackColor',
                    'SwordTransparency',
                    'SwordReflectance',
                    'SwordMaterial',
                    'SwordSpeed',
                }

                for key2, value2 in next, value018 do

                    if colorPickerObject and colorPickerObject[value2] then
                        self.Library[value2] = colorPickerObject[value2].Value
                    end
                end

                self.Library.AccentColorDark = self.Library:GetDarkerColor(self.Library.AccentColor)

                self.Library:UpdateColorsUsingRegistry()
            end
            function themeManager:LoadDefault()
                local value022 = 'Default'
                local value023 = isfile(self.Folder .. '/themes/default.txt') and readfile(self.Folder .. '/themes/default.txt')
                local value024 = true

                if value023 then
                    if self.BuiltInThemes[value023] then
                        value022 = value023
                    elseif self:GetCustomTheme(value023) then
                        value022 = value023
                        value024 = false
                    end
                elseif self.BuiltInThemes[self.DefaultTheme] then
                    value022 = self.DefaultTheme
                end
                if value024 then
                    colorPickerObject.ThemeManager_ThemeList:SetValue(value022)
                else
                    self:ApplyTheme(value022)
                end
            end
            function themeManager:SaveDefault(themeName2)
                writefile(self.Folder .. '/themes/default.txt', themeName2)
            end
            function themeManager:Delete(fileName)
                if not fileName then
                    return false, 'no config file is selected'
                end

                local value029 = self.Folder .. '/themes/' .. fileName

                if not isfile(value029) then
                    return false, 'invalid file'
                end

                local success, resultOrError = pcall(delfile, value029)

                if not success then
                    return false, 'delete file error'
                end

                return true
            end
            function themeManager:GetCustomTheme(fileName2)
                if not fileName2 then
                    return
                end

                local value034 = self.Folder .. '/themes/' .. fileName2

                if not isfile(value034) then
                    return nil
                end

                local value035 = readfile(value034)
                local success2, resultOrError2 = pcall(httpService.JSONDecode, httpService, value035)

                if not success2 then
                    return nil
                end

                return resultOrError2
            end
            function themeManager:SaveCustomTheme(fileName3)
                if not fileName3 or fileName3:gsub(' ', '') == '' then
                    return self.Library:Notify('Invalid file name for theme (empty)', 3)
                end

                local value040 = {}
                local value041 = {
                    'Contrast',
                    'Saturation',
                    'Brightness',
                    'BlurSize',
                    'FontColor',
                    'RiskColor',
                    'MainColor',
                    'AccentColor',
                    'BackgroundColor',
                    outlineColorName,
                    'ItemType',
                    'SwordColor',
                    'BackTransparency',
                    'BackColor',
                    'SwordTransparency',
                    'SwordReflectance',
                    'SwordMaterial',
                    'SwordSpeed',
                }

                for key3, value3 in next, value041 do

                    if colorPickerObject[value3] then
                        if not value3:find('Color') then
                            value040[value3] = colorPickerObject[value3].Value
                        else
                            value040[value3] = colorPickerObject[value3].Value:ToHex()
                        end
                    end
                end

                writefile(self.Folder .. '/themes/' .. fileName3, httpService:JSONEncode(value040))
            end
            function themeManager:ReloadCustomThemes()
                local value045 = listfiles(self.Folder .. '/themes')
                local value046 = {}

                for index = 1, #value045 do

                    local value048 = value045[index]

                    if value048:sub(-5) == '.json' then
                        local matchStart = value048:find('.json', 1, true)
                        local value050 = value048:sub(matchStart, matchStart)

                        while value050 ~= '/' and value050 ~= '\\' and value050 ~= '' do

                            matchStart = matchStart - 1
                            value050 = value048:sub(matchStart, matchStart)
                        end

                        if value050 == '/' or value050 == '\\' then
                            table.insert(value046, value048:sub(matchStart + 1))
                        end
                    end
                end

                return value046
            end
            function themeManager:SetLibrary(library)
                self.Library = library
            end
            function themeManager:BuildFolderTree()
                local value054 = {}
                local value055 = self.Folder:split('/')

                for index2 = 1, #value055 do

                    value054[#value054 + 1] = table.concat(value055, '/', 1, index2)
                end

                table.insert(value054, self.Folder .. '/themes')

                for index3 = 1, #value054 do

                    local value058 = value054[index3]

                    if not isfolder(value058) then
                        makefolder(value058)
                    end
                end
            end
            function themeManager:SetFolder(folder)
                self.Folder = folder

                self:BuildFolderTree()
            end
            function themeManager:CreateGroupBox(tab)
                assert(self.Library, 'Must set ThemeManager.Library first!')

                return tab:AddLeftTabbox()
            end
            function themeManager:ApplyToTab(tab2)
                assert(self.Library, 'Must set ThemeManager.Library first!')

                local value065 = self:CreateGroupBox(tab2)

                self:CreateThemeManager(value065)
            end
            function themeManager:ApplyToGroupbox(groupbox)
                assert(self.Library, 'Must set ThemeManager.Library first!')
                self:CreateThemeManager(groupbox)
            end
        end

        getgenv().ThemeManager = themeManager
    end
end

-- nick
-- nick.toggle
-- nick
function Native.toggle(captures)
    local frame_10 = captures[10]
    local depsObject = captures[1]
    local frame_6 = captures[6]
    local frame_12 = captures[12]
    local config = captures[11]
    local outlineColorNameCell = captures[13]
    local toggleObject_9 = captures[9]
    local valueBox = captures[7]
    local flagName = captures[5]
    local frame = captures[2]
    local uiLibrary = captures[3]
    local frame_4 = captures[4]
    local addonApi = captures[14]
    local textLabel = captures[8]
    local toggleObject = captures[0]

    return function()
        local outlineColorName = outlineColorNameCell[3][outlineColorNameCell[2]]
        function toggleObject:Display()
            frame.BackgroundColor3 = toggleObject.Value and uiLibrary.AccentColor or uiLibrary.MainColor
            frame.BorderColor3 = toggleObject.Value and uiLibrary.AccentColorDark or uiLibrary.OutlineColor
            uiLibrary.RegistryMap[frame].Properties.BackgroundColor3 = toggleObject.Value and 'AccentColor' or 'MainColor'
            uiLibrary.RegistryMap[frame].Properties.BorderColor3 = toggleObject.Value and 'AccentColorDark' or outlineColorName
        end

        toggleObject.UpdateColors = toggleObject.Display

        function toggleObject:OnChanged(callback)
            table.insert(toggleObject.ChangedFuncs, callback)
            callback(toggleObject.Value)
        end
        function toggleObject:SetValue(newValue)
            if toggleObject.SettingValue then
                return
            end

            toggleObject.SettingValue = true
            newValue = not not newValue
            toggleObject.Value = newValue

            toggleObject:Display()

            for key, value in next, toggleObject.Addons do

                if value.Type == 'KeyPicker' and value.SyncToggleState then
                    value.Toggled = newValue

                    value:Update()
                end
            end

            uiLibrary:SafeCallback(toggleObject.Callback, newValue)

            for key2, value2 in toggleObject.ChangedFuncs do
                uiLibrary:SafeCallback(value2, newValue)
            end

            uiLibrary:UpdateDependencyBoxes()

            toggleObject.SettingValue = false
        end
        function toggleObject:SetVisible(visible)
            toggleObject.Visible = visible
            frame_4.Visible = toggleObject.Visible

            if Blank then
                Blank.Visible = toggleObject.Visible
            end

            depsObject:Resize()
        end
        function toggleObject:Remove()
            for key3, value3 in valueBox do
                value3:Destroy()
            end

            toggleObject_9[flagName] = nil

            frame_6:Destroy()
            table.clear(toggleObject)
            depsObject:Resize()
        end

        frame_10.InputBegan:Connect(function(input)
            if uiLibrary.IsDragging then
                return
            end
            if input.UserInputType == Enum.UserInputType.MouseButton1 and not uiLibrary:MouseIsOverOpenedFrame() or input.UserInputType == Enum.UserInputType.Touch then
                toggleObject:SetValue(not toggleObject.Value)
                uiLibrary:AttemptSave()
            end
        end)

        if uiLibrary.FlagCopying then
            local value032 = uiLibrary:AddContextMenu(frame_4, frame_10)

            value032:AddOption('Copy Flag', function()
                pcall(setclipboard, toggleObject.Idx)
                task.wait()
                uiLibrary:Notify('Copied flag to clipboard!', 2)
                value032:Hide()
            end)
        end
        if toggleObject.Risky then
            uiLibrary:RemoveFromRegistry(textLabel)

            textLabel.TextColor3 = uiLibrary.RiskColor

            uiLibrary:AddToRegistry(textLabel, {
                TextColor3 = 'RiskColor',
            })
        end

        toggleObject:Display()
        table.insert(valueBox, depsObject:AddBlank(config.BlankSize or 7))
        depsObject:Resize()

        toggleObject.ColorPickerCount = 0
        toggleObject.ToggleRegion = frame_10
        toggleObject.TextLabel = textLabel
        toggleObject.Container = frame_12

        setmetatable(toggleObject, addonApi)

        toggleObject_9[flagName] = toggleObject

        uiLibrary:UpdateDependencyBoxes()
    end
end

-- nick
-- nick.valueCallbacks
-- nick
function Native.valueCallbacks(captures)
    local flagRegistry = captures[3]
    local outerFrame = captures[10]
    local valueObject = captures[0]
    local flagName = captures[5]
    local children = captures[7]
    local holderFrame = captures[9]
    local textBox = captures[1]
    local uiLibrary = captures[4]
    local textService = captures[8]
    local config = captures[2]
    local depsObject = captures[6]

    return function()
        function valueObject:SetValue(newValue)
            if config.MaxLength and #newValue > config.MaxLength then
                newValue = newValue:sub(1, config.MaxLength)
            end
            if valueObject.Numeric then
                if not tonumber(newValue) and newValue:len() > 0 then
                    newValue = valueObject.Value
                end
            end

            valueObject.Value = newValue
            textBox.Text = newValue

            uiLibrary:SafeCallback(valueObject.Callback, valueObject.Value)
            uiLibrary:SafeCallback(valueObject.Changed, valueObject.Value)
        end
        function valueObject:Remove()
            for key, value in children do
                value:Destroy()
            end

            flagRegistry[flagName] = nil

            holderFrame:Destroy()
            table.clear(valueObject)
            depsObject:Resize()
        end

        if valueObject.Finished then
            textBox.FocusLost:Connect(function(value018)
                valueObject:SetValue(textBox.Text)
                uiLibrary:AttemptSave()
            end)
        else
            textBox:GetPropertyChangedSignal('Text'):Connect(function()
                valueObject:SetValue(textBox.Text)
                uiLibrary:AttemptSave()
            end)
        end

        local function value019()
            local value020 = 2
            local value021 = outerFrame.AbsoluteSize.X

            if not textBox:IsFocused() or textBox.TextBounds.X <= value021 - 2 * value020 then
                textBox.Position = UDim2.new(0, value020, 0, 0)
            else
                local cursorPosition = textBox.CursorPosition

                if cursorPosition ~= -1 then
                    local value023 = string.sub(textBox.Text, 1, cursorPosition - 1)
                    local value024 = textService:GetTextSize(value023, textBox.TextSize, textBox.Font, Vector2.new(math.huge, math.huge)).X
                    local value025 = textBox.Position.X.Offset + value024

                    if value025 < value020 then
                        textBox.Position = UDim2.fromOffset(value020 - value024, 0)
                    elseif value025 > value021 - value020 - 1 then
                        textBox.Position = UDim2.fromOffset(value021 - value024 - value020 - 1, 0)
                    end
                end
            end
        end

        task.spawn(value019)
        textBox:GetPropertyChangedSignal('Text'):Connect(value019)
        textBox:GetPropertyChangedSignal('CursorPosition'):Connect(value019)
        textBox.FocusLost:Connect(value019)
        textBox.Focused:Connect(value019)

        if uiLibrary.FlagCopying then
            local value026 = uiLibrary:AddContextMenu(holderFrame)

            value026:AddOption('Copy Flag', function()
                pcall(setclipboard, valueObject.Idx)
                task.wait()
                uiLibrary:Notify('Copied flag to clipboard!', 2)
                value026:Hide()
            end)
        end

        uiLibrary:AddToRegistry(textBox, {
            TextColor3 = 'FontColor',
        })

        function valueObject:OnChanged(callback)
            valueObject.Changed = callback

            callback(valueObject.Value)
        end

        table.insert(children, depsObject:AddBlank(5))
        depsObject:Resize()

        flagRegistry[flagName] = valueObject
    end
end
