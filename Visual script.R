
# Building Cool and Insightful Visuals

library(knitr)
library(ggplot2)
library(ggthemes)
library(scales)
library(openxlsx)

# Import data
attrition <- read.csv(file.path('C:/Users/jlbro/OneDrive/R Studio projects/ggplot attrition 1', 'attrition.csv'), stringsAsFactors = TRUE)

# Check first 5 rows
head(attrition)

# Check structure
str(attrition)


### Visual 1
#1 Essential layers
ggplot(attrition, aes(x = JobRole, y = MonthlyIncome, fill = Attrition)) +
  geom_bar(stat = 'summary', fun = mean)

#2 Coordinates and Position Adjustments
ggplot(attrition, aes(x = JobRole, y = MonthlyIncome, fill=Attrition)) +
  geom_bar(stat = 'summary', fun = mean, position = 'dodge') +  #Unstack bars using position = ‘dodge’
  coord_flip()  #Flip x and y axis

#3 Reorder Job Role by highest to lowest Monthly Income
ggplot(attrition, aes(x = reorder(JobRole, MonthlyIncome), y = MonthlyIncome, fill = Attrition)) +
  geom_bar(stat = 'summary', fun = mean, position = 'dodge') +
  coord_flip()

#4 Change colors
ggplot(attrition, aes(x = reorder(JobRole, MonthlyIncome), y = MonthlyIncome, fill = Attrition)) +
  geom_bar(stat = 'summary', fun = mean, width = .8, position = 'dodge') + 
  coord_flip() +
  scale_fill_manual(values = c('#96adbd', '#425e72')) 

#5 Add labels
ggplot(attrition, aes(x = reorder(JobRole, MonthlyIncome), y = MonthlyIncome, fill = Attrition)) +
  geom_bar(stat = 'summary', fun = mean, width = .8, position = 'dodge') +
  coord_flip() +
  scale_fill_manual(values = c('#96adbd', '#425e72')) +
  xlab(' ') +  #Make x label invisible, notice the space between parentheses
  ylab('Monthly Income in USD') +  #Add y label
  ggtitle('Employee Attrition by Job Role & Income')  #Add title

#6 Add theme
ggplot(attrition, aes(x = reorder(JobRole, MonthlyIncome), y = MonthlyIncome, fill = Attrition)) +
  geom_bar(stat = 'summary', fun = mean, width = .8, position = 'dodge') +
  coord_flip() +
  scale_fill_manual(values = c('#96adbd', '#425e72')) +
  xlab(' ') +
  ylab('Monthly Income in USD') + 
  ggtitle('Employee Attrition by Job Role & Income') +
  theme_clean()  #Adding a theme

#7 Remove outlines and minimizing aspect ratio
ggplot(attrition, aes(x = reorder(JobRole, MonthlyIncome), y = MonthlyIncome, fill = Attrition)) +
  geom_bar(stat = 'summary', fun = mean, width = .8, position = 'dodge') +
  coord_flip() +
  scale_fill_manual(values = c('#96adbd', '#425e72')) +
  xlab('') +
  ylab('Monthly Income in USD') + 
  ggtitle('Employee Attrition by Job Role & Income') +
  theme_clean() +
  theme(aspect.ratio = .65,
        plot.background = element_rect(color = 'white'),
        legend.background = element_rect(color = 'white')) #Changing aspect ratio and making plot and legend outline invisible

#################################################################################################

### Visual 2

# 1 Essential Layers
ggplot(attrition, aes(x = MonthlyIncome, y = YearsSinceLastPromotion, color=Attrition)) +
  geom_smooth(se = FALSE)  #Note that se = FALSE removes the confidence shading

# 2 Faceting to add subplots to the canvas
ggplot(attrition, aes(x = MonthlyIncome, y = YearsSinceLastPromotion, color=Attrition)) +
  geom_smooth(se = FALSE) +
  facet_wrap(WorkLifeBalance~.) 

