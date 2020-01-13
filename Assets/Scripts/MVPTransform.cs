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
        //相机投影矩阵 * 世界-->相机矩阵 * 物体自身的位置信息矩阵-->世界矩阵
        Matrix4x4 mvp = Camera.main.projectionMatrix * Camera.main.worldToCameraMatrix * transform.localToWorldMatrix ;
        GetComponent<Renderer>().material.SetMatrix("mvp",mvp);
    }
}
