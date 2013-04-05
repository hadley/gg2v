{
	"width" : 600,
	"height" : 400,
	"data" : [
		{
			"name" : "4af673f21ae79be51bbab6fba8d15a63",
			"values" : [
				{
					"x" : 0.83441,
					"y" : 0.090559,
					"z" : 0.52703
				},
				{
					"x" : 0.70347,
					"y" : 0.88526,
					"z" : 0.80091
				},
				{
					"x" : 0.87463,
					"y" : 0.27401,
					"z" : 0.94175
				},
				{
					"x" : 0.26175,
					"y" : 0.42282,
					"z" : 0.22311
				},
				{
					"x" : 0.1658,
					"y" : 0.34589,
					"z" : 0.19078
				}
			]
		}
	],
	"scales" : [
		{
			"name" : "x",
			"type" : "linear",
			"domain" : {
				"data" : "4af673f21ae79be51bbab6fba8d15a63",
				"field" : "data.x"
			},
			"range" : "width",
			"zero" : false,
			"nice" : true
		},
		{
			"name" : "y",
			"type" : "linear",
			"domain" : {
				"data" : "4af673f21ae79be51bbab6fba8d15a63",
				"field" : "data.y"
			},
			"range" : "height",
			"zero" : false,
			"nice" : true
		},
		{
			"name" : "colour",
			"type" : "linear",
			"domain" : {
				"data" : "4af673f21ae79be51bbab6fba8d15a63",
				"field" : "data.z"
			},
			"range" : [
				"#132B43",
				"#55B1F7"
			]
		}
	],
	"marks" : [
		{
			"type" : "rect",
			"name" : "background",
			"properties" : {
				"enter" : {
					"fill" : {
						"value" : "#E5E5E5"
					},
					"y2" : {
						"value" : 0
					},
					"y" : {
						"value" : 1000
					},
					"x" : {
						"value" : 0
					},
					"x2" : {
						"value" : 1000
					}
				}
			}
		},
		{
			"type" : "symbol",
			"from" : {
				"data" : "4af673f21ae79be51bbab6fba8d15a63"
			},
			"properties" : {
				"update" : {
					"x" : {
						"field" : "data.x",
						"scale" : "x"
					},
					"y" : {
						"field" : "data.y",
						"scale" : "y"
					},
					"stroke" : {
						"field" : "data.z",
						"scale" : "colour"
					},
					"fill" : {
						"value" : "#000000"
					}
				}
			}
		}
	],
	"axes" : [
		{
			"type" : "x",
			"scale" : "x"
		},
		{
			"type" : "y",
			"scale" : "y"
		}
	],
	"padding" : {
		"top" : 20,
		"right" : 20,
		"bottom" : 20,
		"left" : 20
	}
}
