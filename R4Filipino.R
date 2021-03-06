#' ---
#' title: "R is also for Filipino Researchers"
#' author: "Joseph S. Tabadero, Jr."
#' date: "October 28, 2017"
#' output:
#'   ioslides_presentation:
#'     smaller: yes
#'     widescreen: yes
#'     fig_width: 6
#'     fig_height: 6
#'   beamer_presentation: 
#'     latex_engine: xelatex
#' bibliography: bibliography.bib
#' ---
#' 
## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, cache = TRUE, comment = "", fig.align = 'center', out.width = 350)

#' 
#' ## [What is R?][2] [@rfoundation]
#' 
#' "R is a language and environment for statistical computing and graphics. It is a GNU project which is similar to the S language and environment which was developed at Bell Laboratories (formerly AT&T, now Lucent Technologies) by John Chambers and colleagues. R can be considered as a different implementation of S. There are some important differences, but much code written for S runs unaltered under R.
#' 
#' R provides a wide variety of statistical (linear and nonlinear modelling, classical statistical tests, time-series analysis, classification, clustering, …) and graphical techniques, and is highly extensible. The S language is often the vehicle of choice for research in statistical methodology, and R provides an Open Source route to participation in that activity."
#' 
#' ## (Some) Advantages of using R (from an R fanboy)
#' 
#' * R is the most comprehensive statistical analysis software available.
#' * R is a programming language developed by research and practicing statisticians for statisticians.
#' * The graphical capabilities and options in R far surpasses the available graphical capabilities in other statistical packages.
#' * R is free and open source licensed to The R Foundation for Statistical Computing under the GNU General Public License
#' * R has a large community of users, developers, and bug-fixers. You can contribute to the development of R, too, by becoming an active member of the community.
#' * R has over 10,000 packages available in CRAN and more available in bioconductor and Github repositories.
#' * There are a lot of free books, websites, and coursewares available for learning R.
#' 
#' ## (Some) Disadvantages of Using R
#' 
#' * R has a steep learning curve (?)
#' * Documentation is sometimes lacking
#' * The quality of some packages is sometimes questionable
#' * There is in general no one to complain to when something goes wrong
#' * R's memory management sucks (?)
#' 
#' ## [Who Uses R?][1] [@bhalla]
#' 
#' * Facebook - For behavior analysis related to status updates and profile pictures.
#' *    Google - For advertising effectiveness and economic forecasting.
#' *    Twitter - For data visualization and semantic clustering
#' *    Microsoft - Acquired Revolution R company and use it for a variety of purposes.
#' *    Uber - For statistical analysis
#' *    Airbnb - Scale data science.
#' *    IBM - Joined R Consortium Group
#' *    ANZ - For credit risk modeling
#' 
#' ## Why use R?
#' 
#' * It is free (and open source)!
#' * R is the most popular tool for analytics/data science [@kdnuggets1].
#' * Ranked 5th in most popular software based on number of job offerings: SQL, Python, Java, Hadoop, R, C/C++/C#, SAS, Apache Spark, Tableau, Apache Hive [@muenchen]
#' * R has surpassed SAS in scholarly use--but still way behind SPSS [@muenchen2]
#' 
#' 
#' ## Is "R also for Filipino Researchers"?
#' 
#' Yes.
#' 
#' ## I have no experience with coding so R frightens me.
#' 
#' * You use Microsoft Excel, right?
#' 
#' ## Why use Rstudio with R?
#' 
## ---- out.width=900, fig.width=5, fig.height=3, echo=FALSE, eval=TRUE----
knitr::include_graphics("./img/Rmarkdown.png")

#' 
#' 
#' ## Let's load the required packages first
#' 
## ------------------------------------------------------------------------
library(tidyverse)
library(agricolae)

#' 
#' 
#' 
#' ## Introducing the `mtcars data set`
#' 
## ------------------------------------------------------------------------
?mtcars
write.csv(mtcars, "mtcars.csv")

#' 
#' ## Using different ways to load data set into R
#' 
#' * Using the R console
#' 
## ---- message=FALSE, warning=FALSE---------------------------------------
mt1 <- read.table("mtcars.csv", sep = ",", header=TRUE)
mtcars2 <- read.csv("mtcars.csv")
mt3 <- read_csv("mtcars.csv")
mt4 <- data.table::fread("mtcars.csv")

