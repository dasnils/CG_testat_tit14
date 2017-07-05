﻿Shader "Unlit/Tiefenbildshader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct VertexkoordinatenEingabe {
				float4 vertex POSITION;
			}

			struct VertexkoordinatenAusgabe {
				float4 position : SV_POSITION;
				float4 posInWorldspace : TEXCOORD0;
			}

			VertexkoordinatenAusgabe vert(VertexkoordinatenEingabe eingabe)
			{
				VertexkoordinatenAusgabe ausgabe;
				ausgabe.position = UnityObjectToClipPos (eingabe.vertex);
				ausgabe.posInWorldspace = mul (unity_ObjectToWorld, eingabe.vertex);
				return ausgabe;
			}

			float4 fl (VertexkoordinatenAusgabe eingabe) : COLOR
			{
				float distanz = distance(eingabe.posInWorldspace, _WorldSpaceCameraPos);

				return float4 (distanz, distanz, distanz, 1.0);
			}

/*			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
*/
			ENDCG
		}
	}
}
