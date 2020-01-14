using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MVPTransform : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update() {
        //绕Y轴做旋转矩阵RM
        //对RM矩阵赋值
        Matrix4x4 RM=new Matrix4x4();
        RM[0, 0] = Mathf.Cos(Time.realtimeSinceStartup);
        RM[0, 2] = Mathf.Sin(Time.realtimeSinceStartup);
        RM[1, 1] = 1;
        RM[2, 0] = -Mathf.Sin(Time.realtimeSinceStartup);
        RM[3, 3] = 1;
        //相机投影矩阵 * 世界-->相机矩阵 * 物体自身的位置信息矩阵-->世界矩阵
        Matrix4x4 mvp = Camera.main.projectionMatrix * Camera.main.worldToCameraMatrix * transform.localToWorldMatrix ;//*RM
        GetComponent<Renderer>().material.SetMatrix("mvp",mvp);//获取Shader文件中mvp矩阵的值
        GetComponent<Renderer>().material.SetMatrix("rm", RM);//获取Shader文件中rm矩阵的值
    }
}
