{
	"width" : 600,
	"height" : 400,
	"data" : [
		{
			"name" : "6c7fd20efa5fa066c7c66c4f1edf24a9",
			"values" : [
				{
					"x" : 1,
					"y" : 25,
					"y - 2" : 23,
					"y + 2" : 27
				},
				{
					"x" : 2,
					"y" : 16,
					"y - 2" : 14,
					"y + 2" : 18
				},
				{
					"x" : 3,
					"y" : 9,
					"y - 2" : 7,
					"y + 2" : 11
				},
				{
					"x" : 4,
					"y" : 4,
					"y - 2" : 2,
					"y + 2" : 6
				},
				{
					"x" : 5,
					"y" : 1,
					"y - 2" : -1,
					"y + 2" : 3
				},
				{
					"x" : 6,
					"y" : 0,
					"y - 2" : -2,
					"y + 2" : 2
				},
				{
					"x" : 7,
					"y" : 1,
					"y - 2" : -1,
					"y + 2" : 3
				},
				{
					"x" : 8,
					"y" : 4,
					"y - 2" : 2,
					"y + 2" : 6
				},
				{
					"x" : 9,
					"y" : 9,
					"y - 2" : 7,
					"y + 2" : 11
				},
				{
					"x" : 10,
					"y" : 16,
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
				"data" : "6c7fd20efa5fa066c7c66c4f1edf24a9",
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
				"data" : "6c7fd20efa5fa066c7c66c4f1edf24a9",
				"field" : "data.y"
			},
			"range" : "height",
			"zero" : false,
			"nice" : true
		}
	],
	"marks" : [
		{
			"type" : "group",
			"marks" : [
				{
					"type" : "group",
					"from" : {
						"data" : "6c7fd20efa5fa066c7c66c4f1edf24a9",
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
										"value" : "#999999"
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
									}
								}
							}
						}
					]
				},
				{
					"type" : "group",
					"from" : {
						"data" : "6c7fd20efa5fa066c7c66c4f1edf24a9",
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
