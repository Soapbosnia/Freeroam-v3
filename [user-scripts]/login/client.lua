local login = {}
local register = {}
local forgot = {}
--
local x, y = guiGetScreenSize()
local oX, oY = 1920, 1080

-------------
-- Methods --
-------------
local function toggleSection(section, bool)
    if (section == 'login') then
        target = login
    elseif (section == 'register') then
        target = register
    elseif (section == 'forgot') then
        target = forgot
    end

    for key, element in pairs(target) do
        guiSetVisible(element, bool)
    end
end

-------------------
-- Login Section --
-------------------
login.usernameLabel = guiCreateLabel(858, 372, 205, 18, "Username", false)
guiSetFont(login.usernameLabel, "default-bold-small")
guiLabelSetHorizontalAlign(login.usernameLabel, "center", false)
guiLabelSetVerticalAlign(login.usernameLabel, "center")
login.passwordLabel = guiCreateLabel(858, 423, 205, 18, "Password", false)
guiSetFont(login.passwordLabel, "default-bold-small")
guiLabelSetHorizontalAlign(login.passwordLabel, "center", false)
guiLabelSetVerticalAlign(login.passwordLabel, "center")
login.usernameInput = guiCreateEdit(868, 390, 185, 23, "", false)
login.passwordInput = guiCreateEdit(868, 441, 185, 23, "", false)
login.errorLabel = guiCreateLabel(726, 464, 468, 19, "", false)
guiSetFont(login.errorLabel, "default-bold-small")
guiLabelSetHorizontalAlign(login.errorLabel, "center", false)
guiLabelSetVerticalAlign(login.errorLabel, "center")
login.guestButton = guiCreateButton(803, 487, 99, 42, "Play as Guest", false)
guiSetFont(login.guestButton, "default-bold-small")
login.loginButton = guiCreateButton(912, 487, 99, 42, "Login", false)
guiSetFont(login.loginButton, "default-bold-small")
login.registerButton = guiCreateButton(1021, 487, 99, 42, "Register", false)
guiSetFont(login.registerButton, "default-bold-small")

local function onGuestClick()
    if (button == "left") then
        triggerServerEvent("playAsGuest", localPlayer)
    end
end
addEventHandler("onClientGUIClick", login.guestButton, onGuestClick)

local function onLoginClick(button)
    if (button == "left") then
        local username = guiGetText(login.usernameInput)
        local password = guiGetText(login.passwordInput)

        if (username ~= "" and password ~= "") then
            triggerServerEvent("attemptLogin", localPlayer, username, password)
        end
    end
end
addEventHandler("onClientGUIClick", login.loginButton, onLoginClick)

local function onRegisterClick(button)
    if (button == "left") then
        toggleSection("login", false)
        toggleSection("register", true)
    end
end
addEventHandler("onClientGUIClick", login.registerButton, onRegisterClick)

----------------------
-- Register Section --
----------------------
register.usernameLabel = guiCreateLabel(858, 372, 205, 18, "Username", false)
guiSetFont(register.usernameLabel, "default-bold-small")
guiLabelSetHorizontalAlign(register.usernameLabel, "center", false)
guiLabelSetVerticalAlign(register.usernameLabel, "center")
register.passwordLabel = guiCreateLabel(858, 423, 205, 18, "Password", false)
guiSetFont(register.passwordLabel, "default-bold-small")
guiLabelSetHorizontalAlign(register.passwordLabel, "center", false)
guiLabelSetVerticalAlign(register.passwordLabel, "center")
register.confirmLabel = guiCreateLabel(858, 474, 205, 18, "Confirm Password", false)
guiLabelSetHorizontalAlign(register.confirmLabel, "center", false)
guiLabelSetVerticalAlign(register.confirmLabel, "center")
register.emailLabel = guiCreateLabel(858, 525, 205, 18, "Email", false)
guiLabelSetHorizontalAlign(register.emailLabel, "center", false)
guiLabelSetVerticalAlign(register.emailLabel, "center")
register.nicknameLabel = guiCreateLabel(858, 576, 205, 18, "Nickname", false)
guiLabelSetHorizontalAlign(register.nicknameLabel, "center", false)
guiLabelSetVerticalAlign(register.nicknameLabel, "center")
register.usernameInput = guiCreateEdit(868, 390, 185, 23, "", false)
register.passwordInput = guiCreateEdit(868, 441, 185, 23, "", false)
register.confirmPasswordInput = guiCreateEdit(868, 492, 185, 23, "", false)
register.emailInput = guiCreateEdit(868, 543, 185, 23, "", false)
register.nicknameInput = guiCreateEdit(868, 594, 185, 23, "", false)
register.errorLabel = guiCreateLabel(727, 617, 468, 19, "", false)
guiSetFont(register.errorLabel, "default-bold-small")
guiLabelSetHorizontalAlign(register.errorLabel, "center", false)
guiLabelSetVerticalAlign(register.errorLabel, "center")
register.cancelButton = guiCreateButton(858, 646, 99, 42, "Cancel", false)
guiSetFont(register.cancelButton, "default-bold-small")
register.registerButton = guiCreateButton(964, 646, 99, 42, "Register", false)
guiSetFont(register.registerButton, "default-bold-small")

local function onCancelClick(button)
    if (button == "left") then
        toggleSection("register", false)
        toggleSection("login", true)
    end
end
addEventHandler("onClientGUIClick", register.cancelButton, onCancelClick)

local function onRegisterButtonClick(button)
    if (button == "left") then
        local username = guiGetText(register.usernameInput)
        local password = guiGetText(register.passwordInput)
        local confirmPassword = guiGetText(register.confirmPasswordInput)
        local email = guiGetText(register.emailInput)
        local nickname = guiGetText(register.nicknameInput)

        if (username ~= "" and password ~= "" and confirmPassword ~= "" and email ~= "" and nickname ~= "") then
            if (password == confirmPassword) then
                triggerServerEvent("attemptRegister", localPlayer, username, password, email, nickname)
            end
        end
    end
end
addEventHandler("onClientGUIClick", register.registerButton, onRegisterButtonClick)

------------
-- Banner --
------------
local function renderServerBanner()
    dxDrawText("Freeroam", 502/oX*x, 206/oY*y, 1419/oX*x, 372/oY*y, tocolor(255, 255, 255, 255), 3.00/oY*y, "bankgothic", "center", "center", false, false, false, false, false)
end

---------------
-- Main Code --
---------------
local function onStart()
    if (not getElementData(localPlayer, "logged-in")) then
        fadeCamera(false)
        toggleSection("login", true)
        showCursor(true)
        addEventHandler("onClientRender", root, renderServerBanner)
    end
end
addEvent("showLoginPanel", true)
addEventHandler("showLoginPanel", root, onStart)
addEventHandler("onClientResourceStart", resourceRoot, onStart)
toggleSection("login", false)
toggleSection("register", false)

local function hideLoginSections()
    toggleSection("login", false)
    toggleSection("register", false)
    showCursor(false)
    removeEventHandler("onClientRender", root, renderServerBanner)
end
addEvent("hideLoginSections", true)
addEventHandler("hideLoginSections", root, hideLoginSections)