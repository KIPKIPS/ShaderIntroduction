Shader "Shader/FragmentShader_06"
{
    Properties{
        _Maintex("MainTex",2D)=""{}
        _U("U",range(0.01,0.99))=0.5
        _V("V",range(0.01,0.99))=0.5
    }
    
    SubShader
    {
        Pass{
            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex Vert
            #pragma fragment Frag 

            sampler2D _Maintex;
            float _U;
            float _V;
            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION; 
            };
            //顶点着色器
            VertToFrag Vert(appdata_base v){
                VertToFrag vtf;
                vtf.pos=UnityObjectToClipPos(v.vertex);
                return vtf;
            }
            //片元着色器
            float4 Frag(VertToFrag IN):COLOR{
                float4 color=tex2D(_Maintex,float2(_U,_V));//采样函数,第一个参数为采样的贴图,第二个为float2的位置参数
                return color;
            }
            ENDCG
        }
        
    }
}