#' 
#' * From Rstudio, click `File > Import Dataset`.
#' 
#' ## Linear Model for comparing the means of two groups
#' 
#' ### Means Model
#' 
#' \[y_{ij} = \mu_i + \varepsilon_{ij},\, i = 1,2\]
#' 
#' * $H_0: \mu_1 = \mu_2$
#' * $H_a: \mu_1\neq\mu_2$
#' 
#' ## Linear Model for comparing the means of two groups
#' 
#' ### Effects Model
#' 
#' \[y_{ij} = \mu + \alpha_i + \varepsilon_{ij},\, i = 1,2\]
#' 
#' where:
#' 
#' * $y_{ij}=$ is the $j$th value of `mpg` in the $i$th group of `am`
#' * $\mu=$ mean of $Y$
#' * \(\alpha_i = \) effect of the $i$th group of `am` on `mpg`
#' * $\varepsilon=$ the random error due to the $j$th value of `mpg` in the $i$th value of `am`
#' 
#' ### Hypotheses
#' 
#' 
#' * $H_0: \alpha_1 = \alpha_2$
#' * $H_a: \alpha_1\neq\alpha_2$
#' 
#' 
#' ## A research question: Is there a difference in milleage for automatic and manual cars?
#' 
#' * $H_a: \alpha_1=\alpha_2=0$ (or $\mu_1=\mu_2$) The milleage per gallon differ based on transmission type of the car.
#' 
#' * $H_0: \alpha_1\neq\alpha_2$ (or $\mu_1\neq\mu_2$) The milleage per gallon do not differ based on transmission type of the car.
#' 
#' ## A research question: Is there a difference in milleage for automatic and manual cars?
#' 
## ------------------------------------------------------------------------
table(mtcars$am)

#' 
## ------------------------------------------------------------------------
aggregate(mtcars$mpg, by = list(mtcars$am), FUN="mean")

#' 
## ------------------------------------------------------------------------
aggregate(mtcars$mpg, by = list(mtcars$am), FUN="var")

#' 
#' 
#' ## A research question: Is there a difference in milleage for automatic and manual cars?
#' 
## ------------------------------------------------------------------------
mtcars_mpg <- mtcars %>%
  group_by(am) %>%
  summarise(
    mean_mpg = mean(mpg),
    var_mpg = var(mpg), 
    n = n()
  )
mtcars_mpg

#' 
#' 
#' 
#' ## Continuation of Eploratory Data Analysis
#' 
## ------------------------------------------------------------------------
boxplot(mpg~am, data = mtcars)

#' 
#' ## Changing the labels of a plot; creating a new variable in a data set (`data.frame`)
#' 
#' Let us put some labels for the levels of `am`.
#' 
## ------------------------------------------------------------------------
mtcars2$amf <- factor(mtcars2$am, levels = c(0,1), labels = c("auto", "manual"))
boxplot(mpg~amf, data=mtcars2)

#' 
#' ## Changing the x and y labels and putting a title
#' 
#' Let us put some labels for the levels of `am`.
#' 
## ------------------------------------------------------------------------
boxplot(mpg~amf, data=mtcars2, 
        main = "Boxplots of miles per gallon according to transmission type",
        xlab = "Transmission type",
        ylab = "Miles per gallon")

#' 
#' ## Changing the range of values in the $y$-axis
#' 
#' Let us start the boxplot at 0.
#' 
## ------------------------------------------------------------------------
boxplot(mpg~amf, data=mtcars2, 
        main = "Boxplots of miles per gallon according to transmission type",
        xlab = "Transmission type",
        ylab = "Miles per gallon",
        ylim = c(0,35))

#' 
#' ## Plotting with `ggplot2`
#' 
## ------------------------------------------------------------------------
ggplot(mtcars2, aes(x = amf, y = mpg)) + geom_boxplot() + ylim(0,35)

