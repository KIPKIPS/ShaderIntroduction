//UV学习Shader
Shader "Shader/FragmentShader_06"
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
            float4 _MainTex_ST;//一旦声明Unity会自动将tiling和offset的值传递进来 前两个值描述平铺量,后两个描述偏移量
            //float _U;
            //float _V;
            // float tiling_x=1;
            // float tiling_y=1;
            // float offset_x=0;
            // float offset_y=0;


            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION; 
                float2 uv:TEXCOORD0; 
            };
            //顶点着色器
            VertToFrag Vert(appdata_base v){
                VertToFrag vtf;
                vtf.pos=UnityObjectToClipPos(v.vertex);
                //vtf.uv=v.texcoord.xy;//取UV参数的前两个值
                // vtf.uv.x*=tiling_x;
                // vtf.uv.y*=tiling_y;
                // vtf.uv.x+=offset_x;
                // vtf.uv.y+=offset_y;
                //vtf.uv=v.texcoord.xy*_MainTex_ST.xy+_MainTex_ST.zw;//可以用宏来代替这个计算
                vtf.uv=TRANSFORM_TEX(v.texcoord.xy,_MainTex);
                return vtf;
            }
            //片元着色器
            float4 Frag(VertToFrag IN):COLOR{
                //float4 color=tex2D(_Maintex,float2(_U,_V));//采样函数,第一个参数为采样的贴图,第二个为float2的位置参数
                float4 color=tex2D(_MainTex,IN.uv);
                return color;
            }
            ENDCG
        }
        
    }
}
