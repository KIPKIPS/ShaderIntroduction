Shader "Shader/SurfaceShader_02"
{
    Properties
    {
        _MainColor("MainColor",Color)=(0,1,0,1)
        _SecondColor("SecondColor",Color)=(0,0,1,1)
        _Scale("Scale",range(-0.51,0.51))=0.0
        _R("R",range(0.,0.51))=0.2
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard vertex:vert fullforwardshadows 

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float x;
        };

        half _Glossiness;
        half _Metallic;
        float4 _MainColor;
        float4 _SecondColor;
        uniform float _Scale;
        float _R;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void vert(inout appdata_full v,out Input o){
        	o.uv_MainTex=v.texcoord.xy;
        	o.x=v.vertex.x;
        }

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;

            //FragmentShader_05方法的优化版
            float d=IN.x-_Scale;
            float s=abs(d);
            d=d/s;

            float f=s/_R;
            f=saturate(f);
            d=d*f;
            d=d/2+0.5;
            o.Albedo= lerp(_MainColor,_SecondColor,d);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
