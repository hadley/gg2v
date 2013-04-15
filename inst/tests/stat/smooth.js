{
	"width" : 600,
	"height" : 400,
	"data" : [
		{
			"name" : "94207b3058c159d816a1eb4504301652",
			"values" : [
				{
					"x" : 1,
					"y" : 24.061
				},
				{
					"x" : 2,
					"y" : 14.858
				},
				{
					"x" : 3,
					"y" : 8.0062
				},
				{
					"x" : 4,
					"y" : 3.3267
				},
				{
					"x" : 5,
					"y" : 2.0161
				},
				{
					"x" : 6,
					"y" : 0.2637
				},
				{
					"x" : 7,
					"y" : 0.27321
				},
				{
					"x" : 8,
					"y" : 3.2201
				},
				{
					"x" : 9,
					"y" : 8.4214
				},
				{
					"x" : 10,
					"y" : 15.932
				}
			]
		},
		{
			"name" : "a89da5ddf320ba4f6f360fd5510fa9a1",
			"values" : [
				{
					"x" : 1,
					"y" : 23.6
				},
				{
					"x" : 2,
					"y" : 16.255
				},
				{
					"x" : 3,
					"y" : 6.5627
				},
				{
					"x" : 4,
					"y" : 3.9944
				},
				{
					"x" : 5,
					"y" : 1.6216
				},
				{
					"x" : 6,
					"y" : 1.1484
				},
				{
					"x" : 7,
					"y" : -0.82182
				},
				{
					"x" : 8,
					"y" : 3.7527
				},
				{
					"x" : 9,
					"y" : 8.7558
				},
				{
					"x" : 10,
					"y" : 15.717
				}
			]
		}
	],
	"scales" : [
		{
			"name" : "x",
			"type" : "linear",
			"domain" : {
				"data" : "a89da5ddf320ba4f6f360fd5510fa9a1",
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
				"data" : "a89da5ddf320ba4f6f360fd5510fa9a1",
				"field" : "data.y"
			},
			"range" : "height",
			"zero" : false,
			"nice" : true
		}
	],
	"marks" : [
		{
			"type" : "symbol",
			"from" : {
				"data" : "a89da5ddf320ba4f6f360fd5510fa9a1"
			},
			"properties" : {
				"update" : {
					"stroke" : {
						"value" : "#000000"
					},
					"x" : {
						"field" : "data.x",
						"scale" : "x"
					},
					"y" : {
						"field" : "data.y",
						"scale" : "y"
					},
					"fill" : {
						"value" : "#000000"
					}
				}
			}
		},
		{
			"type" : "group",
			"from" : {
				"data" : "94207b3058c159d816a1eb4504301652",
				"transform" : [
					{
						"type" : "sort",
						"by" : "data.x"
					},
					{
						"type" : "facet",
						"keys" : []
					}
				]
			},
			"marks" : [
				{
					"type" : "line",
					"properties" : {
						"update" : {
							"stroke" : {
								"value" : "#000000"
							},
							"x" : {
								"field" : "data.x",
								"scale" : "x"
							},
							"y" : {
								"field" : "data.y",
								"scale" : "y"
							}
						}
					}
				}
			]
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
