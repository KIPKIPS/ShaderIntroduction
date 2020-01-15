// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Shader/VertexShader_10"
{
    SubShader
    {
        Pass{
            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex Vert
            #pragma fragment Frag  

            float anti_aliasing;
            float speed;
            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION ;
                float4 color:COLOR;
            };
            VertToFrag Vert(appdata_base adb){
                //float angle=length(adb.vertex)*_SinTime.w/2;
                // float4x4 m={
                //     float4(cos(angle),0,sin(angle),0),
                //     float4(0,1,0,0),
                //     float4(-sin(angle),0,cos(angle),0),
                //     float4(0,0,0,1)
                // };

                // float x=cos(angle)*adb.vertex.x+sin(angle)*adb.vertex.z;
                // float z=cos(angle)*adb.vertex.z-sin(angle)*adb.vertex.x;
                // adb.vertex.x=x;
                // adb.vertex.z=z;

                float angle=adb.vertex.z*anti_aliasing+_Time.y*speed;
                float4x4 m={
                    float4(sin(angle)/8+0.5f,0,0,0),
                    float4(0,1,0,0),
                    float4(0,0,1,0),
                    float4(0,0,0,1)
                };

                VertToFrag vtf;
                float4x4 unityMVP=UNITY_MATRIX_MVP;
                adb.vertex=mul(m,adb.vertex);
                vtf.pos=mul(unityMVP,adb.vertex);

                vtf.color=float4 (0,1,1,1);
                return vtf;
            }
            float4 Frag(VertToFrag vtf):COLOR{
                return vtf.color;
            }
            ENDCG
        }
    }
}
