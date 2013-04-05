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
					"z2" : "1"
				},
				{
					"x" : 2,
					"y" : 16,
					"z2" : "2"
				},
				{
					"x" : 3,
					"y" : 9,
					"z2" : "3"
				},
				{
					"x" : 4,
					"y" : 4,
					"z2" : "1"
				},
				{
					"x" : 5,
					"y" : 1,
					"z2" : "2"
				},
				{
					"x" : 6,
					"y" : 0,
					"z2" : "3"
				},
				{
					"x" : 7,
					"y" : 1,
					"z2" : "1"
				},
				{
					"x" : 8,
					"y" : 4,
					"z2" : "2"
				},
				{
					"x" : 9,
					"y" : 9,
					"z2" : "3"
				},
				{
					"x" : 10,
					"y" : 16,
					"z2" : "1"
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
			"type" : "ordinal",
			"domain" : {
				"data" : "8047920d4df701c4f21074042acae49f",
				"field" : "data.z2"
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
			"type" : "group",
			"from" : {
				"data" : "8047920d4df701c4f21074042acae49f",
				"transform" : [
					{
						"type" : "facet",
						"keys" : [
							"data.z2"
						]
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
								"field" : "data.z2",
								"scale" : "colour"
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
