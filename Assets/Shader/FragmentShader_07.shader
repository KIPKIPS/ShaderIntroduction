// Upgrade NOTE: replaced tex2D unity_Lightmap with UNITY_SAMPLE_TEX2D

// Upgrade NOTE: commented out 'float4 unity_LightmapST', a built-in variable
// Upgrade NOTE: commented out 'sampler2D unity_Lightmap', a built-in variable

//UV学习Shader
Shader "Shader/FragmentShader_07"
{
    Properties{
        _MainTex("MainTex",2D)=""{}
        //_U("U",range(0.01,0.99))=0.5
        //_V("V",range(0.01,0.99))=0.5
    }
    
    SubShader
    {
        Pass{
            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex Vert
            #pragma fragment Frag 

            sampler2D _MainTex;
            // sampler2D unity_Lightmap;//光照贴图
            float4 _MainTex_ST;//一旦声明Unity会自动将tiling和offset的值传递进来 前两个值描述平铺量,后两个描述偏移量
            // float4 unity_LightmapST;

            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION; 
                float2 uv:TEXCOORD0; 
                float2 uv2:TEXCOORD1;
            };
            //顶点着色器
            VertToFrag Vert(appdata_full v){
                VertToFrag vtf;
                vtf.pos=UnityObjectToClipPos(v.vertex);
                //vtf.uv=v.texcoord.xy*_MainTex_ST.xy+_MainTex_ST.zw;//可以用宏来代替这个计算

                vtf.uv=TRANSFORM_TEX(v.texcoord.xy,_MainTex);
                vtf.uv2=v.texcoord1.xy*unity_LightmapST.xy+unity_LightmapST.zw;
                return vtf;
            }
            //片元着色器
            float4 Frag(VertToFrag IN):COLOR{
                //float4 color=tex2D(_Maintex,float2(_U,_V));//采样函数,第一个参数为采样的贴图,第二个为float2的位置参数
                float4 color=tex2D(_MainTex,IN.uv);
                float4 lmtex = UNITY_SAMPLE_TEX2D(unity_Lightmap, IN.uv2);//Lightmap的采样函数
                float3 lm = DecodeLightmap (lmtex);
                color.rgb*=lm*2;
                return color;
            }
            ENDCG
        }
        
    }
}
