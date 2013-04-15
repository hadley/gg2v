{
	"width" : 600,
	"height" : 400,
	"data" : [
		{
			"name" : "19dbf3a54014ad3a07f2af5be303eb3d",
			"values" : [
				{
					"x" : 1,
					"y" : 25
				},
				{
					"x" : 2,
					"y" : 16
				},
				{
					"x" : 3,
					"y" : 9
				},
				{
					"x" : 4,
					"y" : 4
				},
				{
					"x" : 5,
					"y" : 1
				},
				{
					"x" : 6,
					"y" : 2.2204e-16
				},
				{
					"x" : 7,
					"y" : 1
				},
				{
					"x" : 8,
					"y" : 4
				},
				{
					"x" : 9,
					"y" : 9
				},
				{
					"x" : 10,
					"y" : 16
				}
			]
		}
	],
	"scales" : [
		{
			"name" : "x",
			"type" : "linear",
			"domain" : {
				"data" : "19dbf3a54014ad3a07f2af5be303eb3d",
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
				"data" : "19dbf3a54014ad3a07f2af5be303eb3d",
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
						"data" : "19dbf3a54014ad3a07f2af5be303eb3d",
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
									}
								}
							}
						}
					]
				},
				{
					"type" : "group",
					"from" : {
						"data" : "19dbf3a54014ad3a07f2af5be303eb3d",
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
