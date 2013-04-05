{
	"width" : 600,
	"height" : 400,
	"data" : [
		{
			"name" : "4af673f21ae79be51bbab6fba8d15a63",
			"values" : [
				{
					"x" : 0.83441,
					"y" : 0.090559
				},
				{
					"x" : 0.70347,
					"y" : 0.88526
				},
				{
					"x" : 0.87463,
					"y" : 0.27401
				},
				{
					"x" : 0.26175,
					"y" : 0.42282
				},
				{
					"x" : 0.1658,
					"y" : 0.34589
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
					"fill" : {
						"value" : "#000000"
					},
					"stroke" : {
						"value" : "#FF0000"
					},
					"size" : {
						"value" : 141.73
					},
					"symbol" : {
						"value" : "square"
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
