Shader "Shader/VertexShader_13"
{
    SubShader
    {
        Pass{
        	Tags { "LightMode"="ForwardBase" }//光照模式
            CGPROGRAM
            #include "UnityCG.cginc"
            #include "lighting.cginc"
            #pragma vertex Vert
            #pragma fragment Frag  

            //appdata_base包含:顶点坐标vertex,顶点法线normal,第一组纹理坐标TEXCOORD0
            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION ;
                float4 color:COLOR;
                float3 normal:NORMAL;
            };
            //顶点程序
            VertToFrag Vert(appdata_base v){
                VertToFrag vtf;
                float4x4 unityMVP=UNITY_MATRIX_MVP;
                vtf.pos=mul(unityMVP,v.vertex);//计算模型顶点坐标在世界空间的坐标
                vtf.normal=v.normal;
                return vtf;
            }

            
            //将光照计算放在片元程序中会优化渲染的结果
            float4 Frag(VertToFrag vtf):COLOR{
                float3 N=normalize(vtf.normal);//模型的法向量
                float3 L=normalize(_WorldSpaceLightPos0);
                N=normalize(mul(float4(N,0),unity_WorldToObject).xyz);

                float NDotL=saturate(dot(N,L));//将顶点指向光源向量和法线向量的点积值限定在0-1之间
                vtf.color=_LightColor0*NDotL;//_lightingColor0是光源的颜色
                return vtf.color+UNITY_LIGHTMODEL_AMBIENT;//漫反射+环境光
            }
            ENDCG
        }
    }
}
