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

    public GamePlayController gamePlayController; //��Ϸ���п��������ڲ���Luaʵ��
  

    LuaEnv env;


    void Awake()
    {  
        env = new LuaEnv();
        
        //���ö�ȡlua�ļ�·��
        env.AddLoader(CustomLoader);

        //��ȡlua�ļ�
        env.DoString("require 'Setting'");
        env.DoString("require 'GamePlayController'");


        //��ȡlua�е���Ϸ������
        gamePlayController = env.Global.Get<GamePlayController>("gamePlayController");

   
   

    }





    //�ûص�����ֵ��һ��byte���飬���Ϊ�ձ�ʾ��loader�Ҳ��������򷵻�lua�ļ�������
    //ͨ���Զ����loader����lua�ļ�
    public byte[] CustomLoader(ref string filepath)
    {
        //print(Application.streamingAssetsPath);//Ŀ¼·��
        //���ر��ص�lua�ļ�  Ҳ���Լ��ط�������lua�ļ�
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


