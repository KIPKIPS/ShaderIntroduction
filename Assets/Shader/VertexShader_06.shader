Shader "Shader/VertexShader_06"
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
            };
            
            VertToFrag Vert(appdata_base adb){
                VertToFrag vtf;
                //float4x4 m=mul(mvp,rm);//先将UNITY_MATRIX_MVP和变换矩阵相乘
                float4x4 unityMVP=UNITY_MATRIX_MVP;//先将UNITY_MATRIX_MVP矩阵赋值给新矩阵m,否则Unity会自动将mul函数替换成UnityObjectToClipPos函数
                //float4x4 rTempMatrix=mul(unityMVP,rotateMatrix);
                float4x4 sTempMatrix=mul(unityMVP,scaleMatrix);
                //得到变换矩阵在屏幕空间的投影位置

                //vtf.pos=mul(UNITY_MATRIX_MVP,adb.vertex)
                //vtf.pos=UnityObjectToClipPos(adb.vertex );
                vtf.pos=mul(sTempMatrix,adb.vertex);
                return vtf;
            }
            float4 Frag():COLOR{
                return float4(1,0,0,1);
            }
            ENDCG
        }
    }
}
