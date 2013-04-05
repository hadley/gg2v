{
	"width" : 600,
	"height" : 400,
	"data" : [
		{
			"name" : "8047920d4df701c4f21074042acae49f",
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
					"y" : 0
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
				"data" : "8047920d4df701c4f21074042acae49f",
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
				"data" : "8047920d4df701c4f21074042acae49f",
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
			"from" : {
				"data" : "8047920d4df701c4f21074042acae49f",
				"transform" : [
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
							"x" : {
								"field" : "data.x",
								"scale" : "x"
							},
							"y" : {
								"field" : "data.y",
								"scale" : "y"
							},
							"stroke" : {
								"value" : "#000000"
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
