using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public struct uiStruct
{
    public string uiName;
    public GameObject uiObj;
    
}

public class UILoader : MonoBehaviour
{
    public uiStruct[] uiStruct; //用于从参数面板传入ui
    public Dictionary<string, GameObject> uiDir = new Dictionary<string, GameObject>(); //将ui写入到字典之中

    private void Awake()
    {
        //初始化UI字典
        for (int i = 0; i < uiStruct.Length; i++)
        {
            uiDir.Add(uiStruct[i].uiName, uiStruct[i].uiObj);
        }
    }

    /// <summary>
    /// 根据UI名查找UI对象
    /// </summary>
    public GameObject GetUIByName(string name)
    {
        if (!uiDir.ContainsKey(name))
        {
            Debug.LogError("Key: " + name + " is not exit");
            return null;
        }
        return uiDir[name];
    }


}