#' 
## ---- eval=FALSE---------------------------------------------------------
## # What is the difference?
## ggplot(mtcars2, aes(x = amf, y = mpg)) + geom_boxplot() + coord_cartesian(ylim = c(0,35))

#' 
#' 
#' ## ggplot2 uses the language of graphics 
#' 
## ------------------------------------------------------------------------
p <- ggplot(mtcars2, aes(x = amf, y = mpg)) + 
  geom_boxplot() + 
  xlab("Transmission type") + 
  ylab("Miles per gallon") 
p

#' 
#' ## A review of t test
#' 
#' What are the assumptions of the independent samples t test?
#' 
#' 1. Dependent variable should be measured on a continuous scale (interval or ratio level)
#' 1. Independent variable consist of two categorical, independet groups
#' 1. Observations are independent of each other
#' 1. No significant outliers
#' 1. Dependent variable should be (approximately) normally distributed for each group of the independent variable
#' 1. Variances should be homogenous
#' 
#' ## Applying the assumptions
#' 
#' 1. What is the independent variable? What is the independent variable?
#' 1. Is the dependent variable measured on a continuous scale?
#' 1. Does the independent variable consist of two categorical, independent groups?
#' 1. Are observations independent of each other?
#' 1. Are there no significant outliers?
#' 1. Is the dependent variable normally distributed for each group of the independent variable?
#' 1. Are the variances homogenous?
#' 
#' ## Normality for each group of the independent variable
#' 
## ---- out.width=500, fig.height=4, fig.width=6---------------------------
ggplot(mtcars2, aes(x = mpg, fill = amf)) + geom_histogram(bins = 5) + facet_wrap(~amf, scales = "free_x")

#' 
#' ## Homogeneity of variance
#' 
## ------------------------------------------------------------------------
p

#' 
#' ## Homogeneity of variance (cont...)
#' 
## ------------------------------------------------------------------------
var.test(mpg~amf, data=mtcars2)

#' 
#' 
#' ## t test results
#' 
## ------------------------------------------------------------------------
(t1 <- t.test(mpg ~ amf, data = mtcars2))

#' 
#' ## How to use `t.test`?
#' 
## ---- echo=TRUE, eval=FALSE----------------------------------------------
## ?t.test

#' 
#' ## How about independent samples t test?
#' 
## ------------------------------------------------------------------------
(t2 <- t.test(mpg~amf, data=mtcars2, var.equal=TRUE))

#' 
#' 
#' 
#' ## Non-parametric alternative
#' 
## ------------------------------------------------------------------------
(w <- wilcox.test(mpg ~ amf, data = mtcars2, conf.int = TRUE))

#' 
#' ## Confidence intervals
#' 
## ------------------------------------------------------------------------
t1$conf.int

#' 
## ------------------------------------------------------------------------
t2$conf.int

#' 
## ------------------------------------------------------------------------
w$conf.int

#' 
#' ## Determining other values from the tests
#' 
## ------------------------------------------------------------------------
names(t1)

#' 
#' 
#' ## Conclusion of comparison of milleage according to transmission type
#' 
#' The milleage per gallon differ between manual and automatic tramission-type vehicles by about `r round(diff(t1$estimate),2)` miles per gallon at $0.05$ significance level (or 95% confidence level).
#' 
#' 
#' ## When to use one-tailed t test
#' 
## ------------------------------------------------------------------------
?t.test

#' 
#' 
## ------------------------------------------------------------------------
(t3 <- t.test(mpg ~ amf, data = mtcars2, alternative = "less"))

#' 
## ------------------------------------------------------------------------
t3 %>% broom::tidy()

#' 
#' ## Comparison of the means of three groups
#' 
#' 
## ------------------------------------------------------------------------
table(mtcars2$cyl)

#' 
## ------------------------------------------------------------------------
mtcars3 <- mtcars2 %>% select(mpg, cyl)
head(mtcars3)

