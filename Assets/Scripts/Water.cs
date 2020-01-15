using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Water : MonoBehaviour {
    public float anti_aliasing;

    public float speed;
    // Start is called before the first frame update
    void Start() {
        anti_aliasing = 0;
        speed = 5;
    }

    // Update is called once per frame
    void Update()
    {
        GetComponent<Renderer>().material.SetFloat("anti_aliasing",(float)(anti_aliasing/6.28));
        GetComponent<Renderer>().material.SetFloat("speed",speed);
    }
}
