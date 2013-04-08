{
	"width" : 600,
	"height" : 400,
	"data" : [
		{
			"name" : "3ab1045d427606d892efa8a26bd7f171",
			"values" : [
				{
					"x" : 1,
					"x2" : 1.5,
					"y" : 1,
					"y2" : 1.5
				},
				{
					"x" : 2,
					"x2" : 2.5,
					"y" : 2,
					"y2" : 2.5
				},
				{
					"x" : 3,
					"x2" : 3.5,
					"y" : 3,
					"y2" : 3.5
				}
			]
		}
	],
	"scales" : [
		{
			"name" : "x",
			"type" : "linear",
			"domain" : {
				"data" : "3ab1045d427606d892efa8a26bd7f171",
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
				"data" : "3ab1045d427606d892efa8a26bd7f171",
				"field" : "data.y"
			},
			"range" : "height",
			"zero" : false,
			"nice" : true
		}
	],
	"marks" : [
		{
			"type" : "rect",
			"from" : {
				"data" : "3ab1045d427606d892efa8a26bd7f171"
			},
			"properties" : {
				"update" : {
					"fill" : {
						"value" : "#0000FF"
					},
					"x" : {
						"field" : "data.x",
						"scale" : "x"
					},
					"y" : {
						"field" : "data.y",
						"scale" : "y"
					},
					"x2" : {
						"field" : "data.x2",
						"scale" : "x"
					},
					"y2" : {
						"field" : "data.y2",
						"scale" : "y"
					},
					"stroke" : {
						"value" : "#FF0000"
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
