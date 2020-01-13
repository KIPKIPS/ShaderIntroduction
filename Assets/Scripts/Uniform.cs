using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Uniform : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        GetComponent<Renderer>().material.SetVector("_SecondColor",new Vector4(1,0,0,1));
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
