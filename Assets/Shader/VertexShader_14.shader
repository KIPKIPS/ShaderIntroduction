// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Shader/VertexShader_14"
{
    Properties{
        _SpecularColor("SpecularColor",Color)=(1,1,1,1)
        _Shininess("Shininess",range(1,64))=8
    }
    SubShader
    {
        Pass{
        	Tags { "LightMode"="ForwardBase" }//光照模式
            CGPROGRAM
            #include "UnityCG.cginc"
            #include "lighting.cginc"
            #include "UnityShaderVariables.cginc"//unity自带变量
            #pragma vertex Vert
            #pragma fragment Frag  

            float4 _SpecularColor; 
            float _Shininess;        
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
                //N=normalize(mul(float4(N,0),unity_WorldToObject).xyz);
                N=UnityObjectToWorldNormal(N);//将法向量变换到世界空间坐标系

                //Diffuse color
                float NDotL=saturate(dot(N,L));//将顶点指向光源向量和法线向量的点积值限定在0-1之间
                vtf.color=_LightColor0*NDotL;//_lightingColor0是光源的颜色

                //Specular color
                float3 I=-WorldSpaceLightDir(v.vertex);//计算入射光向量,世界空间的顶点坐标-光源坐标
                float3 R=reflect(I,N);
                float3 V=WorldSpaceViewDir(v.vertex);//顶点指向摄像机的位置,摄像机位置-顶点坐标
                R=normalize(R);
                V=normalize(V);
                float specularScale=pow(saturate(dot(R,V)),_Shininess);
                vtf.color.rgb+=_LightColor0*specularScale;
                return vtf;
            }

            float4 Frag(VertToFrag vtf):COLOR{
                return vtf.color+UNITY_LIGHTMODEL_AMBIENT;//漫反射+环境光
            }
            ENDCG
        }
    }
}
