GamePlayView = {
    
    gamePlayModel, 

    uiLoader, -- UI
    uiStartPanel, -- 开始界面
    uiGamePlayPanel, -- 游戏运行面板

    uiStartBtn, -- 游戏开始按钮
    uiContinueBtn, -- 游戏继续按钮
    uiExitBtn, -- 游戏退出按钮

    uiGamePlayImage, -- 游戏运行界面图片
    uiGamePlayName, -- 游戏运行界面名称
    uiGamePlaySay, -- 游戏运行界面对话
    uiGamePlayCharacterGirl, -- 游戏运行界面女孩
    uiGamePlayCharacterBoy, -- 游戏运行界面男孩
    uiSelectPanel, -- 选择界面
    uiSelectBtn1, -- 选择按钮
    uiSelectBtn2 -- 选择按钮

}


function GamePlayView:Init(_model)
    local gamePlayView = {}             
    setmetatable(gamePlayView,{__index = GamePlayView})  
    self.gamePlayModel = _model;
    gamePlayView:InitUI()
    return gamePlayView
end

-- 初始化ui对象
function GamePlayView:InitUI()

    self.uiLoader = cs.GameObject.Find("SceneManager"):GetComponent("UILoader")



    self.uiStartBtn = self.uiLoader:GetUIByName("uiStartBtn")
    self.uiContinueBtn = self.uiLoader:GetUIByName("uiContinueBtn")
    self.uiExitBtn = self.uiLoader:GetUIByName("uiExitBtn")

    self.uiStartPanel =self.uiLoader:GetUIByName("uiStartPanel")
    self.uiGamePlayPanel = self.uiLoader:GetUIByName("uiGamePlayPanel")

    self.uiGamePlayImage = self.uiLoader:GetUIByName("uiGamePlayImage")
    self.uiGamePlayName = self.uiLoader:GetUIByName("uiGamePlayName")
    self.uiGamePlaySay = self.uiLoader:GetUIByName("uiGamePlaySay")
    self.uiGamePlayCharacterGirl = self.uiLoader:GetUIByName("uiGamePlayCharacterGirl")
    self.uiGamePlayCharacterBoy = self.uiLoader:GetUIByName("uiGamePlayCharacterBoy")
    self.uiSelectPanel = self.uiLoader:GetUIByName("uiSelectPanel")
    self.uiSelectBtn1 = self.uiLoader:GetUIByName("uiSelectBtn1")
    self.uiSelectBtn2 = self.uiLoader:GetUIByName("uiSelectBtn2")
    

end

-- 设置游戏界面,pageIndex--当前页数
function GamePlayView:SetGameView(pageIndex)

    if(self.gamePlayModel.isSelect == false) then
        -- 设置背景
        local prefab = cs.Resources.Load("Pictures/Background/"..self.gamePlayModel.currentBackgroundIndex);
        local texture2d = cs.Object.Instantiate(prefab) 
        local sprite = cs.Sprite.Create(texture2d,cs.Rect(0,0,texture2d.width,texture2d.height),cs.Vector2.zero)
        self.uiGamePlayImage:GetComponent("Image").sprite = sprite;

        -- 设置对话人名称
        self.uiGamePlayName:GetComponent("Text").text = self.gamePlayModel.currentName

        -- 设置对话内容
        self.uiGamePlaySay:GetComponent("Text").text = self.gamePlayModel.currentSay

        -- 设置女孩图片
        local girlPrefab = cs.Resources.Load("Pictures/Character/Mouse/"..self.gamePlayModel.currentGirlIndex);
        local girlTexture2d = cs.Object.Instantiate(girlPrefab)
        local girlSprite = cs.Sprite.Create(girlTexture2d,cs.Rect(0,0,girlTexture2d.width,girlTexture2d.height),cs.Vector2.zero)
        self.uiGamePlayCharacterGirl:GetComponent("Image").sprite = girlSprite;



        -- 设置男孩图片
        local boyPrefab = cs.Resources.Load("Pictures/Character/Mouse/"..self.gamePlayModel.currentBoyIndex);
        local boyTexture2d = cs.Object.Instantiate(boyPrefab)
        local boySprite = cs.Sprite.Create(boyTexture2d,cs.Rect(0,0,boyTexture2d.width,boyTexture2d.height),cs.Vector2.zero)
        self.uiGamePlayCharacterBoy:GetComponent("Image").sprite = boySprite;
    elseif(self.gamePlayModel.isSelect == true and self.gamePlayModel.hasSelect == false) then
        self:SetSelectPanel(true)
    end

end

-- 显示选择面板
function GamePlayView:SetSelectPanel(isShow)
    self.uiSelectPanel:SetActive(isShow)
end

-- 设置游戏开始面板
function GamePlayView:SetStartPanel(isShow)
    self.uiStartPanel:SetActive(isShow)
end

-- 设置游戏窗口面板
function GamePlayView:SetGamePlayPanel(isShow)
    self.uiGamePlayPanel:SetActive(isShow)
end

