{
	"width" : 600,
	"height" : 400,
	"data" : [
		{
			"name" : "a89da5ddf320ba4f6f360fd5510fa9a1",
			"values" : [
				{
					"x" : 1,
					"y" : 23.6,
					"z" : "1"
				},
				{
					"x" : 2,
					"y" : 16.255,
					"z" : "1"
				},
				{
					"x" : 3,
					"y" : 6.5627,
					"z" : "1"
				},
				{
					"x" : 4,
					"y" : 3.9944,
					"z" : "1"
				},
				{
					"x" : 5,
					"y" : 1.6216,
					"z" : "1"
				},
				{
					"x" : 6,
					"y" : 1.1484,
					"z" : "2"
				},
				{
					"x" : 7,
					"y" : -0.82182,
					"z" : "2"
				},
				{
					"x" : 8,
					"y" : 3.7527,
					"z" : "2"
				},
				{
					"x" : 9,
					"y" : 8.7558,
					"z" : "2"
				},
				{
					"x" : 10,
					"y" : 15.717,
					"z" : "2"
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
		},
		{
			"name" : "colour",
			"type" : "ordinal",
			"domain" : {
				"data" : "a89da5ddf320ba4f6f360fd5510fa9a1",
				"field" : "data.z"
			},
			"range" : [
				"#F8766D",
				"#A3A500",
				"#00BF7D",
				"#00B0F6",
				"#E76BF3"
			],
			"points" : true
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
				"data" : "a89da5ddf320ba4f6f360fd5510fa9a1",
				"transform" : [
					{
						"type" : "sort",
						"by" : "data.x"
					},
					{
						"type" : "facet",
						"keys" : [
							"data.z"
						]
					}
				]
			},
			"marks" : [
				{
					"type" : "line",
					"properties" : {
						"update" : {
							"stroke" : {
								"field" : "data.z",
								"scale" : "colour"
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
