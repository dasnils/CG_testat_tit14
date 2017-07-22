using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class heattransformer : MonoBehaviour {

    public GameObject heatsource;

    // Use this for initialization
    void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
        if (heatsource != null)
        {
            Vector4 pos = new Vector4(gameObject.transform.position.x, gameObject.transform.position.y, gameObject.transform.position.z, 1);
            heatsource.GetComponent<MeshRenderer>().material.SetVector("_ThermalSourcePos", pos);
        }

    }
}
