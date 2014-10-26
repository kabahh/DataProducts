library(shiny)
library(ShinyDash)
library(datasets)


data <- mtcars	
shinyServer(function(input, output, session){
										
											output$RSq	<-		renderGauge({
																						
																						out_Data1			<-		data[, c("mpg",input$Variables)]
																						X					<-		as.matrix(cbind(1, out_Data1[,-1]))
																						Y					<-		as.matrix(out_Data1[,1])
																						n					<-		nrow(out_Data1)
																						k 					<-		ncol(X)
																						b 					<-		solve(t(X)%*%X) %*% t(X)%*%Y
																						Y.hat 				<-		X%*%b
																						e 					<-		Y-Y.hat
																						SSE 				<-		t(e)%*%e
																						SST 				<-		sum((Y - mean(Y))^2)
																						SSR 				<-		SST - SSE
																						R.Sq 				<-		SSR/SST
																						R.Sq.Adj 			<-		1 - ((1-R.Sq)*(n-1)/(n-k))
																						#ShowRSAdj			<- 		round(R.Sq.Adj * 100, digits = 2)
																						Rsq2				<- 		ifelse(sum(Y) == 0, 0, ifelse(R.Sq.Adj<= 0, 0, round(R.Sq.Adj, digits = 4)))
																						return(Rsq2*100)
																						})
										    
											
											output$status <- 	reactive({
																						out_Data1			<-		data[, c("mpg",input$Variables)]
																						X					<-		as.matrix(cbind(1, out_Data1[,-1]))
																						Y					<-		as.matrix(out_Data1[,1])
																						n					<-		nrow(out_Data1)
																						k 					<-		ncol(X)
																						b 					<-		solve(t(X)%*%X) %*% t(X)%*%Y
																						Y.hat 				<-		X%*%b
																						e 					<-		Y-Y.hat
																						SSE 				<-		t(e)%*%e
																						SST 				<-		sum((Y - mean(Y))^2)
																						SSR 				<-		SST - SSE
																						F.ratio 			<-		(SSR/(k-1))/(SSE/(n-k))
																						f.pvalue 			<-		pf(F.ratio, k-1, n-k, lower.tail=FALSE)
																						test.fv				<-		ifelse(f.pvalue == "NaN", 111101111, f.pvalue)
										
																						if (test.fv >= 0.05 & test.fv != 111101111)
																							list(text="Void", widgetState="alert", subtext="P-Value Not Less Than 5%", subtext2 = "Model Not Statistically Significant", value=signif(test.fv,digits = 3))
																						
																						else if(test.fv < 0.05)
																							list(text="Valid", subtext = "P-Value is Less Than 5%", subtext2 ="Model Statistically Significant",
																								value=signif(test.fv,digits = 3))
																						else 
																							list(text="NULL", widgetState="warning", subtext="No Events of Interest Observed", subtext2 = "Model Not Created", value = test.fv)
																						
																						})
											
											
											})