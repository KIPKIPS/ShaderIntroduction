//UV动画Shader
Shader "Shader/FragmentShader_08"
{
    Properties{
        _MainTex("MainTex",2D)=""{}
    }
    
    SubShader
    {
        Pass{
            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex Vert
            #pragma fragment Frag 

            sampler2D _MainTex;
            float4 _MainTex_ST;

            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION; 
                float2 uv:TEXCOORD0; 
            };
            //顶点着色器
            VertToFrag Vert(appdata_full v){
                VertToFrag vtf;
                vtf.pos=UnityObjectToClipPos(v.vertex);
                vtf.uv=TRANSFORM_TEX(v.texcoord.xy,_MainTex);
                return vtf;
            }
            //片元着色器
            float4 Frag(VertToFrag IN):COLOR{
                float4 color=tex2D(_MainTex,IN.uv);
                return color;
            }
            ENDCG
        }
        
    }
}
