//Shader固定管线
Shader "Shader/FixedFunctionShader_02"
{
    Properties {
        _Color("Main Color",Color)=(1,1,1,1)
        _Ambient("Ambient",Color)=(0.3,0.3,0.3,0.3)
        _Specular("Specular",Color)=(1,1,1,1)
    
        _Shininess("Shininess", range(0,8))=4
        _Emission("Emission",Color)=(1,1,1,1)

        _MainTex("MainTex",2D)=""
        _SecondTex("SecondTex",2D  )=""
    }
    SubShader
    {
        Pass{
            //color(1,0,0,1)
            //color [_Color]
            Material {
                Diffuse[_Color]//物体自身的颜色,可以理解物体表面的颜色
                Ambient[_Ambient]//环境光,其实就是除却物体之后周边环境的颜色
                Specular[_Specular]//高光的颜色,也就是形容物体光滑程度的
                Shininess[_Shininess]//高光的区域,光斑的大小范围
                Emission[_Emission]//自身发光
            }
            Lighting On//打开光照
            separatespecular On//使用高光必须开启separatespecular
            //primary代表之前计算好的所有光照参数 
            SetTexture[_MainTex]{
                //double(双倍光照参数) QUAD(四倍顶点光照参数) 
                combine Texture *primary double
            }
            //previous代表先前所有的纹理信息,结果为两次的混合 
            SetTexture[_SecondTex]{
                //double(双倍光照参数) QUAD(四倍顶点光照参数) 
                combine Texture *previous double
            }
        }
    }
}
