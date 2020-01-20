Shader "Shader/VertexShader_12"
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

         
            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION ;
                float4 color:COLOR;
            };
            VertToFrag Vert(appdata_base v){
                VertToFrag vtf;
                float4x4 unityMVP=UNITY_MATRIX_MVP;
                vtf.pos=mul(unityMVP,v.vertex);
                float3 N=normalize(v.normal);//模型的法向量
                float3 L=normalize(_WorldSpaceLightPos0);
                //将法线向量和光照向量转移到一个坐标系下
                //1.光照向量转移到模型空间坐标系
                //L=normalize(mul(unity_WorldToObject,float4(L,0)).xyz);

                //2.法线向量转移到世界空间坐标系
                //N=mul(unity_ObjectToWorld,float4(N,0)).xyz;//unity_ObjectToWorld的逆矩阵unity_WorldToObject
                //交换mul函数里面矩阵和向量的位置,得到的结果为原来结果的转置矩阵
                N=normalize(mul(float4(N,0),unity_WorldToObject).xyz);

                float NDotL=saturate(dot(N,L));//将顶点指向光源向量和法线向量的点积值限定在0-1之间
                vtf.color=_LightColor0*NDotL;//_lightingColor0是光源的颜色
                return vtf;
            }
            float4 Frag(VertToFrag vtf):COLOR{
                return vtf.color+UNITY_LIGHTMODEL_AMBIENT;//漫反射+环境光
            }
            ENDCG
        }
    }
}
