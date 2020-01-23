// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Shader/FragmentShader_04"
{
    Properties{
        _Scale("Scale",range(1,8))=2
        _Outer("Outer",range(0,1))=0.2
        _MainColor("MainColor",Color)=(1,1,1,1)
    }
    
    SubShader
    {
        Tags { "queue"="transparent" }
        //着色通道
        Pass{
        	blend srcalpha oneminussrcalpha
            zwrite off//关闭写入深度
            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex Vert
            #pragma fragment Frag 
 
            float _Scale;
            float _Outer;
            float4 _MainColor;
            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION ;
                float3 normal:TEXCOORD0;
                float4 vertex :TEXCOORD1; 
            };
            //顶点着色器
            VertToFrag Vert(appdata_base v){
                v.vertex.xyz+=v.normal*_Outer;
                VertToFrag vtf;
                float4x4 mvp=UNITY_MATRIX_MVP;
                vtf.pos=mul(mvp,v.vertex);
                vtf.normal=v.normal;
                vtf.vertex =v.vertex;
                return vtf;
            }
            //片元着色器
            float4 Frag(VertToFrag IN):COLOR{
                //float N=normalize(mul(IN.normal,(float3x3)unity_WorldToObject));
                float3 N=normalize(UnityObjectToWorldNormal(IN.normal));//该向量已经归一化
                float3 V=normalize(WorldSpaceViewDir(IN.vertex));//顶点指向摄像机的向量 
                float bright=saturate(dot(N,V));
                bright=pow(bright,_Scale);
                _MainColor.a*=bright;
                return _MainColor;
            }
            ENDCG
        }
        //=============================================
        Pass{
            blendop revsub
            blend dstalpha one
            zwrite off//关闭写入深度
            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex Vert
            #pragma fragment Frag 
 
            float _Scale;
            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION ;
            };
            //顶点着色器
            VertToFrag Vert(appdata_base v){
                VertToFrag vtf;
                float4x4 mvp=UNITY_MATRIX_MVP;
                vtf.pos=mul(mvp,v.vertex);
                return vtf;
            }
            //片元着色器
            float4 Frag(VertToFrag IN):COLOR{
                return float4(1,1,1,1);
            }
            ENDCG
        }
        //=============================================
        Pass{
            //blend zero one
            blend srcalpha oneminussrcalpha
            zwrite off//关闭写入深度
            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex Vert
            #pragma fragment Frag 
 
            float _Scale;
            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION ;
                float3 normal:TEXCOORD0;
                float4 vertex :TEXCOORD1; 
            };
            //顶点着色器
            VertToFrag Vert(appdata_base v){
                VertToFrag vtf;
                float4x4 mvp=UNITY_MATRIX_MVP;
                vtf.pos=mul(mvp,v.vertex);
                vtf.normal=v.normal;
                vtf.vertex =v.vertex;
                return vtf;
            }
            //片元着色器
            float4 Frag(VertToFrag IN):COLOR{
                //float N=normalize(mul(IN.normal,(float3x3)unity_WorldToObject));
                float3 N=normalize(UnityObjectToWorldNormal(IN.normal));//该向量已经归一化
                float3 V=normalize(WorldSpaceViewDir(IN.vertex));//顶点指向摄像机的向量 
                float bright=1-saturate(dot(N,V));
                bright=pow(bright,_Scale);
                float4 color=float4(1,1,1,1)*bright;
                return color;
            }
            ENDCG
        }
    }
}
