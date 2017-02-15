# Let's import some data into a dataframe
df = read.csv("M://Information Technology//Quant//R//australian_males_31Dec2016.csv")  # disclaimer:  this is made-up data, inspired by a stats lesson

# Let's look at the data
df # <-- see it all
head(df, 10) # <-- limit ourselves to top 10

# Let's chart the data
plot(df$Foot_length_cm, df$Reading_grade)

# I prefer to use charts from a package called ggplot2
# (Talk about packages...  Hadley Wickham...  mention his package of packages)
library(tidyverse)
ggplot(df, aes(Foot_length_cm, Reading_grade)) + geom_point()

# Lines of best fit (curvy or straight)
ggplot(df, aes(Foot_length_cm, Reading_grade)) + geom_point() + geom_smooth()
ggplot(df, aes(Foot_length_cm, Reading_grade)) + geom_point() + geom_smooth(method = "lm")

# Linear models are the most nature thing in R:
lm(Foot_length_cm ~ Reading_grade, df)
summary(lm(Foot_length_cm ~ Reading_grade, df)) # Remember that R-squared = correlation squared.  This 0.6089 R-squared implies high correlation

# Maybe age has something to do with it?
arrange(df, DOB)

# Moral of the story:  R is rubbish at importing dates from Excel and CSV files. 
library(lubridate) # <--  We need a Hadley Wickham library for dealing with dates
?lubridate # <-- you can learn about packages in the same way as you can learn about functions
df$DOB = dmy(df$DOB) # <-- We can convert the data using 'dmy' or 'ymd' or 'mdy', as the situation warrants.
arrange(df, DOB) # <-- Now let's try view the data

# For ease of use, let's now add an age column to our original data frame.  Judging from the filename, 
# it's probably safe to assume that data is from 31 Dec 2016, so the age as of the time of the file is:
df$Age = 2016 - year(df$DOB)
head(df, 5)

# And let's try graphing it again:
ggplot(df, aes(Foot_length_cm, Reading_grade, colour = Age)) + geom_point()

# Hmm, ggplot sees a smoothe number (Age) and tries to smoothe the color.
# Let's turn age into labels so ggplot2 treats them like different categories:
df$age_string = as.character(df$Age)
ggplot(df, aes(Foot_length_cm, Reading_grade, color = age_string)) + geom_point()

# Chart's looking a bit muddled.  Let's look at separate charts by facetting
ggplot(df, aes(Foot_length_cm, Reading_grade, color = age_string)) + geom_point() + facet_wrap( ~ Age)

# ...no need to colour anymore:
ggplot(df, aes(Foot_length_cm, Reading_grade)) + geom_point() + facet_wrap( ~ Age)

# Can we still do lines of best fit on each age-facet?
ggplot(df, aes(Foot_length_cm, Reading_grade)) + geom_point() + facet_wrap( ~ Age) + geom_smooth(method = "lm")

# Say we want to focus our attention on the 16-year-olds, which do seem to have some kind of linear relationship:
filter(df, Age == 16)  # <-- filter using dplyr (thanks again, HW)
df[which(df$Age == 16),] # <-- old school R (and possibly our first lesson on how to access all columns of a dataframe)
