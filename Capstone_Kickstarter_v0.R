
# Springboard Capstone 
## Predicting whether a Kickstarter project will get fully funded or not.  

## Project Description 
**Who is your client and why do they care about this problem? In other words, what will your client DO or DECIDE based on your analysis that they wouldn’t have otherwise?** 
Those who want to start a Kickstarter campaign. Knowing the most influential factor in getting funded, the client will know what is needed for the greatest chance of success.  

**What data are you going to use for this? How will you acquire this data?**  
Kaggle data      

**In brief, outline your approach to solving this problem.**  
Begin cleaning up the data. Come up with potential theories. Analyze and explore the data. Discover what factor(s) will predict whether a campaign will get funded or not. 


## Data Wrangling 
I'm starting with a data set from Kaggle.  

The data is already fairly clean so I will not need to do too much clean up. 

### Packages Used
```{r}
library(dplyr)  
library(tidyr)  
library(anytime)  
library(readr)  
library(lubridate)  
```


### Import & View the data
[data set](https://www.kaggle.com/codename007/funding-successful-projects/data) 
```{r}
ks <- read_csv("~/Downloads/train.csv.zip")
View(ks)
```

**Clean up the data** 
1. Only include US $ currency  
```{r}
ks_us <- subset(ks, currency == "USD")
```

2. Change date unix format 
```{r}
ks_us$deadline <- anytime(ks_us$deadline)
ks_us$created_at <- anytime(ks_us$created_at)
ks_us$launched_at <- anytime(ks_us$launched_at)
```

3. Extract dealine hour
```{r}
ks_us$deadline_hour <- hour(ks_us$deadline)
```

4. Extract year, month and day
```{r}
ks_us$deadline <- as.Date(strptime(ks_us$deadline, "%Y-%m-%d"))
ks_us$created_at <- as.Date(strptime(ks_us$created_at, "%Y-%m-%d"))
ks_us$launched_at <- as.Date(strptime(ks_us$launched_at, "%Y-%m-%d"))
```

**Create New Metrics**
Days between created and deadline
```{r}
ks_us$date_cd <- difftime(ks_us$deadline,ks_us$created_at, units = "days")
```

**Getting to know the data**
1. Explore funded data
```{r}
ks_funded <- ks_us[ks_us$final_status=="1",]
mean(ks_funded$goal)

ks_funded[ks_funded$goal>1000,]


```

Funded Info
-mean $9,881
...what else???


Explore unfunded
```{r}

ks_unfunded <- ks_us[ks_us$final_status=="0",]

mean(ks_unfunded$goal)

```