# 3 Add labels to facet subplots
#CreateWorkLifeBalance labels
wlb.labs <- c('1' = 'Bad Balance',
              '2' = 'Good Balance',
              '3' = 'Better Balance',
              '4' = 'Best Balance')
#Add to facet_wrap()
ggplot(attrition, aes(x = MonthlyIncome, y = YearsSinceLastPromotion, color=Attrition)) +
  geom_smooth(se = FALSE) +
  facet_wrap(WorkLifeBalance~., labeller = labeller(WorkLifeBalance = wlb.labs)) 

# 4 Labels and Title
ggplot(attrition, aes(x = MonthlyIncome, y = YearsSinceLastPromotion, color=Attrition)) +
  geom_smooth(se = FALSE) +
  facet_wrap(WorkLifeBalance~., 
             labeller = labeller(WorkLifeBalance = wlb.labs)) +
  xlab('Monthly Income') +
  ylab('Years Since Last Promotion') + 
  ggtitle('Attrition by Work-life Balance & Years Since Last Promotion')

# 5 Add space between labels and tick markers
ggplot(attrition, aes(x = MonthlyIncome, y = YearsSinceLastPromotion, color=Attrition)) +
  geom_smooth(se = FALSE) +
  facet_wrap(WorkLifeBalance~., 
             labeller = labeller(WorkLifeBalance = wlb.labs)) +
  xlab('\nMonthly Income') +
  ylab('Years Since Last Promotion\n') + 
  ggtitle('Attrition by Work-life Balance and Promotion')

# 6 Theme
ggplot(attrition, aes(x = MonthlyIncome, y = YearsSinceLastPromotion, color=Attrition)) +
  geom_smooth(se = FALSE) +
  facet_wrap(WorkLifeBalance~., 
             labeller = labeller(WorkLifeBalance = wlb.labs)) +
  xlab('\nMonthly Income') +
  ylab('Years Since Last Promotion\n') + 
  ggtitle('Attrition, Work-life Balance, and Years Last Promoted') +
  theme_fivethirtyeight()

# 7 Override theme default to bring x and y labels back
ggplot(attrition, aes(x = MonthlyIncome, y = YearsSinceLastPromotion, color=Attrition)) +
  geom_smooth(se = FALSE) +
  facet_wrap(WorkLifeBalance~., 
             labeller = labeller(WorkLifeBalance = wlb.labs)) +
  xlab('\nMonthly Income') +
  ylab('Years Since Last Promotion\n') + 
  ggtitle('Attrition, Work-life Balance, and Years Last Promoted') +
  theme_fivethirtyeight() +
  theme(axis.title = element_text())  #Bringing back our x and y labels

# 8 Add space and change legend location
ggplot(attrition, aes(x = MonthlyIncome, y = YearsSinceLastPromotion, color=Attrition)) +
  geom_smooth(se = FALSE) +
  facet_wrap(WorkLifeBalance~., 
             labeller = labeller(WorkLifeBalance = wlb.labs)) +
  xlab('\nMonthly Income') +
  ylab('Years Since Last Promotion\n') + 
  ggtitle('Attrition by Work-life Balance and Promotion') +
  theme_fivethirtyeight() +
  theme(axis.title = element_text(),
        legend.position = 'top',
        legend.justification = 'left',
        panel.spacing = unit(1.5, 'lines'))

# 9 Change line color
ggplot(attrition, aes(x = MonthlyIncome, y = YearsSinceLastPromotion, color=Attrition)) +
  geom_smooth(se = FALSE) +
  facet_wrap(WorkLifeBalance~., 
             labeller = labeller(WorkLifeBalance = wlb.labs)) +
  xlab('\nMonthly Income') +
  ylab('Years Since Last Promotion\n') + 
  ggtitle('Attrition by Work-life Balance and Promotion') +
  theme_fivethirtyeight() +
  theme(axis.title = element_text(),
        legend.position = 'top',
        legend.justification = 'left',
        panel.spacing = unit(1.5, 'lines')) +
  scale_color_manual(values = c('#999999','#ffb500'))  #Change line color

