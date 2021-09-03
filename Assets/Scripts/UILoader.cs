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
    public uiStruct[] uiStruct; //���ڴӲ�����崫��ui
    public Dictionary<string, GameObject> uiDir = new Dictionary<string, GameObject>(); //��uiд�뵽�ֵ�֮��

    private void Awake()
    {
        //��ʼ��UI�ֵ�
        for (int i = 0; i < uiStruct.Length; i++)
        {
            uiDir.Add(uiStruct[i].uiName, uiStruct[i].uiObj);
        }
    }

    /// <summary>
    /// ����UI������UI����
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
