// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Shader/FragmentShader_02"
{
    Properties{
        _MainColor("MainColor",Color)=(1,1,1,1)
        _SpecularColor("SpecularColor",Color)=(1,1,1,1)
        _Shininess("Shininess",range(1,64))=8
    }
    SubShader
    {
        //阴影投射器通道
        Pass{
            Tags { "LightMode"="ShadowCaster"}
        }
        //着色通道
        Pass{
        	Tags { "LightMode"="ForwardBase" }//光照模式
            CGPROGRAM
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "lighting.cginc"
            #include "UnityShaderVariables.cginc"//unity自带变量
            #pragma vertex Vert
            #pragma fragment Frag  

            float4 _SpecularColor; 
            float _Shininess;
            float4 _MainColor;        
            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION ;
                float3 normal:TEXCOORD1;
                float4 vertex:COLOR;
            };
            //顶点着色器
            VertToFrag Vert(appdata_base v){
                VertToFrag vtf;
                float4x4 unityMVP=UNITY_MATRIX_MVP;
                vtf.pos=mul(unityMVP,v.vertex);       
                vtf.normal=v.normal;
                vtf.vertex =v.vertex;
                return vtf;
            }
            //片元着色器
            float4 Frag(VertToFrag vtf):COLOR{

                float3 N=normalize(UnityObjectToWorldNormal(vtf.normal));//模型的法向量
                float3 L=normalize(WorldSpaceLightDir(vtf.vertex));
                //Ambient color环境光
                float4 color=UNITY_LIGHTMODEL_AMBIENT;

                //Diffuse color漫反射
                float diffuseScale=saturate(dot(N,L));//将顶点指向光源向量和法线向量的点积值限定在0-1之间
                color+=_LightColor0*_MainColor*diffuseScale;//_lightingColor0是光源的颜色,_MianColor是材质本身的颜色,漫反射的颜色值既包含自身材质颜色又包含光源的颜色值
                //Specular color镜面高光
                float3 V=normalize(WorldSpaceViewDir(vtf.vertex));
                float3 R=2*dot(N,L)*N-L;
                float specularScale=saturate(dot(V,R));
                color.rgb+=_SpecularColor*pow(specularScale,_Shininess);
                //Compute 4 points lighting
                color.rgb+=Shade4PointLights(unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
                                  unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, 
                                  unity_LightColor[3].rgb,unity_4LightAtten0,mul(unity_ObjectToWorld,vtf.vertex).xyz,UnityObjectToWorldNormal(vtf.normal)
                                  );
                return color;
            }
            ENDCG
        }
    }
    Fallback "Diffuse"
}
