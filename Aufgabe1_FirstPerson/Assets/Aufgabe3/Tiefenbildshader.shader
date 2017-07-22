Shader "Unlit/Tiefenbildshader"
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

			struct vertexkoordinatenEingabe {
				float4 vertex : POSITION;
			};

			struct vertexkoordinatenAusgabe {
				float4 position : SV_POSITION;
				float4 posInWorldspace : TEXCOORD0;
			};

			vertexkoordinatenAusgabe vert(vertexkoordinatenEingabe eingabe)
			{
				vertexkoordinatenAusgabe ausgabe;
				ausgabe.position = UnityObjectToClipPos(eingabe.vertex);
				// Vertex Eingabedaten der Objekte transformieren
				// Koordinaten in Welt Koordinaten umwandeln 
				ausgabe.posInWorldspace = 
					mul(unity_ObjectToWorld, eingabe.vertex);

				return ausgabe;
			}

			float4 frag (vertexkoordinatenAusgabe eingabe) : COLOR
			{
				// Einstellbare maximale Entfernung
				float maxDistanz = 15.0;

				// Distanz: Berechnung der Distanz zwischen Objekt und Kamera
				float distanz = distance(eingabe.posInWorldspace, _WorldSpaceCameraPos);

				// Normalisieren: Distanzverhältnis zu max. Entfernung in Verzältniswert 
				// zwischen 0 (schwarz) und 1 (weiß) umwandeln
				float normalisiert = (distanz / maxDistanz) ;

				// Wenn Distanz größer als max. Entfernung ist wird direkt weiß ausgegeben
				if(distanz > maxDistanz) 
				{
					return float4 (1.0, 1.0, 1.0, 1.0);
				}

				// Wenn Distanz kleiner max. Entfernung ist wird der Graustufenwert ausgegeben:
				// 0.0,0.0,0.0,1.0 ist schwarz	(Distanz = 0)
				// 1.0,1.0,1.0,1.0 ist weiß		(Distanz = maxDistanz)
				else  
				{
					return float4 (normalisiert, normalisiert, normalisiert, 1.0);
				}
			}

			ENDCG
		}
	}
}
