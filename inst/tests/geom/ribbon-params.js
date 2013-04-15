{
	"width" : 600,
	"height" : 400,
	"data" : [
		{
			"name" : "e336a887ae61875ff3d40f392bb22078",
			"values" : [
				{
					"x" : 1,
					"y - 2" : 23,
					"y + 2" : 27
				},
				{
					"x" : 2,
					"y - 2" : 14,
					"y + 2" : 18
				},
				{
					"x" : 3,
					"y - 2" : 7,
					"y + 2" : 11
				},
				{
					"x" : 4,
					"y - 2" : 2,
					"y + 2" : 6
				},
				{
					"x" : 5,
					"y - 2" : -1,
					"y + 2" : 3
				},
				{
					"x" : 6,
					"y - 2" : -2,
					"y + 2" : 2
				},
				{
					"x" : 7,
					"y - 2" : -1,
					"y + 2" : 3
				},
				{
					"x" : 8,
					"y - 2" : 2,
					"y + 2" : 6
				},
				{
					"x" : 9,
					"y - 2" : 7,
					"y + 2" : 11
				},
				{
					"x" : 10,
					"y - 2" : 14,
					"y + 2" : 18
				}
			]
		}
	],
	"scales" : [
		{
			"name" : "x",
			"type" : "linear",
			"domain" : {
				"data" : "e336a887ae61875ff3d40f392bb22078",
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
				"data" : "e336a887ae61875ff3d40f392bb22078",
				"field" : "data.y - 2"
			},
			"range" : "height",
			"zero" : false,
			"nice" : true
		}
	],
	"marks" : [
		{
			"type" : "group",
			"from" : {
				"data" : "e336a887ae61875ff3d40f392bb22078",
				"transform" : [
					{
						"type" : "facet",
						"keys" : []
					},
					{
						"type" : "sort",
						"by" : "data.x"
					}
				]
			},
			"marks" : [
				{
					"type" : "area",
					"properties" : {
						"update" : {
							"fill" : {
								"value" : "#FF0000"
							},
							"x" : {
								"field" : "data.x",
								"scale" : "x"
							},
							"y" : {
								"field" : "data.y - 2",
								"scale" : "y"
							},
							"y2" : {
								"field" : "data.y + 2",
								"scale" : "y"
							},
							"stroke" : {
								"value" : "#0000FF"
							},
							"strokeWidth" : {
								"value" : 8.5039
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
