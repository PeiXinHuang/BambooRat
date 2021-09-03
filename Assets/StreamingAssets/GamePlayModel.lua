require "Story"



GamePlayModel = {
    storyName = "story1",
    storyData = story1, -- 当前故事
    currentPage = 1,  -- 当前读写页
    currentBackgroundIndex = 1, -- 当前背景图片编号
    currentName = "", -- 当前对话人名称
    currentSay = "", -- 当前对话人说话内容
    currentGirlIndex = 0, --当前女孩图片编号
    currentBoyIndex = 0, -- 当前男孩图片编号
    isSelect = false, -- 是否是在显示界面
    hasSelect = false -- 是否已经选择过
}


function GamePlayModel:Init() 
    local gamePlayModel = {}             
    setmetatable(gamePlayModel,{__index = GamePlayModel})

    return gamePlayModel
end



-- 翻页
function GamePlayModel:AddCurrentPage()
    if(self.currentPage < #self.storyData and self.isSelect == false) then
        self.currentPage = self.currentPage + 1 -- 页数加一
        self:ReadStoryData()
    elseif(self.hasSelect == false) then
        self.isSelect = true
        self.currentPage = 0 -- 页数重置
    end
end

-- 跳转到对应页
function GamePlayModel:SetCurrentPage(_currentPage)
    self.currentPage = _currentPage
end

-- 重置页
function GamePlayModel:ResetCurrentPage()
    self.currentPage = 1
    self:ReadStoryData()
end

-- 从story中读取当前的数据
function GamePlayModel:ReadStoryData()


    self.currentBackgroundIndex = self.storyData[self.currentPage].backgroundIndex -- 获取背景编号
    self.currentName = self.storyData[self.currentPage].name -- 获取当前名称
    self.currentSay = self.storyData[self.currentPage].say -- 获取当前对话内容
    self.currentBoyIndex = self.storyData[self.currentPage].boyIndex -- 获取当前男孩编号
    self.currentGirlIndex = self.storyData[self.currentPage].girlIndex -- 获取当前女孩编号
end

-- 设置当前读到的故事
function GamePlayModel:SetStoryByName(_name)

    if(_name == "story1") then
        self.storyName = _name
        self.storyData = story1
        self.isSelect = false
        self.hasSelect = false
    elseif(_name == "story2") then
        self.storyData = story2
        self.storyName = _name
        self.isSelect = false
        self.hasSelect = true
    elseif(_name == "story3") then
        self.storyData = story3
        self.storyName = _name
        self.isSelect = false
        self.hasSelect = true
    else
        print("没有选择正确的故事")
    end
end
