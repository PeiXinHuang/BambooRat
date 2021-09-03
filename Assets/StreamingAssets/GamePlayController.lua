cs = CS.UnityEngine

require "GamePlayModel"
require "GamePlayView"

-- 游戏运行控制器
GamePlayController = {
    isGamePlaying = false, -- 是否正在运行游戏
}
 

function GamePlayController:Init(_view,_model)
    local gamePlayCT = {}             
    setmetatable(gamePlayCT,{__index = GamePlayController})  
    self.gamePlayView = _view
    self.gamePlayModel = _model;
    return gamePlayCT
end



-- 游戏循环
function GamePlayController:GamePlayUpdate()
    self:GamePlay()
end

-- 游戏开始
function GamePlayController:GamePlayStart()

    -- 绑定按钮事件
    self.gamePlayView.uiStartBtn:GetComponent("Button").onClick:AddListener(
        function()
            self:BeginPlayGame()
        end
    )
    self.gamePlayView.uiContinueBtn:GetComponent("Button").onClick:AddListener(
    function()
        self:ContinuePlayGame()
    end
    )
    self.gamePlayView.uiContinueBtn:GetComponent("Button").onClick:AddListener(
    function()
        cs.Application.Quit()
    end
    )

    

    -- 绑定选择按钮
    self.gamePlayView.uiSelectBtn1:GetComponent("Button").onClick:AddListener(
        function()
            self.gamePlayModel:SetStoryByName("story2")
            self.gamePlayView:SetSelectPanel(false)
        end
    )
    self.gamePlayView.uiSelectBtn2:GetComponent("Button").onClick:AddListener(
        function()
            self.gamePlayModel:SetStoryByName("story3")
            self.gamePlayView:SetSelectPanel(false)
        end
    )


end


-- 开始游戏
function GamePlayController:BeginPlayGame()

    self.gamePlayView:SetStartPanel(false)
    self.gamePlayView:SetGamePlayPanel(true)

    self.gamePlayModel:ResetCurrentPage()
    self.gamePlayView:SetGameView(self.gamePlayModel.currentPage)


    self.isGamePlaying = true
end

-- 游戏继续
function GamePlayController:ContinuePlayGame()
  
    
    -- 读取数据
    if(cs.PlayerPrefs.HasKey("currentPage")) then
        self.gamePlayModel:SetCurrentPage(cs.PlayerPrefs.GetInt("currentPage"))
    else 
        self.gamePlayModel:SetCurrentPage(1)
    end

    if(cs.PlayerPrefs.HasKey("storyName")) then
        self.gamePlayModel:SetStoryByName(cs.PlayerPrefs.GetString("storyName"))
    else
        self.gamePlayModel:SetStoryByName("story1")
    end

    self.gamePlayModel:ReadStoryData()
    self.gamePlayView:SetStartPanel(false)
    self.gamePlayView:SetGamePlayPanel(true)
    self.gamePlayView:SetGameView(self.gamePlayModel.currentPage)

    self.isGamePlaying = true
end


-- 游戏运行
function GamePlayController:GamePlay()
    if(self.isGamePlaying) then
        if(cs.Input.GetKeyDown(cs.KeyCode.LeftControl) or cs.Input.GetKeyDown(cs.KeyCode.RightControl) 
            or cs.Input.GetMouseButtonDown(0)) then

            self.gamePlayModel:AddCurrentPage()
            self.gamePlayView:SetGameView(self.gamePlayModel.currentPage)

        elseif(cs.Input.GetKeyDown(cs.KeyCode.S)) then -- 保存数据
            print("数据保存成功")
            cs.PlayerPrefs.SetString("storyName", self.gamePlayModel.storyName) -- 保存当前故事
            cs.PlayerPrefs.SetInt("currentPage",self.gamePlayModel.currentPage) -- 保存页数

        end

    end


end

function GamePlayController:SaveData()
    
end



-- 游戏运行数据控制器
gamePlayModel =  GamePlayModel:Init()

-- 游戏运行窗口控制器
gamePlayView = GamePlayView:Init(gamePlayModel)

-- 创建游戏运行控制器对象
gamePlayController = GamePlayController:Init(gamePlayView,gamePlayModel);



