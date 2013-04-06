{
	"width" : 600,
	"height" : 400,
	"data" : [
		{
			"name" : "5e8c93c60a31cc30a3d55dca0e7dc0c3",
			"values" : [
				{
					"x" : 0.08075,
					"y" : 0.46639
				},
				{
					"x" : 0.83433,
					"y" : 0.49778
				},
				{
					"x" : 0.60076,
					"y" : 0.28977
				},
				{
					"x" : 0.15721,
					"y" : 0.73288
				},
				{
					"x" : 0.0073994,
					"y" : 0.77252
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
