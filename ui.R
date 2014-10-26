library(shiny)
library(ShinyDash)

shinyUI(bootstrapPage( h1(HTML("Linear Regression Validity Gauge")),
				sidebarPanel(
				h3("Motor Trend Car Road Tests Analysis"),
				h4("1. Select the independent variables you believe are associated with MPG, multiple selection is allowed (Hold Shift Key)."),
				h4("2. Review the results in the GAUGE box and STATUS box."),
				h4("3. If you feel that the order of the boxes is confusing, move them! They are designed to be moved around as needed for idea flow."),
				h4("4. If you need to restart, just hit refresh and the boxes will return to their starting locations."),
				h4("5. Get thinkin'!")
				),
	gridster(tile.width = 250, tile.height = 250,
				gridsterItem(col = 3, row = 1, size.x = 1, size.y = 1,
                selectInput(inputId="Variables", label = "Independent Variables",
								   choices = c("Number of Cylinders" = "cyl", "Displacement (cu.in.)" = "disp", "Gross Horsepower" = "hp",
											   "Rear Axle Ratio" = "drat", "Weight (lb/1000)" = "wt", "1/4 mile time" = "qsec",
											   "V/S" = "vs", "Transmission (Binary, Baseline - Automatic)" = "am", "Number of Forward Gears" = "gear",
											   "Gross Horsepower" = "carb"),
								   selected = c("V/S", "Number of Cylinders"), multiple=TRUE),
				
				gridsterItem(col = 3, row = 2, size.x = 1, size.y = 1,
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
