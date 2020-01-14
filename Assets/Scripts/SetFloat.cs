using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SetFloat : MonoBehaviour
{
    private float dis=-1;
    private float r=0.1f;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update() {
        dis += Time.deltaTime*0.1f;
        GetComponent<Renderer>().material.SetFloat("dis",dis);
        GetComponent<Renderer>().material.SetFloat("r", r);
    }
}
