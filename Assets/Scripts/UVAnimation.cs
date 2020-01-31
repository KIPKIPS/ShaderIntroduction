using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UIElements;

public class UVAnimation : MonoBehaviour {
    public int width;
    public int height;
    public int fps;

    public int currentIndex;

    // Start is called before the first frame update
    IEnumerator Start() {
        Material mat = GetComponent<Renderer>().material;
        float scale_x = 1.0f / width;
        float scale_y = 1.0f / height;
        while (true) {
            float offset_x = currentIndex % width * scale_x;
            float offset_y = currentIndex / height *scale_y;
            mat.SetTextureOffset("_MainTex", new Vector2(offset_x, offset_y));
            mat.SetTextureScale("_MainTex", new Vector2(scale_x, scale_y));
            yield return new WaitForSeconds(1.0f / fps);
            currentIndex = (++currentIndex) %(width * height);
            
        }
    }

    // Update is called once per frame
    void Update() {
        
    }
}