#' 
#' ## Linear Model for the problem of comparing three means
#' 
#' \[ y_{ij} = \mu + \alpha_i + \varepsilon_{ij},\, i = 1, 2, 3\]
#' where:
#' 
#' * $y_{ij}=$ is the $j$th value of `mpg` in the $i$th group of `cyl`
#' * $\mu=$ mean of $Y$
#' * \(\alpha_i = \) effect of the $i$th group of `cyl` on `mpg`
#' * $\varepsilon=$ the random error due to the $j$th value of `mpg` in the $i$th value of `cyl`
#' 
#' ### Hypotheses
#' 
#' * $H_0:\alpha_1=\alpha_2=\alpha_3=0$ (equivalently: $\mu_1=\mu_2=\mu_3$)
#' * $H_a:\alpha_i\neq 0$ for at least 1 $i$ (equivalently: $\mu_a\neq \mu_b$ for at least one pair $a$ and $b$)
#' 
#' ## Exploratory data analysis of mpg in terms of cyl
#' 
## ------------------------------------------------------------------------
mtcars3 %>% group_by(cyl) %>% summarise(mean = mean(mpg), var = var(mpg), sd = sd(mpg), n = n())

#' 
#' ## Hypotheses
#' 
#' * $H_a:$ There are differences in mean milleage per gallon depending on number of the car's cylinders.
#' 
#' * $H_o:$ There are no differences in mean milleage per gallong according to the number of the car's cylinders.
#' 
#' ## Investigation of Normality and equality of variances
#' 
## ------------------------------------------------------------------------
boxplot(mpg ~ cyl, data = mtcars3)

#' 
#' ## Investigation of Normality and equality of variances
#' 
## ------------------------------------------------------------------------
ggplot(mtcars3, aes(x=cyl, y=mpg, group=cyl)) + geom_boxplot()

#' 
#' ## Analysis of variance
#' 
## ------------------------------------------------------------------------
mtcars3$cylf <- as.factor(mtcars3$cyl)
mod <- aov(mpg~cylf, data=mtcars3)
summary(mod)

#' 
## ------------------------------------------------------------------------
TukeyHSD(mod, "cylf")

#' 
#' ## More on post-hoc analysis
#' 
## ------------------------------------------------------------------------
with(mtcars3, 
pairwise.t.test(mpg, cylf, p.adjust.method = "bonferroni")
)

#' 
#' ## More on post-hoc analysis (cont...)
#' 
## ------------------------------------------------------------------------
scheffe.test(mod, "cylf", console=TRUE)

#' 
#' ## Randomized Complete Block Design
#' 
#' Suppose we want to know the effect of the number of cylinders to mpg when we group the observations by type of transmission, which we know has an effect on mpg. That is, we want to isolate the effect of cyl on mpg when we group the observations by am.
#' 
#' The linear model is
#' 
#' \[
#' y_{ij} = \mu + \alpha_i + \rho_j + \varepsilon_{ij}
#' \]
#' where
#' 
#' * $\mu=$ hypothesized mean
#' * $\rho_j=$ the effect of the $j$th blocking factor (`am`) to `mpg`
#' * $\alpha_i=$ effect of the the $i$th `cyl` to `mpg`
#' * $\varepsilon_{ij}=$ the random effect on the $ij$-th observation
#' 
#' Then the hypotheses are
#' 
#' * $H_0:\alpha_i = 0$. The number of cylinders has no effect on milleage per gallon.
#' * $H_a:\alpha_i \neq 0$. The number of cylinders affect milleage per gallon.
#' 
#' ## Exploratory Data Analysis for RCBD
#' 
## ---- out.width=500, fig.width=6, fig.height=4---------------------------
mtcars4 <- mtcars2 %>% select(mpg, am, cyl)
mtcars4$cylf <- as.factor(mtcars$cyl)
mtcars4$amf <- as.factor(mtcars$am)
ggplot(mtcars4, aes(x = cylf, y = mpg)) + 
  geom_boxplot() + 
  facet_wrap(~amf)

#' 
#' ## RCBD 
#' 
## ------------------------------------------------------------------------
mod2 <- aov(mpg ~ amf + cylf, data = mtcars4)
summary(mod2)

#' 
#' 
#' 
## ------------------------------------------------------------------------
TukeyHSD(mod2, "cylf")

