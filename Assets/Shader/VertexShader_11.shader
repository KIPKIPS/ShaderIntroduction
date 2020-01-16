// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Shader/VertexShader_11"
{
	Properties{
		_InOut("IO",int)=1
	}
    SubShader
    {
        Pass{
            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex Vert
            #pragma fragment Frag  

         
            //通信结构体
            struct VertToFrag{
                float4 pos:POSITION ;
                float4 color:COLOR;
            };
            int _InOut=1; 
            VertToFrag Vert(appdata_base adb){
            	//A*sin(w*x+t)
            	_InOut=_InOut>=0?1:-1;
            	//adb.vertex.y+=sin(_InOut*length(adb.vertex.xz)/2+_Time.y*2)/4;//圆形波
            	adb.vertex.y+=sin(_InOut*(adb.vertex.x+adb.vertex.z)+_Time.y)*0.2;//河流波形
            	adb.vertex.y+=sin(_InOut*(adb.vertex.x-adb.vertex.z)+_Time.w)*0.3;
                VertToFrag vtf;
                float4x4 unityMVP=UNITY_MATRIX_MVP;
                vtf.pos=mul(unityMVP,adb.vertex);

                vtf.color=float4 (adb.vertex.y,adb.vertex.y,adb.vertex.y,1);
                return vtf;
            }
            float4 Frag(VertToFrag vtf):COLOR{
                return vtf.color;
            }
            ENDCG
        }
    }
}
