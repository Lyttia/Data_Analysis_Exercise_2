#1) Explore the dataset with summary and str
summary(adult)
str(adult)

#2) Age histogram
ggplot(adult, aes(SRAGE_P)) +
  geom_histogram()

#3) BMI value histogram
ggplot(adult, aes(BMI_P)) +
  geom_histogram()

#4) Age colored by BMI, binwidth = 1
ggplot(adult, aes(SRAGE_P)) +
  geom_histogram(binwidth = 1, aes(fill = factor(RBMI)))

#Data Cleaning: Now that we have an idea about our data, let's clean it up.

#5) There is an unusual spike of individuals at 85, which seems like an artifact 
# of data collection and storage. Keep adults younger than or equal to 84.
adult <- adult[adult$SRAGE_P <= 84, ] 

#6) There is a long positive tail on the BMIs that we'd like to remove. 
#Keep adults with BMI at least 16 and less than 52.
adult <- adult[adult$BMI_P >= 16 & adult$BMI_P < 52, ]

#7) We'll focus on the relationship between the BMI score (& category), age and race. 
#To make plotting easier later on, we'll change the labels in the dataset.
#Relabel the race variable.
adult$RACEHPR2 <- factor(adult$RACEHPR2, 
                         labels = c("Latino", "Asian", "African American", "White"))

#8) Relabel the BMI categories variable
adult$RBMI <- factor(adult$RBMI, 
                     labels = c("Under-weight", "Normal-weight", "Over-weight", "Obese"))
# The dataset adult is available

#9) The color scale used in the plot
BMI_fill <- scale_fill_brewer("BMI Category", palette = "Reds")

#10) Theme to fix category display in faceted plot
fix_strips <- theme(strip.text.y = element_text(angle = 0, hjust = 0, vjust = 0.1, size = 14),
                    strip.background = element_blank(),
                    legend.position = "none")

#11) Histogram, add BMI_fill and customizations
ggplot(adult, aes (x = SRAGE_P, fill= RBMI)) + 
  geom_histogram(binwidth = 1) +
  fix_strips +
  BMI_fill +
  facet_grid(RBMI ~ ., theme_classic())

ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) + 
  geom_histogram(binwidth = 1) +
  fix_strips +
  BMI_fill +
  facet_grid(RBMI ~ .) + theme_classic()

# Plot 1 - Count histogram
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) +
  geom_histogram(binwidth = 1) +
  BMI_fill

# Plot 2 - Density histogram
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) + 
  geom_histogram(aes(y = ..density..), binwidth = 1) +
  BMI_fill

# Plot 3 - Faceted count histogram
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) +
  geom_histogram(binwidth = 1) +
  BMI_fill +
  facet_grid(RBMI ~ . )

# Plot 4 - Faceted density histogram
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) + 
  geom_histogram(aes(y = ..density..), binwidth = 1) +
  BMI_fill + 
  facet_grid(RBMI ~ .)

# Plot 5 - Density histogram with position = "fill"
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) + 
  geom_histogram(aes(y = ..density..), binwidth = 1, position = "fill") +
  BMI_fill

# Plot 6 - The accurate histogram
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) + 
  geom_histogram(aes(y = ..count../sum(..count..)), binwidth = 1, position = "fill") +
  BMI_fill

# An attempt to facet the accurate frequency histogram from before (failed)
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) +
  geom_histogram(aes(y = ..count../sum(..count..)), binwidth = 1, position = "fill") +
  BMI_fill +
  facet_grid(RBMI ~ .)

# Create DF with table()
DF <- table(adult$RBMI, adult$SRAGE_P)

# Use apply on DF to get frequency of each group
DF_freq <- apply(DF, 2, function(x) x/sum(x))

# Load reshape2 and use melt on DF to create DF_melted
library(reshape2)
DF_melted <- melt(DF_freq)

DF_freq
DF_melted

# Change names of DF_melted
names(DF_melted) <- c("FILL", "X", "value")

# Add code to make this a faceted plot
ggplot(DF_melted, aes(x = X, y = value, fill = FILL)) +
  geom_col(position = "stack") +
  BMI_fill + 
  facet_grid(FILL ~ .) # Facets
