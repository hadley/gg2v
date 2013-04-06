{
	"width" : 600,
	"height" : 400,
	"data" : [
		{
			"name" : "8047920d4df701c4f21074042acae49f",
			"values" : [
				{
					"x" : 1,
					"y" : 25,
					"z" : 1
				},
				{
					"x" : 2,
					"y" : 16,
					"z" : 2
				},
				{
					"x" : 3,
					"y" : 9,
					"z" : 3
				},
				{
					"x" : 4,
					"y" : 4,
					"z" : 1
				},
				{
					"x" : 5,
					"y" : 1,
					"z" : 2
				},
				{
					"x" : 6,
					"y" : 0,
					"z" : 3
				},
				{
					"x" : 7,
					"y" : 1,
					"z" : 1
				},
				{
					"x" : 8,
					"y" : 4,
					"z" : 2
				},
				{
					"x" : 9,
					"y" : 9,
					"z" : 3
				},
				{
					"x" : 10,
					"y" : 16,
					"z" : 1
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
		},
		{
			"name" : "colour",
			"type" : "linear",
			"domain" : {
				"data" : "8047920d4df701c4f21074042acae49f",
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
			"type" : "group",
			"from" : {
				"data" : "8047920d4df701c4f21074042acae49f",
				"transform" : [
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
