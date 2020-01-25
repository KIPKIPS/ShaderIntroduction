using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScaleManager : MonoBehaviour {
    public float scale;
    // Start is called before the first frame update
    void Start() {
        scale = 0;
    }

    // Update is called once per frame
    void Update() {
        this.GetComponent<Renderer>().material.SetFloat("_Scale",scale);
    }
}
