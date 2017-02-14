# Let's import some data
df = read.csv("australian_males_31Dec2016.csv")
df = read.csv("M://Information Technology//Quant//R//australian_males_31Dec2016.csv")


# Let's look at the data
df
head(df, 10)

# Let's chart the data
plot(df$Foot_length_cm, df$Reading_grade)

# I like to use charts from a package called ggplot2
# (Talk about libraries...  Hadley Wickham...  tidy data)
library(tidyverse)
ggplot(df, aes(Foot_length_cm, Reading_grade)) + geom_point()

# Line of best fit
ggplot(df, aes(Foot_length_cm, Reading_grade)) + geom_point() + geom_smooth(method = "lm")

# Linear models are the most nature thing in R:
lm(Foot_length_cm ~ Reading_grade, df)
summary(lm(Foot_length_cm ~ Reading_grade, df)) # Remember that R-squared = correlation squared.  This 0.6089 R-squared implies high correlation

# Maybe age has something to do with it?
arrange(df, DOB)

# Moral of the story:  R is rubbish at importing dates from Excel and CSV files. 
library(lubridate) # <--  We need a Hadley Wickham library for dealing with dates
df$DOB = dmy(df$DOB) # <-- We can convert the data using 'dmy' or 'ymd' or 'mdy', as the situation warrants.
arrange(df, DOB) # <-- Now let's try view the data

# For ease of use, let's now add an age column to our original data frame.  Judging from the filename, it's probably safe
# to assume that data is from 31 Dec 2016, so the age as of the time of the 
df$Age = 2016 - year(df$DOB)
head(df, 5)

# And let's try graphing it again:
ggplot(df, aes(Foot_length_cm, Reading_grade, color = Age)) + geom_point()

# Hmm, ggplot sees a smoothe number (Age) and tries to smoothe the color.
# Let's turn age into labels so ggplot2 treats them like different categories:
df$age_string = as.character(df$Age)
ggplot(df, aes(Foot_length_cm, Reading_grade, color = age_string)) + geom_point()

# Chart's looking a bit muddled.  Let's look at separate charts by facetting
ggplot(df, aes(Foot_length_cm, Reading_grade, color = age_string)) + geom_point() + facet_wrap( ~ Age)

# ...no need to colour anymore:
ggplot(df, aes(Foot_length_cm, Reading_grade)) + geom_point() + facet_wrap( ~ Age)

# Can we still do lines of best fit on each age?
ggplot(df, aes(Foot_length_cm, Reading_grade)) + geom_point() + facet_wrap( ~ Age) + geom_smooth(method = "lm")