#' 
#' ## Two-way ANOVA (Two-factor CBD)
#' 
#' What if prior to the experiment, we don't know the effect of any of `am` and `cyl` on `mpg`? We want to see how these factors affect `mpg` and whether they affect `mpg` independently or not.
#' 
#' * Model: $y_{ij}=\mu + \alpha_i + \beta_j + \gamma_{ij} +\varepsilon_{ij}$
#' 
#' where
#' 
#' * $\mu=$ hypothesized mean
#' * $\alpha_i=$ the effect of the $i$th type of transmission (`am`) to `mpg`
#' * $\beta_j=$ effect of the the $j$th number of cylinders (`cyl`) to `mpg`
#' * $\gamma_{ij}=$ the interaction effect of the $ij$-th type of transmission and number of cylinders
#' * $\varepsilon_{ij}=$ the random effect on the $ij$-th observation
#' 
#' ## Three pairs of hypotheses for Two-way ANOVA
#' 
#' There are three pairs of hypotheses to be tested:
#' 
#' 1. Interaction effects
#'   * $H_0:\gamma_{ij} = 0$. There is no interaction between `am` and `cyl`.
#'   * $H_a:\gamma_{ij} \neq 0$. There is an interaction between `am` and `cyl`.
#' 2. Effect of `am`
#'   * $H_0:\alpha_{i} = 0$. Controlling for other variables, `am` has no effect on `mpg`.
#'   * $H_a:\alpha_{i} \neq 0$. Controlling for other variables, `am` has an effect on `mpg`.
#' 3. Effect of `cyl`
#'   * $H_0:\beta_{j} = 0$. Controlling for other variables, `cyl` has no effect on `mpg`.
#'   * $H_a:\beta_{j} \neq 0$. Controlling for other variables, `cyl` has an effect on `mpg`.
#' 
#' 
#' ## Interaction plot
#' 
## ------------------------------------------------------------------------
with(mtcars4, interaction.plot(cylf, amf, mpg, fun = mean))

#' 
#' ## Interaction plot with `ggplot2`
#' 
#' Challenge: Create an interaction plot using `ggplot2`.
#' 
## ---- echo=FALSE, eval=TRUE, out.width=500, fig.height=5-----------------
mtcars4 %>% group_by(am, cyl) %>%
  summarise(mean = mean(mpg)) %>%
  ggplot(aes(cyl, mean, group = am, color = as.factor(am))) + geom_line() +
  theme(legend.text = element_text("Transmission\ntype")) + theme_bw()

#' 
#' 
#'   
#' ## How to do two-way ANOVA in R
#' 
## ------------------------------------------------------------------------
mod4 <- aov(mpg ~ amf * cylf, data = mtcars4)
summary(mod4)

#' 
#' ## Conclusions from two-way ANOVA
#' 
#' 1. There is no interaction between `am` and `cyl`.
#' 1. `cyl` affects `mpg`.
#' 1. `am` affects `mpg`.
#' 
#' ## Post hoc analyses for two-way ANOVA
#' 
## ------------------------------------------------------------------------
TukeyHSD(mod4, "cylf")

#' 
## ------------------------------------------------------------------------
TukeyHSD(mod4, "amf")

#' 
#' ## Finding relationships
#' 
#' Try any of the following codes to plot `mpg` against `disp` in the `mtcars` package.
#' 
## ---- eval=FALSE---------------------------------------------------------
## plot(mpg~disp, data = mtcars)

#' 
## ---- eval = FALSE-------------------------------------------------------
## plot(mtcars$disp, mtcars$mpg)

#' 
## ------------------------------------------------------------------------
with(mtcars, plot(disp, mpg))

#' 
#' ## Scatterplot with `ggplot2`
#' 
## ------------------------------------------------------------------------
ggplot(mtcars, aes(x = disp, y = mpg)) + geom_point()

#' 
#' ## Correlation between `disp` and `mpg`
#' 
#' * Research problem: What is the relationship between `disp` and `mpg`?
#' * More specific research problem: Is there a linear relationship between `disp` and `mpg`?
#' * How does a scatterplot of no relationship between two variables look like?
#' 
## ------------------------------------------------------------------------
set.seed(1); x = runif(100)
set.seed(2); y = runif(100)
plot(x,y)

#' 
#' 
## ------------------------------------------------------------------------
with(mtcars, cor(disp, mpg))

