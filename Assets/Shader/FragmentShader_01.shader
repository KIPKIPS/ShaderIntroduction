// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Shader/FragmentShader_01"
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
                float3 normal:TEXCOORD1;
                float4 vertex:COLOR;
            };

            VertToFrag Vert(appdata_base v){
                VertToFrag vtf;
                float4x4 unityMVP=UNITY_MATRIX_MVP;
                vtf.pos=mul(unityMVP,v.vertex);       
                vtf.normal=v.normal;
                vtf.vertex =v.vertex;
                return vtf;
            }

            float4 Frag(VertToFrag vtf):COLOR{
                float3 N=normalize(UnityObjectToWorldNormal(vtf.normal));//模型的法向量
                float3 L=normalize(WorldSpaceLightDir(vtf.vertex));
                //Ambient color环境光
                float4 color=UNITY_LIGHTMODEL_AMBIENT;
            
                //Diffuse color漫反射
                float diffuseScale=saturate(dot(N,L));//将顶点指向光源向量和法线向量的点积值限定在0-1之间
                color+=_LightColor0*diffuseScale;//_lightingColor0是光源的颜色
                //Specular color镜面高光
                return color;
            }
            ENDCG
        }
    }
}
