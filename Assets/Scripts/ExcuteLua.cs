using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using XLua;




[CSharpCallLua]
public interface GamePlayController
{
    void GamePlayStart();
    void GamePlayUpdate();
}



public class ExcuteLua : MonoBehaviour
{

    public GamePlayController gamePlayController; //游戏进行控制器，内部由Lua实现
  

    LuaEnv env;


    void Awake()
    {  
        env = new LuaEnv();
        
        //设置读取lua文件路径
        env.AddLoader(CustomLoader);

        //读取lua文件
        env.DoString("require 'Setting'");
        env.DoString("require 'GamePlayController'");


        //获取lua中的游戏控制器
        gamePlayController = env.Global.Get<GamePlayController>("gamePlayController");

   
   

    }





    //该回调返回值是一个byte数组，如果为空表示该loader找不到，否则返回lua文件的内容
    //通过自定义的loader加载lua文件
    public byte[] CustomLoader(ref string filepath)
    {
        //print(Application.streamingAssetsPath);//目录路径
        //加载本地的lua文件  也可以加载服务器的lua文件
        string s = Application.streamingAssetsPath + "/" + filepath + ".lua";

        return System.Text.Encoding.UTF8.GetBytes(File.ReadAllText(s));
    }

    private void Start()
    {
        gamePlayController.GamePlayStart();
    }

    private void Update()
    {
     
        gamePlayController.GamePlayUpdate();
    }


    private void OnDestroy()
    {
        //env.Dispose();
    }

    
}


