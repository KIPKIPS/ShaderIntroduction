// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Shader/VertexShader_09"
{
    Properties{
        _Range ("Range", Range(0.0, 5))=1
        _transX("transX",float)=0
        _transY("transY",float)=0
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
            float dis;
            float r;
            float _Range;
            float _transX;
            float _transY;
            VertToFrag Vert(appdata_base adb){
                //基于世界坐标的变换
                float4 worldPos=mul(unity_ObjectToWorld,adb.vertex);
                float2 xy=worldPos.xz;

                //基于局部坐标的变换
                //float2 xy=adb.vertex.xz;

                //float d=sqrt((xy.x-0)*(xy.x-0)+(xy.y-0)*(xy.y-0));
                float d=_Range-length(xy-float2(_transX,_transY));//模长计算,越远离物体的中心点,值越大
                d=d<0?0:d;//超出距离_Range时,则值为零
                float height=1;
                float4 upPos=float4 (adb.vertex.x,height*d,adb.vertex.z,adb.vertex.w);//改变绘制顶点信息的Y值
                VertToFrag vtf;
                float4x4 unityMVP=UNITY_MATRIX_MVP;
                vtf.pos=mul(unityMVP,upPos);

                //float x=vtf.pos.x/vtf.pos.w;//屏幕坐标
                //if(x>=dis&&x<=dis+r){
                //    vtf.color=float4 (1,0,0,1);
                //}
                //else{
                //    vtf.color=float4 (x/2+0.5,x/2+0.5,x/2+0.5,1);
                //}
                vtf.color=float4 (upPos.y,upPos.y,upPos.y,1);
                return vtf;
            }
            float4 Frag(VertToFrag vtf):COLOR{
                return vtf.color;
            }
            ENDCG
        }
    }
}
