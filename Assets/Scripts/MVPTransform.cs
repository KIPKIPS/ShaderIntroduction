using System;
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
        Matrix4x4 rotateMatrix = new Matrix4x4();
        rotateMatrix[0, 0] = Mathf.Cos(Time.realtimeSinceStartup);//根据微分时间片更改旋转角度
        rotateMatrix[0, 2] = Mathf.Sin(Time.realtimeSinceStartup);
        rotateMatrix[1, 1] = 1;
        rotateMatrix[2, 0] = -Mathf.Sin(Time.realtimeSinceStartup);
        rotateMatrix[3, 3] = 1;

        //缩放矩阵
        Matrix4x4 scaleMatrix=new Matrix4x4();
        scaleMatrix[0, 0] = Mathf.Sin(Time.realtimeSinceStartup)/4+0.5f;
        scaleMatrix[1, 1] = Mathf.Cos(Time.realtimeSinceStartup)/8+0.5f;
        scaleMatrix[2, 2] = Mathf.Sin(Time.realtimeSinceStartup)/6+0.5f;
        scaleMatrix[3, 3] = 1;

        //相机投影矩阵 * 世界-->相机矩阵 * 物体自身的位置信息矩阵-->世界矩阵
        Matrix4x4 mvp = Camera.main.projectionMatrix * Camera.main.worldToCameraMatrix * transform.localToWorldMatrix ;//*RM
        GetComponent<Renderer>().material.SetMatrix("mvp",mvp);//获取Shader文件中mvp矩阵的值
        //GetComponent<Renderer>().material.SetMatrix("rotateMatrix", rotateMatrix);//获取Shader文件中rm矩阵的值
        GetComponent<Renderer>().material.SetMatrix("scaleMatrix", scaleMatrix);
    }
}
