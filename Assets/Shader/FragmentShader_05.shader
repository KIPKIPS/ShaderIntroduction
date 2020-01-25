Shader "Shader/FragmentShader_05"
{
    Properties{
        _MainColor("MainColor",Color)=(0,1,0,1)
        _SecondColor("SecondColor",Color)=(0,0,1,1)
        _Scale("Scale",range(-0.5,0.5))=0.0
    }
    
    SubShader
    {
        Pass{
            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex Vert
            #pragma fragment Frag 

            float4 _MainColor;
            float4 _SecondColor;
            uniform float _Scale=0;
            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION; 
                float4 color:COLOR;
                float4 vertex :TEXCOORD0; 
            };
            //顶点着色器
            VertToFrag Vert(appdata_base v){
                VertToFrag vtf;
                vtf.pos=UnityObjectToClipPos(v.vertex);
                vtf.vertex=v.vertex;
                return vtf;
            }
            //片元着色器
            float4 Frag(VertToFrag IN):COLOR{
                if(IN.vertex.y<=_Scale){
                    return _MainColor;
                }
                else{
                    return _SecondColor;
                }
                //return IN.color;
            }
            ENDCG
        }
        
    }
}
