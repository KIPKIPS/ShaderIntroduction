// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Shader/VertexShader_07"
{

    SubShader
    {
        Pass{
            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex Vert
            #pragma fragment Frag 

             float4x4 mvp;
             float4x4 rotateMatrix;
             float4x4 scaleMatrix;
            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION ;
                float4 color:COLOR;
            };
            
            VertToFrag Vert(appdata_base adb){
                VertToFrag vtf;
                float4x4 unityMVP=UNITY_MATRIX_MVP;
                vtf.pos=mul(unityMVP,adb.vertex);

                //基于模型空间的坐标
                //example_01
                if(adb.vertex.x>0){
                    vtf.color=float4 (_SinTime.w/2+0.5f,_CosTime.w/2+0.5f,_SinTime.y/2+0.5f,1);
                }
                else{
                    vtf.color=float4 (0,0,1,1);
                }
                //example_02
                //if(adb.vertex.x==0.5&&adb.vertex.y==0.5&&adb.vertex.z==-0.5){
                //    vtf.color=float4 (1,0,0,1);
                //}
                //else{
                //    vtf.color=float4 (0,0,1,1);
                //}

                //基于世界空间的坐标
                //float4  worldPos=mul(unity_ObjectToWorld,adb.vertex);//
                //if(worldPos.x>0){
                //  vtf.color=float4 (1,0,0,1);
                //}
                //else{
                //    vtf.color=float4 (0,0,1,1);
                //}  
                return vtf;
            }
            float4 Frag(VertToFrag vtf):COLOR{
                return vtf.color;
            }
            ENDCG
        }
    }
}