#' 
## ------------------------------------------------------------------------
with(mtcars, cor.test(disp, mpg))

#' 
#' ## Remember, correlation does not imply causation
#' 
#' But in controlled experiments where you test the variation in the dependent variable by manipulating the values of the independent variable, you can investigate causation.
#' 
#' Suppose we want to investigate whether `disp` has an effect on `mpg`.
#' 
#' The model is a linear regression of `mpg` on `disp`: 
#' \[y = \beta_0 + \beta x + \varepsilon\]
#' where
#' 
#' * $y=$ `mpg`
#' * $x=$ `disp`
#' * $\beta_0=$ intercept
#' * $\beta=$ the increase in `mpg` for every 1 unit increase in `disp`
#' * $\varepsilon=$ random error
#' 
#' ## Plotting the line of best fit
#' 
## ------------------------------------------------------------------------
mod5 <- lm(mpg~disp, data = mtcars)
with(mtcars, plot(disp, mpg))
abline(mod5)

#' 
#' ## Plotting the line of best fit with ggplot2
#' 
## ------------------------------------------------------------------------
ggplot(mtcars, aes(disp, mpg)) + geom_point() + geom_smooth(method="lm", se=FALSE)

#' 
#' ## Testing the linear fit
#' 
## ------------------------------------------------------------------------
summary(mod5)

#' ## Results 
#' 
#' We have the following results from this output:
#' 
#' * The line of best fit has an equation: $y = 29.60 - 0.0412 x$. 
#' * `disp` has an affect on `mpg` at the .05 significance level ($p=9.38\times 10^{-10}$)
#' * `disp` explains about 72% of the variation in `mpg`
#' 
#' ## Four Principal Assumptions of linear regression
#' 
#' * **Linearity and additivity** of the relationship between dependent and independent variables / **Linearity of residuals**
#' * **Statistical independence** of the errors/residuals
#' * **Homoscedasticity** (equal variance) of the errors/residuals
#' * **Normality** of errors/residuals
#' 
#' ## Testing the linear fit
#' 
## ---- out.width=400------------------------------------------------------
par(mfrow=c(2,2))
plot(mod5)

#' 
#' ## Interpreting the diagnostic plots
#' 
#' * The **residuals vs fitted** plot shows if residuals have non-linear patterns. This plot should show equally spread residuals around a horizontal line without distinct pattern.
#' * The **Normal Q-Q Plot** shows if the residuals are normally distributed. The residuals should follow a straight line well.
#' * The **Scale-Location Plot** shows if residuals are spread equally along the ranges of predictors. This plot can be used to check the assumption of equal variance (homoscedasticity). It should show a horizontal line with equally (randomly) spread points.
#' * The **Residuals vs Leverage Plot** helps us find influential cases (or subjects/observations) if any. There should be no points outside the dashed lines (or Cook's distance)
#' 
#' 
#' 
#' ## Transformations
#' 
## ------------------------------------------------------------------------
ggplot(mtcars, aes(log(disp), mpg)) + geom_point() + geom_smooth(method="lm")

#' 
#' ## Regression with log transformation
#' 
## ------------------------------------------------------------------------
mod6 <- lm(mpg~log(disp), data=mtcars)
summary(mod6)

#' 
#' ## Diagnostic plots of `mod6`
#' 
## ------------------------------------------------------------------------
par(mfrow=c(2,2))
plot(mod6)

#' 
#' ## Interpretation of `mod6`
#' 
#' * The linear fit improved as the log of `disp` now explains about 82% of the variation in `mpg`.
#' * However, how do we now interpret the results?
#' 
#' 
#' 
#' ## Removing the influential observations
#' 
## ------------------------------------------------------------------------
mtcars7 <- mtcars %>% filter(!rownames(.) %in% c("Pontiac Firebird",
"Toyota Corolla",
"Hornet Sportabout"))
mod7 <- lm(mpg~disp, data = mtcars7)
par(mfrow=c(2,2))
plot(mod7)

#' 
#' ## Effect of removing influential observations
#' 
## ------------------------------------------------------------------------
summary(mod7)

