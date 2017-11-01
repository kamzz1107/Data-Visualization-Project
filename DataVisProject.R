library(ggplot2)
library(data.table)
library(plotly)

#Reading data and converting it to data frame.
df <- fread("Economist_Assignment_Data.csv",drop = 1)
df.data.frame <- as.data.frame(df)

#creating scatter plot
pl <- ggplot(df.data.frame,aes(x=CPI,y=HDI))+geom_point(aes(color=Region),size=3.5,shape=1)

#inserting the red line for graph
pl2 <- pl + geom_smooth(aes(group=1),method = "lm",formula = y~log(x),se=FALSE,color="red")

#Providing colours
pl3 <- pl2 + geom_text(aes(label=Country,color=Region))

pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

#labeling
pl3 <- pl2 + geom_text(aes(label = Country), color = "gray20", 
                       data = subset(df, Country %in% pointsToLabel),check_overlap = TRUE)

#labeling axises
pl4 <- pl3 + scale_x_continuous(name='corruption perceptions index',limits = c(1,10),breaks = 1:10)+ theme_bw()

#setting breaks on axises
pl5 <- pl4 + scale_y_continuous(name="",limits = c(0.2,1.0),breaks = c(0.2,0.4,0.6,0.8,1.0)) + ggtitle(label = "Curroption and Human Development")

#creating live plot with plotly
gpl <- ggplotly(pl5)

print(gpl)
