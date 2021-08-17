## ----style, echo=FALSE, results="asis", message=FALSE-------------------------
knitr::opts_chunk$set(tidy = FALSE,
		   message = FALSE)

library("grid")
library("ggplot2")
library("ggfun")
theme_set(theme_grey())

## -----------------------------------------------------------------------------
library("grid")
library("ggplot2")
library("ggfun")

## -----------------------------------------------------------------------------
p <- ggplot(mpg, aes(displ, cty)) + geom_point()
p <- p + facet_grid(cols = vars(cyl))
p <- p + theme(strip.background=element_roundrect(fill="grey40", color=NA, r=0.15))
p

## -----------------------------------------------------------------------------
p2 <- ggplot(mtcars, aes(mpg, disp, color=factor(cyl), size=cyl)) +
         geom_point()
p2 + theme(legend.background=element_roundrect(color="#808080", linetype=2))

## -----------------------------------------------------------------------------
p <- ggplot(mtcars, aes(mpg, disp)) + geom_point()
data <- data.frame(colour = c("red",  "blue"), VALUE = c("A", "B"))
gglegend(aes(colour = VALUE, label=VALUE), data, geom_text, p)

## -----------------------------------------------------------------------------
d <- data.frame(x=rnorm(10), y=rnorm(10), lab=LETTERS[1:10])
p <- ggplot(d, aes(x, y)) + geom_text(aes(label=lab), size=5)
set_font(p, family="Times", fontface="italic", color='firebrick')

