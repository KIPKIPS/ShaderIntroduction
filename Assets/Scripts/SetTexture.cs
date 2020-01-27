using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SetTexture : MonoBehaviour {
    public bool play_x;
    public bool play_y;
    public bool rotate;
    private Material material;
    //xy方向上的平铺量
    private float tiling_x;
    private float tiling_y;
    //xy方向上的偏移量
    private float offset_x;
    private float offset_y;
    // Start is called before the first frame update
    void Start() {
        //初始化数值
        tiling_x = 1;
        tiling_y = 1;
        offset_x = 0;
        offset_y = 0;
        rotate = false;
        play_x = false;//控制UV动画的播放
        play_y = false;
        material = GetComponent<Renderer>().material;
    }

    // Update is called once per frame
    void Update() {
        if (rotate) {
            //transform.Rotate(0,Time.deltaTime*60,0);
            transform.Rotate(new Vector3(0,1,0),Time.deltaTime*60);
        }
        if (play_x) {
            offset_x += Time.deltaTime;
            
        }

        if (play_y) {
            offset_y += Time.deltaTime;
        }

        //tiling_x = Mathf.Abs(Mathf.Sin(Time.time));
        //tiling_y = Mathf.Abs(Mathf.Sin(Time.time));
        //material.SetFloat("tiling_x",tiling_x);
        //material.SetFloat("tiling_y", tiling_y);
        //material.SetFloat("offset_x", offset_x);
        //material.SetFloat("offset_y", offset_y);
        material.SetVector("_MainTex_ST",new Vector4(tiling_x, tiling_y,offset_x,offset_y));

    }
}
