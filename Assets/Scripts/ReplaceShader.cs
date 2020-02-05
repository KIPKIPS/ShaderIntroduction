using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ReplaceShader : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        Camera.main.SetReplacementShader(Shader.Find("Shader/FragmentShader_13_Replacement"), "rendertype");
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