#' 
#' ## Plot without influential observations
#' 
## ------------------------------------------------------------------------
ggplot(mtcars7, aes(disp, mpg)) + geom_point()


#' 
#' 
#' 
#' ## Trying transformations
#' 
## ---- out.width=500------------------------------------------------------
mod8 <- lm(mpg~log(disp), data=mtcars7)
plot(mpg~log(disp), data=mtcars7)
abline(mod8)

#' 
#' ## Diagnostic plots of `mod8`
#' 
## ------------------------------------------------------------------------
par(mfrow=c(2,2))
plot(mod8)

#' 
#' 
#' 
#' ## Fit of `mod8`
#' 
## ------------------------------------------------------------------------
summary(mod8)

#' 
#' ## Multiple regression
#' 
## ------------------------------------------------------------------------
head(mtcars)
mtcars5 <- mtcars %>%
  mutate(
    cyl = as.factor(cyl),
    vs = as.factor(vs),
    am = as.factor(am),
    gear = as.factor(gear),
    carb = as.factor(carb)
  )

#' 
#' ## Continuation of Multiple Regression
#' 
## ------------------------------------------------------------------------
mod7 <- lm(mpg~., data=mtcars5)
par(mfrow=c(2,2))
plot(mod7)

#' 
#' ## Step-wise regression
#' 
## ---- message=FALSE, warning=FALSE---------------------------------------
mod8 <- step(mod7, direction="both", trace=FALSE)
summary(mod8)

#' 
#' ## Diagnosic plots of result of step-wise regression
#' 
## ------------------------------------------------------------------------
par(mfrow=c(2,2))
plot(mod8)

#' 
#' ## Prediction (for Demonstration Only)
#' 
#' https://stats.stackexchange.com/questions/244017/prediction-vs-inference
#' 
#' * Inference: Given a set of data you want to infer how the output is generated as a function of the data.
#' 
#' * Prediction: Given a new measurement, you want to use an existing data set to build a model that reliably chooses the correct identifier from a set of outcomes.
#' 
#' * Inference: You want to find out what the effect of Age, Passenger Class and, Gender has on surviving the Titanic Disaster. You can put up a logistic regression and infer the effect each passenger characteristic has on survival rates.
#' 
#' * Prediction: Given some information on a Titanic passenger, you want to choose from the set {lives,dies}
#' and be correct as often as possible. (See bias-variance tradeoff for prediction in case you wonder how to be correct as often as possible.) 
#' 
#' 
#' ## Let us use `mod5` for prediction
#' 
## ------------------------------------------------------------------------
newdata <- data.frame(disp = sample(mtcars$disp,5) + rnorm(5))
predict(mod5, newdata, interval="prediction")

#' 
#' ## For More on Prediction and Machine Learning
#' 
#' * https://www.datacamp.com/community/tutorials/machine-learning-in-r
#' * https://machinelearningmastery.com/machine-learning-in-r-step-by-step/
#' * https://www.coursera.org/learn/practical-machine-learning
#' * https://www.kaggle.com
#' * https://www.kdnuggets.com/2017/04/10-free-must-read-books-machine-learning-data-science.html
#' 
#' ## Challenge: multiple linear regression
#' 
#' Using the `diamonds` data set, create a model for pricing diamonds based on the other variables.
#' 
## ---- echo=TRUE, eval=FALSE----------------------------------------------
## ?diamonds
## head(diamonds)

#' 
#' 
#' ## [Thank you!](https://stackoverflow.com/questions/8082429/plot-a-heart-in-r)
#' 
## ---- eval=FALSE---------------------------------------------------------
## library(ggplot2)
## dat <- data.frame(x=seq(0, 2*pi, length.out=100))
## shape <- function(x)2-2*sin(x) + sin(x)*(sqrt(abs(cos(x))))/(sin(x)+1.4)
## ggplot(dat, aes(x=x)) + stat_function(fun=shape) + coord_polar(start=-pi/2)

#' 
#' 
#' 
#' [1]: https://www.datasciencecentral.com/profiles/blogs/list-of-companies-using-r
#' [2]: https://www.r-project.org/about.html
#' 
#' 
#' ## References
