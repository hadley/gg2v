{
	"width" : 600,
	"height" : 400,
	"data" : [
		{
			"name" : "5e8c93c60a31cc30a3d55dca0e7dc0c3",
			"values" : [
				{
					"x" : 0.08075,
					"y" : 0.46639,
					"z" : 0.8746
				},
				{
					"x" : 0.83433,
					"y" : 0.49778,
					"z" : 0.17494
				},
				{
					"x" : 0.60076,
					"y" : 0.28977,
					"z" : 0.034241
				},
				{
					"x" : 0.15721,
					"y" : 0.73288,
					"z" : 0.32039
				},
				{
					"x" : 0.0073994,
					"y" : 0.77252,
					"z" : 0.40233
				}
			]
		}
	],
	"scales" : [
		{
			"name" : "x",
			"type" : "linear",
			"domain" : {
				"data" : "5e8c93c60a31cc30a3d55dca0e7dc0c3",
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
				"data" : "5e8c93c60a31cc30a3d55dca0e7dc0c3",
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
				"data" : "5e8c93c60a31cc30a3d55dca0e7dc0c3",
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
			"type" : "symbol",
			"from" : {
				"data" : "5e8c93c60a31cc30a3d55dca0e7dc0c3"
			},
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
					},
					"fill" : {
						"field" : "data.z",
						"scale" : "colour"
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
