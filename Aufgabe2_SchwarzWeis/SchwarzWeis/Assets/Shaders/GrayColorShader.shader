Shader "Unlit/GrayColorShader"
{
    Properties
    {
        //Standard auf weiß setzen
		_Color ("Main Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            float4 vert (float4 vertex : POSITION) : SV_POSITION
            {
                return UnityObjectToClipPos(vertex);
            }
            
            fixed4 _Color;

            fixed4 frag () : SV_Target
            {
            	//Graufstufenintensität  0.3 * red + 0.59 * green + 0.11 * blue
       			float grayscale = dot(float3(0.3, 0.59, 0.11), _Color);
				//Graufstufen zurückgeben
        		return grayscale;
            }
			
            ENDCG
        }
    }
}

