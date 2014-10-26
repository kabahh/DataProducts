library(shiny)
library(ShinyDash)

shinyUI(bootstrapPage( h1(HTML("Linear Regression Validity Gauge")),

	gridster(tile.width = 250, tile.height = 250,
				gridsterItem(col = 2, row = 1, size.x = 1, size.y = 1,
                selectInput(inputId="Variables", label = "Independent Variables",
								   choices = c("Number of Cylinders" = "cyl", "Displacement (cu.in.)" = "disp", "Gross Horsepower" = "hp",
											   "Rear Axle Ratio" = "drat", "Weight (lb/1000)" = "wt", "1/4 mile time" = "qsec",
											   "V/S" = "vs", "Transmission (Binary, Baseline - Automatic)" = "am", "Number of Forward Gears" = "gear",
											   "Gross Horsepower" = "carb"),
								   selected = c("V/S", "Number of Cylinders"), multiple=TRUE),
				
				gridsterItem(col = 3, row = 1, size.x = 1, size.y = 1,
				gaugeOutput("RSq", width=250, height=200, units="% Explained by Model", min=0, max=100, title="Adjusted R-Square", value = 0)
							),
				
				gridsterItem(col = 4,
										row = 1,
										size.x = 1,
										size.y = 1,
										tags$div(class = 'grid_title', 'Model Validity Status'),
										htmlWidgetOutput('status', 
														 tags$div(id="text", class = 'grid_bigtext'),
														 tags$p(id="subtext"),
														 tags$p(id="subtext2")
														 )
														 )				
		)						   
   )
   )
)