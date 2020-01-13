using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Uniform : MonoBehaviour {
    public Vector4 v;
    // Start is called before the first frame update
    void Start()
    {
        v=new Vector4(1,0,0,1);
        
    }

    // Update is called once per frame
    void Update()
    {
        GetComponent<Renderer>().material.SetVector("_SecondColor", v);
    }
}
