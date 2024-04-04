library("tidyr")
library("stringr")

#Task 1
#Dataset used for this task: who in the tidy package – This is a dataset containing tuberculosis (TB) cases broken down by year, country, age, gender, and diagnosis method. Note that this is a dataset embedded in package tidy so there is no need to import it from anywhere else.

#Task 1.1
#Gather together all the columns from new_sp_m014 to newrel_f65
#o Use pivot_longer()
#o We do not know what those values represent yet, so we give them the generic name as "key" (hint: names_to)
#o We know the cells represent the count of cases, so we use the variable “cases” (hint: values_to)
#o There are a lot of missing values in the current representation, so for now we
#use values_drop_na just so we can focus on the values that are present.
#o Name the new dataset who1
who <- data.frame(who,package="tidyr")
print(head(who,2))

who1 <- pivot_longer(data = who,names_to = "key", values_to = "cases", cols = c("new_sp_m014":"newrel_f65"), values_drop_na = TRUE)
print(head(who1,2))

#Task 1.2
#Make variable names consistent
#Instead of newrel we have new_rel. It is hard to spot this here but if you do not fix it, we will get errors in subsequent steps.
#o Use stringr::str_replace() in strings: replace the characters “newrel” with “new_rel”.
#o Name the dataset who2
who2 <- who1
who2$key <- str_replace(who1$key, "newrel", "new_rel")
print(head(who2,2))

#Task 1.3
#Run the following code
#whο3 <- who2 %>% separate(key, c("new", "type", "sexage"), sep = "_")
#Now you get a dataset who3. Comment this line of code. What is the purpose of using %>%.
who3 <- who2
who3 <- who2 %>% separate(key, c("new", "type","sexage"), sep="_")
print(head(who3,10))

#Task 1.4
#Separate sexage into sex and age: Use the function separate(). Name the dataset who4
who4 <- who3
who4 <- who3 %>% separate(sexage, c("sex", "age"), sep="(?<=[mf])(?=[0-9])")
print(head(who4,10))

#Task 1.5
#Print the first 5 rows and the last 5 rows of the dataset who4 to the screen.
print(head(who4,5))
print(tail(who4,5))

#Task 1.6
#Export who4 as an csv file and save it in your local directory.
write.csv(who4,"who", row.names = FALSE)


#Task 2
# For this task, we’ll use the built-in R dataset named "Nile" - no need to download any data

#Task 2.1
#Compute the mean, median, mode, variance and standard deviation of the dataset
print(Nile)

mean(Nile)
median(Nile)
mode(Nile)
var(Nile)
sd(Nile)

#Task 2.2
#Compute how “spread out” the data are. Here you need to calculate the minimum, maximum and range
min(Nile)
max(Nile)
range(Nile)

#Task 2.3
#Calculate the interquartile (IQR) range. Use the function quantile() to measure quantiles for the same dataset, and comment on the difference and relation of these two functions.
IQR(Nile)
quantile(Nile)

#Task 2.4
#Use the in-built R basic functions (no need to import any library) to create a histogram. Make sure you add the following arguments: 
#main: Figure it out what the dataset is about, and then add a title for this plot to reflect what the Nile dataset is about (avoid label it as Nile) as well as the type of the plot created.
#xlab: Add a meaningful label for the x axis
#ylab: Add a meaningful label for the y axis
#col: set a colour of the bars
hist(Nile,main="Over Spread Of River",xlab="Timeline",ylab="Flow Rate",col="green",border="black")

#Task 2.5
#Use qqnorm() and qqplot()to produce quantile-quantile plot.
#You will need to set the reference line colour as red, and its width as 2.
#Interpret the plot (what are the points, and what is the purpose of the line?) and comment on normality of the dataset.
qqnorm(Nile,col="red",lwd = 2)
qqplot(Nile,Nile,col="red",lwd = 2)

#Task 2.6
#Use plot() to further explore the dataset including arguments such as xlab, ylab, main and type
plot(Nile,xlab= "Year", ylab="Overflow rate", main="Nile dataset", type="S")

#Task 3
#The dataset mpg used in this task is a data frame and can be found in the package ggplot2 (aka ggplot2::mpg).

library(ggplot2)

#Task 3.1
#Plot and explain: Which vehicle brand (or manufacturer), offers the best mpg in both city and in the highway?
qplot(manufacturer, data=mpg, geom="bar", fill=manufacturer)

#Task 3.2
#Plot and explain: Which type of car, regarding their displ range (size of engine) has the lowest mpg in the city categorised by the vehicle type (e.g., compact, suv or 2seaters defined in the variable class)? Display the resulting plot categorised by the vehicle type. Hint: facet_wrap() for the categorisation
ggplot(mpg, aes(displ, cty))+geom_point()+facet_wrap(vars(class),labeller = "label_both")

#Task 3.3
#Plot and explain: Which type of car, regarding their displ range (size of engine) has the best mpg performance in both city and highway? Display the resulting plot categorised by the number of cylinders and the drive type (the type of drive train, where f = front-wheel drive, r = rear wheel drive, 4 = 4wd). You are a buyer who wants a high litre engine vehicle and drives mostly in the highway, which type of car would you choose? Hint: facet_grid() for the categorisation
ggplot(mpg, aes(displ, cty))+geom_point()+facet_grid(vars(cyl,drv),labeller = "label_both")
ggplot(mpg, aes(displ, hwy))+geom_point()+facet_grid(vars(cyl,drv),labeller = "label_both")
